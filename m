From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Mon, 24 Aug 2015 13:39:10 +0100
Message-ID: <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

Some drivers might require to send ipi to other cores. So export it.
This will be used later by AXD driver.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-mips-gic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff4be0515a0d..fc6fd506cd7e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -227,6 +227,7 @@ void gic_send_ipi(unsigned int intr)
 {
 	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
 }
+EXPORT_SYMBOL(gic_send_ipi);
 
 int gic_get_c0_compare_int(void)
 {
-- 
2.1.0
