Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB8C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:13:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD4222365
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XhW/Znua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD4222365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 033DA16F2;
	Wed, 20 Nov 2019 12:12:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 033DA16F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574248403;
	bh=Q0Bzmz9UAX5p8q1Ly/JuyTkMNusGtSq5y8F/rJ7tr5A=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XhW/ZnuapXoj2OReDZhiPB8eGQ0FAbO675GpQcugUWiTeBG8/J+2cOHAUMf48H3YL
	 puL86/agBN6E4fW/Mj1vtR+8NA3wMtCZs/tVl2JJwy3s1DiLIiw8KW0vQqKQn+YxXp
	 PN/j5dE7vVPJSatOH1olMgBa5kTA/wEVYSQa8znE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E08DF8025A;
	Wed, 20 Nov 2019 12:02:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 990D2F8013D; Tue, 19 Nov 2019 01:21:57 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A291F80100
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 01:21:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A291F80100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 16:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; d="scan'208";a="215412063"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 16:21:51 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>
Date: Mon, 18 Nov 2019 16:21:21 -0800
Message-Id: <20191119002121.4107-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119002121.4107-1-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 Nov 2019 12:02:18 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, "VMware, Inc." <pv-drivers@vmware.com>,
 Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Nadav Amit <namit@vmware.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
 platform-driver-x86@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
Subject: [alsa-devel] [PATCH 12/12] x86/ACPI/sleep: Move
	acpi_wakeup_address() definition into sleep.c
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Move the definition of acpi_wakeup_address() into sleep.c to break
linux/acpi.h's dependency (by way of asm/acpi.h) on asm/realmode.h.
Everyone and their mother includes linux/acpi.h, i.e. modifying
realmode.h results in a full kernel rebuild, which makes the already
inscrutable real mode boot code even more difficult to understand and is
positively rage inducing when trying to make changes to x86's boot flow.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/acpi.h  |  6 +-----
 arch/x86/kernel/acpi/sleep.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 57788ec6fa82..0cae3f773d44 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -13,7 +13,6 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
-#include <asm/realmode.h>
 #include <asm/x86_init.h>
 
 #ifdef CONFIG_ACPI_APEI
@@ -62,10 +61,7 @@ static inline void acpi_disable_pci(void)
 extern int (*acpi_suspend_lowlevel)(void);
 
 /* Physical address to resume after wakeup */
-static inline unsigned long acpi_wakeup_address(void)
-{
-	return ((unsigned long)(real_mode_header->wakeup_start));
-}
+unsigned long acpi_wakeup_address(void);
 
 /*
  * Check if the CPU can handle C2 and deeper
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index ca13851f0570..44d3fb1a1de3 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -26,6 +26,17 @@ unsigned long acpi_realmode_flags;
 static char temp_stack[4096];
 #endif
 
+/**
+ * acpi_wakeup_address - provide physical address for S3 wakeup
+ *
+ * Returns the physical address where the kernel should be resumed after the
+ * system awakes from S3, e.g. for programming into the firmware waking vector.
+ */
+unsigned long acpi_wakeup_address(void)
+{
+	return ((unsigned long)(real_mode_header->wakeup_start));
+}
+
 /**
  * x86_acpi_enter_sleep_state - enter sleep state
  * @state: Sleep state to enter.
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
