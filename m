Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A290C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F1122419
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dSCV0vwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F1122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED11B16D5;
	Wed, 20 Nov 2019 12:18:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED11B16D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574248754;
	bh=1dsrKWSkVBY2DBGI9sbVq4AB+Y5T3CjbDeIiiEcduTg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSCV0vwMdk3+Y642lG6cpS1A7x5AiAOu4alCwu9MaxypI6inC7JoxhQ9vB9zmWbGT
	 /N0tWJHzwGYkIVq6KmudjvuSP0KhPLpjq3PjVGSzZjmqPIZaGwiupo27CUBG17QnET
	 HHOg4gA+dzNaHlljwiNTu5K3zho1kdN/VGDd6m80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94140F802EA;
	Wed, 20 Nov 2019 12:02:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5551BF8013D; Wed, 20 Nov 2019 11:58:36 +0100 (CET)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A68B6F800FF
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 11:58:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A68B6F800FF
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 469c83978beedbff; Wed, 20 Nov 2019 11:58:32 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Wed, 20 Nov 2019 11:58:31 +0100
Message-ID: <7338293.UcAxln0NAJ@kreacher>
In-Reply-To: <20191119002121.4107-12-sean.j.christopherson@intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119002121.4107-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 Nov 2019 12:02:18 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jie Yang <yang.jie@linux.intel.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Len Brown <len.brown@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 platform-driver-x86@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
Subject: Re: [alsa-devel] [PATCH 11/12] ACPI/sleep: Convert
	acpi_wakeup_address into a function
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

On Tuesday, November 19, 2019 1:21:20 AM CET Sean Christopherson wrote:
> Convert acpi_wakeup_address from a raw variable into a function so that
> x86 can wrap its dereference of the real mode boot header in a function
> instead of broadcasting it to the world via a #define.  This sets the
> stage for a future patch to move the definition of acpi_wakeup_address()
> out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/ia64/include/asm/acpi.h | 5 ++++-
>  arch/ia64/kernel/acpi.c      | 2 --
>  arch/x86/include/asm/acpi.h  | 5 ++++-
>  drivers/acpi/sleep.c         | 4 ++--
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
> index f886d4dc9d55..36d7003eee71 100644
> --- a/arch/ia64/include/asm/acpi.h
> +++ b/arch/ia64/include/asm/acpi.h
> @@ -38,7 +38,10 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  /* Low-level suspend routine. */
>  extern int acpi_suspend_lowlevel(void);
>  
> -extern unsigned long acpi_wakeup_address;
> +static inline unsigned long acpi_wakeup_address(void)
> +{
> +	return 0;
> +}
>  
>  /*
>   * Record the cpei override flag and current logical cpu. This is
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 70d1587ddcd4..a5636524af76 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -42,8 +42,6 @@ int acpi_lapic;
>  unsigned int acpi_cpei_override;
>  unsigned int acpi_cpei_phys_cpuid;
>  
> -unsigned long acpi_wakeup_address = 0;
> -
>  #define ACPI_MAX_PLATFORM_INTERRUPTS	256
>  
>  /* Array to record platform interrupt vectors for generic interrupt routing. */
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index bc9693c9107e..57788ec6fa82 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -62,7 +62,10 @@ static inline void acpi_disable_pci(void)
>  extern int (*acpi_suspend_lowlevel)(void);
>  
>  /* Physical address to resume after wakeup */
> -#define acpi_wakeup_address ((unsigned long)(real_mode_header->wakeup_start))
> +static inline unsigned long acpi_wakeup_address(void)
> +{
> +	return ((unsigned long)(real_mode_header->wakeup_start));
> +}
>  
>  /*
>   * Check if the CPU can handle C2 and deeper
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2af937a8b1c5..9e66c4109556 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  #ifdef CONFIG_ACPI_SLEEP
>  	/* do we have a wakeup address for S2 and S3? */
>  	if (acpi_state == ACPI_STATE_S3) {
> -		if (!acpi_wakeup_address)
> +		if (!acpi_wakeup_address())
>  			return -EFAULT;
> -		acpi_set_waking_vector(acpi_wakeup_address);
> +		acpi_set_waking_vector(acpi_wakeup_address());
>  
>  	}
>  	ACPI_FLUSH_CPU_CACHE();
> 




_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
