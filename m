Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1584C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Jan 2022 05:40:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38A4B39CE;
	Sun, 23 Jan 2022 06:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38A4B39CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642916412;
	bh=Hql/Pq7xpSpjjTFSDCqUiUZsN55itbnerW4lPhp3gVY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFHx/ybjfy90KMH8wjQ7Bs2ujTz+Bji5qTAbIplsO596YXlUjy81txY0nqDu+Yv7U
	 r4Pb4WuVwfENNbUIWLZw16Usv++fjj2yNM7mk5OOlgputOjTsll7zYyMbufmY+yClg
	 T+UhGLgweXq5cOH6SCopD11glPYs9akIKv5/HHwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCDDBF80161;
	Sun, 23 Jan 2022 06:39:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C79CF802E3; Sun, 23 Jan 2022 06:39:19 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D1606F80161
 for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2022 06:39:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1606F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1642916356213004112-webhooks-bot@alsa-project.org>
References: <1642916356213004112-webhooks-bot@alsa-project.org>
Subject: HP Spectre X360 fails to find soundcard
Message-Id: <20220123053919.4C79CF802E3@alsa1.perex.cz>
Date: Sun, 23 Jan 2022 06:39:19 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #135 was opened from bornmw:

HP Spectre x360 Convertible 13t-aw200

Vanilla kernel 5.16.2
alsa-ucm-conf-1.2.6.3
alsa-lib-1.2.6.1
alsa-utils-1.2.6
pulseaudio-15.0

[pulseverbose.log](https://github.com/alsa-project/alsa-ucm-conf/files/7919861/pulseverbose.log)

A combination of these commands plays noise successfully:
alsaucm -c sof-soundwire set _verb HiFi set _enadev Speaker
speaker-test -Dhw:0,2 -c2 -r48000


$ aplay -Ll
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
upmix
    Plugin for channel upmix (4,6,8)
vdownmix
    Plugin for channel downmix (stereo) with a simple spacialization
sysdefault:CARD=sofsoundwire
    sof-soundwire, 
    Default Audio Device
usbstream:CARD=sofsoundwire
    sof-soundwire
    USB Stream Output
**** List of PLAYBACK Hardware Devices ****
card 0: sofsoundwire [sof-soundwire], device 0: Headphone (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofsoundwire [sof-soundwire], device 2: SDW1-speakers (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofsoundwire [sof-soundwire], device 5: HDMI1 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofsoundwire [sof-soundwire], device 6: HDMI2 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofsoundwire [sof-soundwire], device 7: HDMI3 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: sofsoundwire [sof-soundwire], device 8: HDMI4 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/135
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
