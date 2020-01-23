Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7584FC2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:50:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144424655
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bq8mDM4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144424655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=feix.family
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33F1F1669;
	Thu, 23 Jan 2020 13:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33F1F1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579783843;
	bh=LIXmt2h3wN6YoZmyffcxeLmCR5HFFvgThyZdbs1ffsY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bq8mDM4fm2LsmEaVrdexBPdUsFULkL/f5PyKg8pD8uGmHWD26MXmcZW5784KJ+4KD
	 H4JpPdNbHrVN8w7pObegjP42/Zd9Lp44IGzJfDnygwLnA3EeIIMwGfohCn868QMja6
	 r2J88dmYmbajhjqoigaM574GEm8q0KDWOJFmGoMc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1F18F8015B;
	Thu, 23 Jan 2020 13:49:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA344F801D9; Thu, 23 Jan 2020 13:49:50 +0100 (CET)
Received: from server.feix.family (server.feix.family [80.240.19.227])
 by alsa1.perex.cz (Postfix) with ESMTP id 10DC9F800BA
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 13:49:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10DC9F800BA
From: Michal Feix <michal@feix.family>
To: alsa-devel@alsa-project.org
Message-ID: <ebe959a0-5272-e7bd-6001-1ce598f7f6be@feix.family>
Date: Thu, 23 Jan 2020 13:49:46 +0100
MIME-Version: 1.0
Content-Language: cs
Subject: [alsa-devel] ASUS T100TAM UCM
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

there is no sound working via speakers or headphones jack on Asus T100TAM. Sound works correctly via HDMI or Bluetooth headphones. The chip on this Baytrail machine is correctly recognized as bytcr_rt5640. From dmesg:

bytcr_rt5640 bytcr_rt5640: quirk DMIC1_MAP enabled
bytcr_rt5640 bytcr_rt5640: quirk realtek,jack-detect-source 3
bytcr_rt5640 bytcr_rt5640: quirk realtek,over-current-threshold-microamp 2000
bytcr_rt5640 bytcr_rt5640: quirk realtek,over-current-scale-factor 1
bytcr_rt5640 bytcr_rt5640: quirk MCLK_EN enabled
bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
bytcr_rt5640 bytcr_rt5640: rt5640-aif1 <-> ssp2-port mapping ok
input: bytcr-rt5640 Headset as /devices/platform/80860F28:00/bytcr_rt5640/sound/card0/input17

After bootup, kernel log is filled with: "Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port" messages. I do understand this is due to the missing UCM profile for the machine.

I've successfully uploaded the output of alsa-info.sh.

I'm on Arch linux, with latest alsa-ucm-conf 1.2.1.2 which seems not to be sufficient to make sound working on this thing. Is there anything I can provide to help smart Alsa people to help with this?

Thank you,

--
Michal
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
