Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322AC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 13:31:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0ED23406
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 13:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0ED23406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F301C16A9;
	Wed,  9 Dec 2020 14:30:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F301C16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607520675;
	bh=keruqDNzKLE1NUasPPRja8/DWST294fUrT0PGBtb7Qg=;
	h=Subject:From:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MVrlgHlOW5M1VEzFmnDKuDcAzwCp2dQ8OXEx+nzTm4klVdUt6YCGzpHRVNZdsnwiu
	 WV9WXtDBQIloKY9LRFmwxDwzC7kseNRKo3rJqz/JM/rCPQMTWjuj/3Vs8j9zl0zCxC
	 EyJXXvBsqPxNDn9VwWrXf1GiGQmtlWkILaB6zFnc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58505F801D8;
	Wed,  9 Dec 2020 14:30:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB5A0F8020D; Wed,  9 Dec 2020 14:30:21 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E974F8012C
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 14:30:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E974F8012C
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net
 [82.255.60.242]) (Authenticated sender: hadess@hadess.net)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0F4001C0003
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 13:30:08 +0000 (UTC)
Message-ID: <e1e944b48ae44106a57c74de19dd74d6193495fe.camel@hadess.net>
Subject: USB Wireless device support
From: Bastien Nocera <hadess@hadess.net>
To: alsa-devel@alsa-project.org
Date: Wed, 09 Dec 2020 14:30:08 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
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

I've recently bought a SteelSeries Arctis 1 wireless headset:
https://steelseries.com/gaming-headsets/arctis-1-wireless-xbox
and wanted to write a kernel driver to export a few features of the
device, and needed some help getting started.

The receiver shows up as a audio class USB device, with extra features
on a separate USB interface.[1]

The extra features that can be accessed are:
- Presence detection. I wanted to use that so PulseAudio or Pipewire
could make routing decisions based on whether the headset is available,
or probably better, implementing a "jack detection" emulation for the
main audio interface?
- A slider to change the sidetone volume
- Export the battery level

The latter is the only one I know how to do, so I'd be happy with any
pointers or examples about the first two items.

Cheers

[1]: User-space code that accesses those features:
https://github.com/Sapd/HeadsetControl/blob/master/src/devices/steelseries_arctis_1_xbox.c

