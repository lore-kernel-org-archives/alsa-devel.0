Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19429C4332B
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:56:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9428920735
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WzP4BDN5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skn7flJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9428920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6C001673;
	Mon, 23 Mar 2020 14:55:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6C001673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584971803;
	bh=iJ/Y3g82q9mlsVKG/178vxEbogcfUtUVqfxCpK3SSsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WzP4BDN5yoPymScNCE6rnlLO68BczPct0ieLY7g06ii2EFBQdIztydx+50D42bs40
	 yhM652QcWW3/GslY4RHCkKvvES9wiOgRqoqf8JCJtIJyBcv35xaTy8dvtWM5Ye2Iac
	 bHsSJPiCRM0514UeUJ4Y8iGdlXJnuySpa81dDWe4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ADB6F80305;
	Mon, 23 Mar 2020 14:47:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 822ABF8015B; Fri, 20 Mar 2020 22:53:02 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B7B8F80126
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 22:52:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B7B8F80126
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Skn7flJS"
Received: by mail-pf1-x442.google.com with SMTP id c19so3965113pfo.13
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a04BEXBq6T16pF8YgWqXF8qeXZZehjOHDxhsKaZX814=;
 b=Skn7flJSlYGzwEVidWCfP5Sxs1un6UzXQtQz+bWdWoAKNnRM80PqPvhDZwvv2wJKw6
 Mj81HfQM/zfiGt9ileOkKRRQWiF7jWjG6JhV+9WIbVnMz/dnDuFUHCHtIbQX4/CY7DkK
 noOtt/A9DKzcRzAlH+RqcMdMCY2dyTdaWE9AE5cShMSjs4HBzANhTM2+7CpxOlPpNBsU
 9nhE6/1XKN4/0cmtxXDNEwjoXngQLqF8QiIUQVIm1NRPbQReCnfpG/6XbUusceYyN0mz
 qR1CBCi2y2i3OXLUvaPOWqAKkvUGIR4nJ+prrBs7mnq20vlj/y21DMR6IS0a4SS96qyg
 vOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a04BEXBq6T16pF8YgWqXF8qeXZZehjOHDxhsKaZX814=;
 b=pNB2+vnCJqv6NGbTtWBCHfCsWXz3DbB6tc1f5vhaBZIUTg09i+Kk1ZjQ9FFjc2MTqQ
 Q+uHRUB8wb2zh0AnKpEKrExm2B1dgZPg0ipCOGxTb3VQOAscH6/8tHVvfr0PbHsYu8qv
 6vm1yUCJtzb+V2F9/2yMmeXkZS2osSfj3B0XwvwtCRx5GaCrdC2391JPvTOgccZsERXZ
 uQ+QzwzpnRQN9aTK02qAMxx+8pH7dr0dYkKBdSRcNLaxjA4X2iDCx/xMaN5cTkqA6/9G
 EaLr5pvY35tv4IBJ8K+w1XkZLaZAhFJLQQoxRvp67C6FgUP4+IWG9PU2ipRno3MA6HK4
 Rn1Q==
X-Gm-Message-State: ANhLgQ17ynadSaF/v9TdrZg7sCT9DKg/Pn4BJT9+PYbgIpjq6P/O9c5j
 UYypbHClDxQbb1gNwiZbfjX/OVaFQo7qjUawCj0=
X-Google-Smtp-Source: ADFU+vsmV5czmNKtoJg0C7AeN7wX4S5Al3MMjqsDaMzJBp9Kh1vmxFKQ2VcZyX/I27EONEdC3cCFyRbcSUnbF2ixLdU=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id
 q20mr178775pfs.36.1584741173473; 
 Fri, 20 Mar 2020 14:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de>
 <20200320131509.564059710@linutronix.de>
 <CAHp75VdkvyqOaAsLmz8K2j4bdd0sboPoUpRr6U-zvtkSaQfPRQ@mail.gmail.com>
 <87eetmpy56.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eetmpy56.fsf@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 20 Mar 2020 23:52:42 +0200
Message-ID: <CAHp75VfuU98gEriS+GDJqZX4BV-cZT9hPbrDX-roeo63O8UvYQ@mail.gmail.com>
Subject: Re: [patch 09/22] cpufreq: Convert to new X86 CPU match macros
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 23 Mar 2020 14:47:37 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Mark Gross <mgross@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Iwai <tiwai@suse.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-crypto <linux-crypto@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andy Shevchenko <andy@infradead.org>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Mar 20, 2020 at 10:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
> >
> > Perhaps use names instead of 6 and 15?
>
> Thought about that and did not come up with anyting useful. FAM6 vs. 6
> is not really any better

Hmm... Do we have family 15 for Intel? Perhaps I missed something...
Or is it for any family?

-- 
With Best Regards,
Andy Shevchenko
