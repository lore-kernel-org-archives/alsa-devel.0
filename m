Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC76CA9EC5
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 22:16:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2296960201;
	Sun, 11 Oct 2026 00:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2296960201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791670562;
	bh=JSRKGsrm/eB9GvFRkWtvjAR2rdu7i6waTXVJEZZpa/s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=X7eOAIbccyj2KK2ubH1Mb5wyUQjZef9ifyI4ISfmH+kDI9AyT881vCXTm9HQIs0lL
	 A6LnStYpGHtdKvJN3pQz1GrjOTfWZIEGeTvSlayk5JW6MLHHZOF6fc2c0jMdm4A3ix
	 Q2gl6LYvQ+4Mlo2ar1StRWzFAtHNY/Ep5mTaIKtU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88D46F805F8; Sun, 11 Oct 2026 00:15:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50A7EF80601;
	Sun, 11 Oct 2026 00:15:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99F9AF80551; Sun, 11 Oct 2026 00:15:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791670517;
	b=do4xsDE9747qOaP3uGYI1MXDtUjPsWsxA6WiSpOWcngmsr1oe4RgDR4NelqlGGNOxuuZ
	 ScIZDHk8wZPMmMM4AmEUoXQMw9gR0KIQyDXfK4fejf2niJGV6Ku2enFVSUa8MWldDMTzG
	 ktGpfNNDCTDvrziLZrCTWvcg+qvUnP8VCUFrM/hLl1jMdhNl/XKYLFHHBNRW4boCDkneR
	 VBErRovCZ8HCpviK5p0v0UwVrlUmMf5RcAJsZb+hAwWfDrQYKDkkdRleVKF6uZX+20Tn6
	 8hPwxiRhr0N57UqD7KTDPvlw0dhKLCwpyYH8KFa18ELgWpHTWGYWhcCmKYbjpBG0OoA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791670517;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=JSRKGsrm/eB9GvFRkWtvjAR2rdu7i6waTXVJEZZpa/s=;
	b=a5+Jz+IeJDUtsC2Ft5ZqU3SFSAMXssWhhlApnHam239ECJqobE8V+fNaq5dG4Eva/M6K
	 eO89Yjz0/UkUPaGZ/CemkhDWCt9z0/zwyC6zMpy3HkdvVi9+UiBEBh2GMbqKP0Yc6o7q0
	 juT8BZbZ3ymSncIeIpWz294+Q26Ly/E2Gwbn7JWcDMrW1pRPgpRx4hGLOrhTNRdRp+lh6
	 cvCcajWdV5x2M3vAo7PLFzwkW/vJ2Isu1Li5O+kA6pLMdB8Ht9GKMc4IcabTBb92G/Vvr
	 b9H+imHXOL3th95xUOYgQ2fIPGDHX3o+uRKuFDbEI7DRzkWepqI9p5nvDrvTR8iSW9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 26E90F804B4
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2026 00:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26E90F804B4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dd4ad75c479c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/872@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/872@alsa-project.org>
Subject: ucm2: MediaTek: add mt8189-rt1019p-rt5682s (skywalker Chromebooks)
Date: Sun, 11 Oct 2026 00:15:21 +0200 (CEST)
Message-ID-Hash: SLI422HMW2K2MDMOISZSMOSDJQDBHDUF
X-Message-ID-Hash: SLI422HMW2K2MDMOISZSMOSDJQDBHDUF
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SLI422HMW2K2MDMOISZSMOSDJQDBHDUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #872 was opened from zoan37:

Adds a UCM profile for MT8189 (Kompanio 540) Chromebooks with RT1019P speaker amps and an RT5682S headset codec (card `mt8189_1019_rt5682s`, the "skywalker" family; tested on quigon, the Lenovo IdeaPad Slim 3 Chromebook).

- Speaker, headphones, internal DMIC and headset mic.
- All DPCM front ends are routed in the BootSequence: PipeWire's ACP opens every PCM while it probes the profile, and these front ends refuse hw_params until they're routed to a back end (routing them in the devices' EnableSequence made ACP drop the whole profile).
- HDMI (`hw:CardId,6`, through an HDMI bridge on PCM 0) and DisplayPort over USB-C (`hw:CardId,5`, via the `TDM Playback Route` demux) are only added when the machine driver created their jacks, the same pattern as the recent mt8391-evk DisplayPort change.

Tested with linux-next plus the posted MT8189 series (the board DTS isn't upstream yet): speaker, headphones, both mics, HDMI and USB-C DisplayPort audio, starting from cleared mixer routes and across reboots.

`alsa-info.sh` output for the UCM validator: https://gist.github.com/zoan37/b611da4f1e569613f176c33edbe34a01

The profile was written with help from an AI assistant (Claude); I tested it on the hardware and reviewed it.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/872
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/872.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
