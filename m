Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB941C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 14:37:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13F023432
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 14:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13F023432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FA5116B8;
	Wed, 13 Jan 2021 15:36:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FA5116B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610548648;
	bh=hGgPhKbiTnEbcxlHTQM5ahlvu8W8GtvL0l5GS2lsqYc=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCwP9FSF/se0vfprdTaWIf6zsrQpbooeRDjzHtMGsdGyR/UR0C/n79KM+uOg9Xpoi
	 +YvP7WL+4mRAcWpi0tMkVUsyO+89x9H7lHrOYaXC4YD1E23Nbyuw3FPdbrpgqq2/yx
	 tr6bqytTsKGAmJgH3SEI2UgMo9hdsz0BBmpKovtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E392F8016D;
	Wed, 13 Jan 2021 15:36:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A0E4F801ED; Wed, 13 Jan 2021 15:36:34 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9136CF8014D
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 15:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9136CF8014D
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net
 [82.255.60.242]) (Authenticated sender: hadess@hadess.net)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0B80F20013
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 14:36:19 +0000 (UTC)
Message-ID: <3b322bb54a1df4b2a45586bc687fba3be5f9e3d8.camel@hadess.net>
Subject: Re: USB Wireless device support
From: Bastien Nocera <hadess@hadess.net>
To: alsa-devel@alsa-project.org
Date: Wed, 13 Jan 2021 15:36:19 +0100
In-Reply-To: <e1e944b48ae44106a57c74de19dd74d6193495fe.camel@hadess.net>
References: <e1e944b48ae44106a57c74de19dd74d6193495fe.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Hey,

On Wed, 2020-12-09 at 14:30 +0100, Bastien Nocera wrote:
> Hey,
> 
> I've recently bought a SteelSeries Arctis 1 wireless headset:
> https://steelseries.com/gaming-headsets/arctis-1-wireless-xbox
> and wanted to write a kernel driver to export a few features of the
> device, and needed some help getting started.
> 
> The receiver shows up as a audio class USB device, with extra
> features
> on a separate USB interface.[1]
> 
> The extra features that can be accessed are:
> - Presence detection. I wanted to use that so PulseAudio or Pipewire
> could make routing decisions based on whether the headset is
> available,
> or probably better, implementing a "jack detection" emulation for the
> main audio interface?
> - A slider to change the sidetone volume
> - Export the battery level
> 
> The latter is the only one I know how to do, so I'd be happy with any
> pointers or examples about the first two items.


I sent this in December and didn't get any answers, and I would
appreciate any guidance/examples if you have any into implementing
this.

I would imagine that the new features would be implemented through a
separate ALSA device with few features, which PulseAudio/Pipewire could
merge with the existing USB audio device.

Cheers

> [1]: User-space code that accesses those features:
>  
> https://github.com/Sapd/HeadsetControl/blob/master/src/devices/steelseries_arctis_1_xbox.c


