Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F413C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:43:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8E120873
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="peiEIJC7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmBuwPtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8E120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 503881661;
	Fri, 14 Feb 2020 08:43:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 503881661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581666232;
	bh=XNORFDitWJGdNtjAT/eBtX/Zab6EoKoh+FH4VLCrJXQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peiEIJC7+iVwkaHSgMMkhnbXWfSgwf8npWVRLtDmeP4IXMHTPYKSMFIdwYEgAvCcZ
	 LZFtrpEmcQb9eDu9uxlMumUbCDmUS2g7nE5LA69hvRjuENhRdFHsf1PCWcXsObosF9
	 d5M/h48x+iTxrI6MrghwZpviVPOwgxabS5OHjVyc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C86F3F8013E;
	Fri, 14 Feb 2020 08:43:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61707F8014F; Fri, 14 Feb 2020 08:43:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1FECF800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 08:42:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1FECF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YmBuwPtR"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 617662465D
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581666175;
 bh=m798uLVqmuYtv5ug6phfy9RoTjgQyqUELX3cTjvJVMw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YmBuwPtRGIYFABvzK00gyC3HUwpkhd/mEGyopNk7IWDExVBsz/aTGXp1t1UP1LsS3
 uKmBHo2k084OlSvg3VUjTwOLInWLBXXNkuBsNi+4em8YHwmrLR1vMgiGCaz94CY188
 daxj5etfGNvwT3FPWnhg4ZSyoFhNuG9BOFuYNC1U=
Received: by mail-lj1-f181.google.com with SMTP id o15so9610265ljg.6
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 23:42:55 -0800 (PST)
X-Gm-Message-State: APjAAAWVhH855YQ7iYGvCTpO5LykPCT3QolWmVoEyRs2q+pLEtzoVZFl
 yhHg550Ds6lOLZuR/VFwRWnCrthWP7jr0YQ7QWI=
X-Google-Smtp-Source: APXvYqy7gojEaGR75YMM57u2JXSw/yOVghVztLaVTcFLE+UKiZQ9sYF9fwVeQGU1YORQn5Pe+ddsEzhZzr9AWB0N5kk=
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr1197113ljj.270.1581666173493; 
 Thu, 13 Feb 2020 23:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com>
 <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com>
 <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com>
 <CAEnQRZA4W-i4zcF8jUL2zp5-dO-iX=KSp5Do2pCK9_oZiVtYEQ@mail.gmail.com>
In-Reply-To: <CAEnQRZA4W-i4zcF8jUL2zp5-dO-iX=KSp5Do2pCK9_oZiVtYEQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 14 Feb 2020 08:42:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPexfj9Rs+9jGSd4LWhcp0txdECBqsdvSJvHv7NdtNsaMA@mail.gmail.com>
Message-ID: <CAJKOXPexfj9Rs+9jGSd4LWhcp0txdECBqsdvSJvHv7NdtNsaMA@mail.gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Yuehaibing <yuehaibing@huawei.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
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

On Thu, 13 Feb 2020 at 22:09, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> Hi Krzysztof,
>
> Which symbol misses an EXPORT_SYMBOL?
> We already have EXPORT_SYMBOL(imx_dsp_ring_doorbell);

Hi,

Yes, exactly this one. That was just my guess.

Best regards,
Krzysztof
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
