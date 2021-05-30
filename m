Return-Path: <SRS0=W/rr=KZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F1C47082
	for <alsa-devel@archiver.kernel.org>; Sun, 30 May 2021 00:46:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BE761107
	for <alsa-devel@archiver.kernel.org>; Sun, 30 May 2021 00:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE761107
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03F3216A3;
	Sun, 30 May 2021 02:45:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03F3216A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622335571;
	bh=bwlBHlvWMv/Z0LpGk13wILpgIyjZstZQLPf0wOdOUiQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DADXiu+F6PKo8T5gRhvHTvltGYirHUNTB45L965dTIfGjMjhFxjRtZSLx6WKLOf/B
	 3unsSwssNsMAipFposUpC+qnOx4hu7w/9wFBBPGqADeun8sgl9x/ZjEgsZ6OsyypfY
	 D9/Lsy3vIEtDmnxqrvlWpTNV5zR77c4hSrRp0rHw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B143F8014B;
	Sun, 30 May 2021 02:45:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E44BDF80169; Sun, 30 May 2021 02:45:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B2991F8010A
 for <alsa-devel@alsa-project.org>; Sun, 30 May 2021 02:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2991F8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622335513618031979-webhooks-bot@alsa-project.org>
References: <1622335513618031979-webhooks-bot@alsa-project.org>
Subject: alsa-ucm-conf 1.2.4 fails with platform-skl_hda_dsp_generic
Message-Id: <20210530004518.E44BDF80169@alsa1.perex.cz>
Date: Sun, 30 May 2021 02:45:18 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #93 was opened from bjacquin:

Hi,

I am experiencing the same issue as reported in issue #66, however I am still able to reproduce this with alsa-lib and alsa-utils 1.2.4 installed.

* 1.2.3

`alsa-info` output is attached in [alsa-info.1.2.3.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6565495/alsa-info.1.2.3.txt).
`pulseaudio` standard logs show:
```
May 30 01:33:34 lady-voodoo.local pulseaudio[23962]: E: [pulseaudio] alsa-ucm.c: Failed to get the verb HiFi
May 30 01:33:34 lady-voodoo.local pulseaudio[23962]: E: [pulseaudio] alsa-ucm.c: No UCM verb is valid for sof-hda-dsp
```
`pactl list short cards` list the following cards as available:
```
0	alsa_card.usb-046d_HD_Pro_Webcam_C920_BD731F4F-02	module-alsa-card.c
1	alsa_card.usb-Sennheiser_Sennheiser_SP_30_A002340202303344-00	module-alsa-card.c
2	alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_genericmodule-alsa-card.c
```
`pulseaudio -vvv` output is attached in [pulseaudio-1.2.3.log](https://github.com/alsa-project/alsa-ucm-conf/files/6565500/pulseaudio-1.2.3.log).
`pacmd ls` output is attached in [pacmd-ls-1.2.3.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6565501/pacmd-ls-1.2.3.txt)

* 1.2.4

`alsa-info` output is attached in [alsa-info.1.2.4.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6565483/alsa-info.1.2.4.txt).
`pulseaudio` standard logs show:
```
May 30 01:14:40 lady-voodoo.local /bin/bash[672]: HISTORY: PID=672 UID=1000 pulseaudio -k
May 30 01:14:40 lady-voodoo.local systemd[481]: pulseaudio.service: Succeeded.
May 30 01:14:40 lady-voodoo.local systemd[481]: pulseaudio.service: Consumed 7.644s CPU time.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device HDMI3, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device HDMI2, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device HDMI1, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device Mic2, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device Mic1, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device Speaker, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: W: [pulseaudio] alsa-ucm.c: UCM file does not specify 'PlaybackChannels' or 'CaptureChannels'for device Headphones, assuming stereo duplex.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
May 30 01:14:41 lady-voodoo.local pulseaudio[18219]: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="pci-0000_00_1f.3-platform-skl_hda_dsp_generic" card_name="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
```
`pactl list short cards` list the following cards as available:
```
0	alsa_card.usb-046d_HD_Pro_Webcam_C920_BD731F4F-02	module-alsa-card.c
1	alsa_card.usb-Sennheiser_Sennheiser_SP_30_A002340202303344-00	module-alsa-card.c
```
`pulseaudio -vvv` output is attached in [pulseaudio-1.2.4.log](https://github.com/alsa-project/alsa-ucm-conf/files/6565508/pulseaudio-1.2.4.log).
`pacmd ls` output is attached in [pacmd-ls-1.2.4.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6565505/pacmd-ls-1.2.4.txt).

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/93
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
