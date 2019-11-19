Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084CAC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:06:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829D020857
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l0UKjD+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829D020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C60A7169D;
	Wed, 20 Nov 2019 12:05:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C60A7169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574247969;
	bh=df3uL3qGxcoRrkOK6JqX+5uFfRG1XfwlDoTwT4u1Jx0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0UKjD+SnqA0p7Jv3hIfcwvJWoqCeatbHRyc9ewfYvIp9l+kdjcLG422uU9uZDOnx
	 cDql39oM1anpeyOvFbcWJumBgKVHo2u3fbeTk+DC7Ro+A+Qsev7718pGz4KkOqxwCU
	 oj/lDUfZ969kqOaV13omDaZRLGxY7dCirblho0sk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FEF9F80160;
	Wed, 20 Nov 2019 12:02:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6559EF80146; Tue, 19 Nov 2019 01:21:47 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48018F800F1
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 01:21:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48018F800F1
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 16:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; d="scan'208";a="215412016"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 16:21:37 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>
Date: Mon, 18 Nov 2019 16:21:10 -0800
Message-Id: <20191119002121.4107-2-sean.j.christopherson@intel.com>
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
Subject: [alsa-devel] [PATCH 01/12] x86/efi: Explicitly include realmode.h
	to handle RM trampoline quirk
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

Explicitly include asm/realmode.h, which is needed to handle a real mode
trampoline quirk in efi_free_boot_services(), instead of picking it up
by way of linux/acpi.h.  acpi.h will soon stop including realmode.h so
that changing realmode.h doesn't require a full kernel rebuild.

Fixes: 5bc653b731821 ("x86/efi: Allocate a trampoline if needed in efi_free_boot_services()")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/platform/efi/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..f9ef5c5346ca 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -16,6 +16,7 @@
 #include <asm/efi.h>
 #include <asm/uv/uv.h>
 #include <asm/cpu_device_id.h>
+#include <asm/realmode.h>
 #include <asm/reboot.h>
 
 #define EFI_MIN_RESERVE 5120
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
