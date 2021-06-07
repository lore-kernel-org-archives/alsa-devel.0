Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DFC47094
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:43:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F48F6054E
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F48F6054E
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F0DA1657;
	Mon,  7 Jun 2021 18:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F0DA1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623084217;
	bh=JMY0g0MMSKUBdxxblQn9nEicO3CGlL/wCqLHiLE5Xdw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPjJ/nzo5FYlpfLaU6zYYj2aBBNP6ezjA4eH447ZNmRnUsrWc1BBQXfJH6zSdJcTm
	 dg7qpgZ3uJvlBpZEpQB6I1+lNtObW2AwuNNLm2GqwJrKOHe2N3FvwUAwBgoa7VdlSi
	 XIF8FxspeLjpWYMyfOQApWNey31rem+EOt1sZ7SQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7E50F8020D;
	Mon,  7 Jun 2021 18:42:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A065F801EC; Mon,  7 Jun 2021 18:42:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3A511F801EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 18:42:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A511F801EC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623084156440220118-webhooks-bot@alsa-project.org>
References: <1623084156440220118-webhooks-bot@alsa-project.org>
Subject: alsa-lib 1.2.5(-2 on arch) only one of two connected hdmi/displayport
 outputs visible at once. My mic is completely MIA
Message-Id: <20210607164244.7A065F801EC@alsa1.perex.cz>
Date: Mon,  7 Jun 2021 18:42:44 +0200 (CEST)
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

alsa-project/alsa-lib issue #148 was opened from fkroener:

Since the recent update to 1.2.5-2 on archlinux, only one of my two usb-c/displayport/hdmi devices show up in pavucontrol and kde mixer. I am able to switch between hdmi0 and hdmi1, by changing the Profile in pavucontrol of HD-Audio Generic. 

The microphone doesn't show up at all now.

![KDE Mixer](https://user-images.githubusercontent.com/28690007/121057421-8c369380-c7bf-11eb-9431-c585a411a417.png)

This doesn't appear related to #142 or #143, since I have revision 2 from arch installed, which should include the fixes.

This is a Lenovo T14 AMD.

```
pactl list cards 
Card #0
        Name: alsa_card.pci-0000_07_00.1
        Driver: module-alsa-card.c
        Owner Module: 6
        Properties:
                alsa.card = "0"
                alsa.card_name = "HD-Audio Generic"
                alsa.long_card_name = "HD-Audio Generic at 0xfd3c8000 irq 91"
                alsa.driver_name = "snd_hda_intel"
                device.bus_path = "pci-0000:07:00.1"
                sysfs.path = "/devices/pci0000:00/0000:00:08.1/0000:07:00.1/sound/card0"
                device.bus = "pci"
                device.vendor.id = "1002"
                device.vendor.name = "Advanced Micro Devices, Inc. [AMD/ATI]"
                device.product.id = "1637"
                device.string = "0"
                device.description = "HD-Audio Generic"
                module-udev-detect.discovered = "1"
                device.icon_name = "audio-card-pci"
        Profiles:
                output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1, sources: 0, priority: 5900, available: yes)
                output:hdmi-stereo-extra1: Digital Stereo (HDMI 2) Output (sinks: 1, sources: 0, priority: 5700, available: yes)
                output:hdmi-stereo-extra2: Digital Stereo (HDMI 3) Output (sinks: 1, sources: 0, priority: 5700, available: no)
                output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI 3) Output (sinks: 1, sources: 0, priority: 600, available: no)
                output:hdmi-surround71-extra2: Digital Surround 7.1 (HDMI 3) Output (sinks: 1, sources: 0, priority: 600, available: no)
                off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
        Active Profile: output:hdmi-stereo
        Ports:
                hdmi-output-0: HDMI / DisplayPort (type: HDMI, priority: 5900, latency offset: 0 usec, available)
                        Properties:
                                device.icon_name = "video-display"
                                device.product.name = "P27h-20"
                        Part of profile(s): output:hdmi-stereo
                hdmi-output-1: HDMI / DisplayPort 2 (type: HDMI, priority: 5800, latency offset: 0 usec, available)
                        Properties:
                                device.icon_name = "video-display"
                                device.product.name = "P27h-20"
                        Part of profile(s): output:hdmi-stereo-extra1
                hdmi-output-2: HDMI / DisplayPort 3 (type: HDMI, priority: 5700, latency offset: 0 usec, not available)
                        Properties:
                                device.icon_name = "video-display"
                        Part of profile(s): output:hdmi-stereo-extra2, output:hdmi-surround-extra2, output:hdmi-surround71-extra2

Card #1
        Name: alsa_card.pci-0000_07_00.6
        Driver: module-alsa-card.c
        Owner Module: 8
        Properties:
                alsa.card = "1"
                alsa.card_name = "HD-Audio Generic"
                alsa.long_card_name = "HD-Audio Generic at 0xfd3c0000 irq 92"
                alsa.driver_name = "snd_hda_intel"
                device.bus_path = "pci-0000:07:00.6"
                sysfs.path = "/devices/pci0000:00/0000:00:08.1/0000:07:00.6/sound/card1"
                device.bus = "pci"
                device.vendor.id = "1022"
                device.vendor.name = "Advanced Micro Devices, Inc. [AMD]"
                device.product.id = "15e3"
                device.product.name = "Family 17h (Models 10h-1fh) HD Audio Controller"
                device.string = "1"
                device.description = "Family 17h (Models 10h-1fh) HD Audio Controller"
                module-udev-detect.discovered = "1"
                device.icon_name = "audio-card-pci"
        Profiles:
                input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, priority: 65, available: no)
                output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0, priority: 6500, available: yes)
                output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (sinks: 1, sources: 1, priority: 6565, available: no)
                off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
        Active Profile: output:analog-stereo
        Ports:
                analog-input-mic: Microphone (type: Mic, priority: 8700, latency offset: 0 usec, not available)
                        Properties:
                                device.icon_name = "audio-input-microphone"
                        Part of profile(s): input:analog-stereo, output:analog-stereo+input:analog-stereo
                analog-output-speaker: Speakers (type: Speaker, priority: 10000, latency offset: 0 usec, availability unknown)
                        Properties:
                                device.icon_name = "audio-speakers"
                        Part of profile(s): output:analog-stereo, output:analog-stereo+input:analog-stereo
                analog-output-headphones: Headphones (type: Headphones, priority: 9900, latency offset: 0 usec, not available)
                        Properties:
                                device.icon_name = "audio-headphones"
                        Part of profile(s): output:analog-stereo, output:analog-stereo+input:analog-stereo
```

If you need any more information, I'm gladly at your disposal. Thanks!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/148
Repository URL: https://github.com/alsa-project/alsa-lib
