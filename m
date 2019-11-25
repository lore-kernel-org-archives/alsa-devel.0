Return-Path: <SRS0=hmI4=ZT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE2C432C3
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:40:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1D52070B
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m6bfwRC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1D52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E93216F8;
	Wed, 27 Nov 2019 07:39:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E93216F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574836803;
	bh=JtbcQ0NYXkjONF/bdIV9cO9gw2ZvantDatQED/i/HoA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6bfwRC23+NCdoQb64DvCWE9LjKar6dFyzggxvsBmrj57458fMW09NEgU7XduVnQN
	 E5mBpR/j0yN4bXLabz7RRtPG6gwbgPmyJx/G3/mSv65szy4fCaLgTbG0SBIMKKUMMB
	 NZ+dKXXqitggzb3u7wLC2XHaiorPMOG70BCzekDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F2E1F8013B;
	Wed, 27 Nov 2019 07:39:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC09DF8016F; Mon, 25 Nov 2019 18:00:41 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60275F800E5
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2019 18:00:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60275F800E5
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 09:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; d="scan'208";a="216967925"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.41])
 by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2019 09:00:34 -0800
Date: Mon, 25 Nov 2019 09:00:34 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Message-ID: <20191125170034.GB12178@linux.intel.com>
References: <20191119002121.4107-1-sean.j.christopherson@intel.com>
 <20191119002121.4107-12-sean.j.christopherson@intel.com>
 <7338293.UcAxln0NAJ@kreacher>
 <20191125104803.v6goacte2vjakx64@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191125104803.v6goacte2vjakx64@ucw.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Wed, 27 Nov 2019 07:39:09 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jie Yang <yang.jie@linux.intel.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Nadav Amit <namit@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-acpi@vger.kernel.org, x86@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Len Brown <len.brown@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 platform-driver-x86@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>,
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

On Mon, Nov 25, 2019 at 11:48:03AM +0100, Pavel Machek wrote:
> > On Tuesday, November 19, 2019 1:21:20 AM CET Sean Christopherson wrote:
> > > Convert acpi_wakeup_address from a raw variable into a function so that
> > > x86 can wrap its dereference of the real mode boot header in a function
> > > instead of broadcasting it to the world via a #define.  This sets the
> > > stage for a future patch to move the definition of acpi_wakeup_address()
> > > out of asm/acpi.h and thus break acpi.h's dependency on asm/realmode.h.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -63,9 +63,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
> > >  #ifdef CONFIG_ACPI_SLEEP
> > >  	/* do we have a wakeup address for S2 and S3? */
> > >  	if (acpi_state == ACPI_STATE_S3) {
> > > -		if (!acpi_wakeup_address)
> > > +		if (!acpi_wakeup_address())
> > >  			return -EFAULT;
> > > -		acpi_set_waking_vector(acpi_wakeup_address);
> > > +		acpi_set_waking_vector(acpi_wakeup_address());
> > >  
> 
> You might want to store result in a variable... especially since you are
> turning inline function into real one in a next patch.
> 
> And maybe function should be called get_acip_wakeup_address or
> something? This way it is easy to mistake actual wakeup address from
> function that gets it...

Agreed on both counts.


Ingo,

Would you prefer a v2 of the entire series (with Acks and removal of Fixes),
or a v2 that includes only the last two patches?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
