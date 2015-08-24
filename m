From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 08/10] ALSA: axd: add low level AXD platform setup files
Date: Mon, 24 Aug 2015 13:39:17 +0100
Message-ID: <1440419959-14315-9-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

At the moment AXD runs on MIPS cores only. These files provide
basic functionality to prepare AXD f/w to bootstrap itself and
do low level interrupt/kick when being initialised from a mips
core.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/img/axd/axd_platform.h      |  35 +++
 sound/soc/img/axd/axd_platform_mips.c | 416 ++++++++++++++++++++++++++++++++++
 2 files changed, 451 insertions(+)
 create mode 100644 sound/soc/img/axd/axd_platform.h
 create mode 100644 sound/soc/img/axd/axd_platform_mips.c

diff --git a/sound/soc/img/axd/axd_platform.h b/sound/soc/img/axd/axd_platform.h
new file mode 100644
index 000000000000..f9cc3c308a4a
--- /dev/null
+++ b/sound/soc/img/axd/axd_platform.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Platform Specific helper functions.
+ */
+#ifndef AXD_PLATFORM_H_
+#define AXD_PLATFORM_H_
+#include "axd_module.h"
+
+void axd_platform_init(struct axd_dev *axd);
+void axd_platform_set_pc(unsigned long pc);
+int axd_platform_start(void);
+void axd_platform_stop(void);
+unsigned int axd_platform_num_threads(void);
+void axd_platform_kick(void);
+void axd_platform_irq_ack(void);
+void axd_platform_print_regs(void);
+
+/*
+ * protect against simultaneous access to shared memory mapped registers area
+ * between axd and the host
+ */
+unsigned long axd_platform_lock(void);
+void axd_platform_unlock(unsigned long flags);
+
+#endif /* AXD_PLATFORM_H_ */
diff --git a/sound/soc/img/axd/axd_platform_mips.c b/sound/soc/img/axd/axd_platform_mips.c
new file mode 100644
index 000000000000..ac1cf5eb8a64
--- /dev/null
+++ b/sound/soc/img/axd/axd_platform_mips.c
@@ -0,0 +1,416 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This file implements running AXD as a single VPE along side linux on the same
+ * core.
+ */
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irqchip/mips-gic.h>
+#include <linux/spinlock.h>
+
+#include <asm/cpu-features.h>
+#include <asm/hazards.h>
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <asm/tlbmisc.h>
+
+#include "axd_module.h"
+#include "axd_platform.h"
+
+
+static unsigned int axd_irqnum;
+static unsigned int axd_irq;
+static unsigned int axd_vpe;
+static spinlock_t lock;
+static unsigned long smpirqflags;
+
+
+static void _axd_platform_init(void *info)
+{
+	unsigned int val;
+	unsigned long irqflags;
+	unsigned long mtflags;
+
+	/*
+	 * make sure nothing else on this vpe or another vpe can try to modify
+	 * any of the shared registers below
+	 */
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	/* EVP = 0, VPC = 1 */
+	val = read_c0_mvpcontrol();
+	val &= ~MVPCONTROL_EVP;
+	val |= MVPCONTROL_VPC;
+	write_c0_mvpcontrol(val);
+	instruction_hazard();
+
+	/* prepare TC for setting up */
+	settc(axd_vpe);
+	write_tc_c0_tchalt(1);
+
+	/* make sure no interrupts are pending and exceptions bits are clear */
+	write_vpe_c0_cause(0);
+	write_vpe_c0_status(0);
+
+	/* bind TC to VPE */
+	val = read_tc_c0_tcbind();
+	val |= (axd_vpe << TCBIND_CURTC_SHIFT) | (axd_vpe << TCBIND_CURVPE_SHIFT);
+	write_tc_c0_tcbind(val);
+
+	/* VPA = 1, MVP = 1 */
+	val = read_vpe_c0_vpeconf0();
+	val |= VPECONF0_MVP;
+	val |= VPECONF0_VPA;
+	write_vpe_c0_vpeconf0(val);
+
+	/* A = 1, IXMT = 0 */
+	val = read_tc_c0_tcstatus();
+	val &= ~TCSTATUS_IXMT;
+	val |= TCSTATUS_A;
+	write_tc_c0_tcstatus(val);
+
+	/* TE = 1 */
+	val = read_vpe_c0_vpecontrol();
+	val |= VPECONTROL_TE;
+	write_vpe_c0_vpecontrol(val);
+
+	/* EVP = 1, VPC = 0 */
+	val = read_c0_mvpcontrol();
+	val |= MVPCONTROL_EVP;
+	val &= ~MVPCONTROL_VPC;
+	write_c0_mvpcontrol(val);
+	instruction_hazard();
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+void axd_platform_init(struct axd_dev *axd)
+{
+	struct cpumask cpumask;
+
+	axd_irqnum = axd->irqnum;
+	axd_irq = axd->axd_irq;
+	axd_vpe = axd->vpe;
+	spin_lock_init(&lock);
+
+	/*
+	 * ensure axd irq runs on cpu 0 only as it's the only one that can use
+	 * MT to communicate with AXD
+	 */
+	cpumask_clear(&cpumask);
+	cpumask_set_cpu(0, &cpumask);
+	irq_set_affinity_hint(axd_irqnum, &cpumask);
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * offline the cpu before we do anything
+	 * it's best effort here since the cpu could already be offline, hence
+	 * we ignore the return value.
+	 */
+	cpu_down(axd_vpe);
+#endif
+
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can start AXD, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_init, NULL, 1);
+		return;
+	}
+
+	_axd_platform_init(NULL);
+}
+
+static void _reset(void *info)
+{
+	unsigned int val;
+	unsigned long irqflags;
+	unsigned long mtflags;
+
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	settc(axd_vpe);
+	/* first stop TC1 */
+	write_tc_c0_tchalt(1);
+
+	/* clear EXL and ERL from TCSTATUS */
+	val = read_c0_tcstatus();
+	val &= ~(ST0_EXL | ST0_ERL);
+	write_c0_tcstatus(val);
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+static void reset(void)
+{
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can reset AXD, so send it a message to do so */
+		smp_call_function_single(0, &_reset, NULL, 1);
+		return;
+	}
+
+	_reset(NULL);
+}
+
+static void _axd_platform_set_pc(void *info)
+{
+	unsigned long irqflags;
+	unsigned long mtflags;
+	unsigned long pc = *(unsigned long *)info;
+
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	settc(axd_vpe);
+	write_tc_c0_tcrestart(pc);
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+void axd_platform_set_pc(unsigned long pc)
+{
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can set AXD PC, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_set_pc, &pc, 1);
+		return;
+	}
+
+	_axd_platform_set_pc(&pc);
+}
+
+static void thread_control(int start)
+{
+	unsigned long irqflags;
+	unsigned long mtflags;
+
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	settc(axd_vpe);
+	/* start/stop the VPE */
+	write_tc_c0_tchalt(!start);
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+static void _axd_platform_start(void *info)
+{
+	reset();
+	thread_control(1);
+}
+
+int axd_platform_start(void)
+{
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can start AXD, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_start, NULL, 1);
+		return 0;
+	}
+
+	_axd_platform_start(NULL);
+
+	return 0;
+}
+
+static void _axd_platform_stop(void *info)
+{
+	thread_control(0);
+}
+
+void axd_platform_stop(void)
+{
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can stop AXD, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_stop, NULL, 1);
+		return;
+	}
+
+	_axd_platform_stop(NULL);
+}
+
+unsigned int axd_platform_num_threads(void)
+{
+	return 1;
+}
+
+static void _axd_platform_kick_sw1(void *info)
+{
+	unsigned int val;
+	unsigned long irqflags;
+	unsigned long mtflags;
+
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	settc(axd_vpe);
+	val = read_vpe_c0_cause();
+	val |= CAUSEF_IP1;
+	write_vpe_c0_cause(val);
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+void axd_platform_kick(void)
+{
+	/*
+	 * ensure all writes to shared uncached memory are visible to AXD
+	 * before sending interrupt
+	 */
+	wmb();
+
+	if (axd_irq) {
+		gic_send_ipi(axd_irq);
+		return;
+	}
+
+	/* fallback to sending interrupt at SW1 */
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can send AXD SW1, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_kick_sw1, NULL, 1);
+		return;
+	}
+
+	_axd_platform_kick_sw1(NULL);
+}
+
+static void axd_smp_platform_lock(void *info)
+{
+	unsigned long *flags = info;
+
+	/*
+	 * prevent AXD irq handler from accessing the lock while another
+	 * processor holds it
+	 */
+	disable_irq(axd_irqnum);
+	*flags = dvpe();
+}
+
+inline unsigned long axd_platform_lock(void)
+{
+	unsigned long irqflags;
+
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can lock AXD out, so send it a message to do so */
+		unsigned long flags;
+
+		spin_lock(&lock); /* serialise other smp cpus to access the lock */
+		smp_call_function_single(0, &axd_smp_platform_lock, &flags, 1);
+		return flags;
+	}
+
+	/*
+	 * When not servicing AXD irq then another task is trying to acquire the
+	 * lock, in this case we need to acquire the spinlock without spinning
+	 * because cpu0 must keep on running to service other cpus requests..
+	 */
+	if (!in_interrupt())
+		while (!spin_trylock(&lock))
+			cpu_relax();
+
+	/* prevent other cpus from acquiring the lock while we hold it */
+	local_irq_save(irqflags);
+	smpirqflags = irqflags;
+	return dvpe();
+}
+
+static void axd_smp_platform_unlock(void *info)
+{
+	unsigned long *flags = info;
+
+	evpe(*flags);
+	enable_irq(axd_irqnum);
+}
+
+inline void axd_platform_unlock(unsigned long flags)
+{
+	if (smp_processor_id() != 0) {
+		smp_call_function_single(0, &axd_smp_platform_unlock, &flags, 1);
+		spin_unlock(&lock);
+		return;
+	}
+	evpe(flags);
+	local_irq_restore(smpirqflags);
+	if (!in_interrupt())
+		spin_unlock(&lock);
+}
+
+inline void axd_platform_irq_ack(void)
+{
+}
+
+static void print_regs(unsigned int thread)
+{
+	unsigned long irqflags;
+	unsigned long mtflags;
+
+	local_irq_save(irqflags);
+	mtflags = dvpe();
+
+	settc(thread);
+	pr_err("PC:\t\t0x%08lX\n", read_tc_c0_tcrestart());
+	pr_err("STATUS:\t\t0x%08lX\n", read_vpe_c0_status());
+	pr_err("CAUSE:\t\t0x%08lX\n", read_vpe_c0_cause());
+	pr_err("EPC:\t\t0x%08lX\n", read_vpe_c0_epc());
+	pr_err("EBASE:\t\t0x%08lX\n", read_vpe_c0_ebase());
+	pr_err("BADVADDR:\t0x%08lX\n", read_vpe_c0_badvaddr());
+	pr_err("CONFIG:\t\t0x%08lX\n", read_vpe_c0_config());
+	pr_err("MVPCONTROL:\t0x%08X\n", read_c0_mvpcontrol());
+	pr_err("VPECONTROL:\t0x%08lX\n", read_vpe_c0_vpecontrol());
+	pr_err("VPECONF0:\t0x%08lX\n", read_vpe_c0_vpeconf0());
+	pr_err("TCBIND:\t\t0x%08lX\n", read_tc_c0_tcbind());
+	pr_err("TCSTATUS:\t0x%08lX\n", read_tc_c0_tcstatus());
+	pr_err("TCHALT:\t\t0x%08lX\n", read_tc_c0_tchalt());
+	pr_err("\n");
+	pr_err("$0: 0x%08lX\tat: 0x%08lX\tv0: 0x%08lX\tv1: 0x%08lX\n",
+				mftgpr(0), mftgpr(1), mftgpr(2), mftgpr(3));
+	pr_err("a0: 0x%08lX\ta1: 0x%08lX\ta2: 0x%08lX\ta3: 0x%08lX\n",
+				mftgpr(4), mftgpr(5), mftgpr(6), mftgpr(7));
+	pr_err("t0: 0x%08lX\tt1: 0x%08lX\tt2: 0x%08lX\tt3: 0x%08lX\n",
+				mftgpr(8), mftgpr(9), mftgpr(10), mftgpr(11));
+	pr_err("t4: 0x%08lX\tt5: 0x%08lX\tt6: 0x%08lX\tt7: 0x%08lX\n",
+				mftgpr(12), mftgpr(13), mftgpr(14), mftgpr(15));
+	pr_err("s0: 0x%08lX\ts1: 0x%08lX\ts2: 0x%08lX\ts3: 0x%08lX\n",
+				mftgpr(16), mftgpr(17), mftgpr(18), mftgpr(19));
+	pr_err("s4: 0x%08lX\ts5: 0x%08lX\ts6: 0x%08lX\ts7: 0x%08lX\n",
+				mftgpr(20), mftgpr(21), mftgpr(22), mftgpr(23));
+	pr_err("t8: 0x%08lX\tt9: 0x%08lX\tk0: 0x%08lX\tk1: 0x%08lX\n",
+				mftgpr(24), mftgpr(25), mftgpr(26), mftgpr(27));
+	pr_err("gp: 0x%08lX\tsp: 0x%08lX\ts8: 0x%08lX\tra: 0x%08lX\n",
+				mftgpr(28), mftgpr(29), mftgpr(30), mftgpr(31));
+
+	evpe(mtflags);
+	local_irq_restore(irqflags);
+}
+
+static void _axd_platform_print_regs(void *info)
+{
+	pr_err("VPE%d regs dump\n", axd_vpe);
+	print_regs(axd_vpe);
+}
+
+void axd_platform_print_regs(void)
+{
+	if (smp_processor_id() != 0) {
+		/* only cpu 0 can read AXD regs, so send it a message to do so */
+		smp_call_function_single(0, &_axd_platform_print_regs, NULL, 1);
+		return;
+	}
+
+	_axd_platform_print_regs(NULL);
+}
-- 
2.1.0
