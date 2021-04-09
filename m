Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD545C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 11:10:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8DB610D1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 11:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8DB610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=base.nu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48DF510E;
	Fri,  9 Apr 2021 13:09:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48DF510E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617966616;
	bh=aFfdhfbYEUdciYJaxrOyGDs7u3+iYdm2X7gwyHOUjIY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2UbF6yb21kGJjyzznzV7bK2cWh9Nnms79YD/2jDgNyW923OlBvzeWLQkLPKqgh3Y
	 MRjbzozEi8161DZKTu6sJE0XBKt12dDNLNGcejEDMEuIHYwfxjLbFj+nUqrdranjLA
	 VZwLednM0zE7Wb8W8miwtFG1/5uAQrM47Qq6hTgw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C916CF80168;
	Fri,  9 Apr 2021 13:09:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95F8FF8016A; Fri,  9 Apr 2021 13:09:22 +0200 (CEST)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E86A6F80162
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 13:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E86A6F80162
Received: from hellmouth.base.nu (localhost [127.0.0.1])
 by hellmouth.base.nu (OpenSMTPD) with ESMTP id e22468b3;
 Fri, 9 Apr 2021 11:09:16 +0000 (UTC)
Received: from base.nu ([88.97.23.37]) by hellmouth.base.nu with ESMTPSA
 id P+8HHdw1cGAHBQAADaPQrA
 (envelope-from <livvy@base.nu>); Fri, 09 Apr 2021 11:09:16 +0000
Date: Fri, 9 Apr 2021 12:07:45 +0100
From: Olivia Mackintosh <livvy@base.nu>
To: Geraldo <geraldogabriel@gmail.com>
Subject: Re: [PATCH v2] Pioneer devices: engage implicit feedback sync for
 playback
Message-ID: <20210409110745.kbr5z2jinsaur2ac@base.nu>
References: <CAEsQvcs9LcciAYjoB64Kt_VaSww4EAW4-qN0ED5jDA0GeeTtDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEsQvcs9LcciAYjoB64Kt_VaSww4EAW4-qN0ED5jDA0GeeTtDg@mail.gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

On Mon, Apr 05, 2021 at 10:49:20AM -0300, Geraldo wrote:
> Dear Linux users of Pioneer gear, please disregard v1 of this patch and
> test this instead if at all possible.
> 
> My initial assessment that we needed to let the capture EP be opened twice
> was clearly proven wrong by further testing. This is good because if we
> really needed that it would require a lot of reengineering inside ALSA.
> 
> One thing that still boggles my mind though is why we need a special
> Pioneer case inside snd_usb_parse_implicit_fb_quirk that returns 1 like a
> capture quirk was found.
> 
> This is a highly experimental patch on top of 5.12-rc6 that's supposed to
> engage implicit feedback sync on the playback for Pioneer devices. Without
> implicit feedback sync the inputs started glitching due to clock drift in
> about an hour in my Pioneer DJ DDJ-SR2.
> 
> Once again I'd like to thank Takashi Iwai. He's the true author of the bulk
> of this code, I just adapted it and coerced it into working.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

Thank you Geraldo and Takashi for working on this patch. I'm currently
in the process of testing with the DJM-750 but it currently does not
work as expected. I'll debug futher and report back but would like to
make you aware of this in the meantime. It may not be a a fundamental
issue with the patch, but rather something incidental.

Kind regards,
Olivia
