Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C661C54ED0
	for <alsa-devel@archiver.kernel.org>; Fri, 23 May 2025 17:23:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9E83601F1;
	Fri, 23 May 2025 19:23:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9E83601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748021006;
	bh=ry/zd1U9azdh81wSPbC7C49KFPuTwc2jHGTWAFPHoQg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ojTtdHoVGe4N3kTh2HfD2HiFWh2Y5OuoaKzBa0fCNHmryURunkexuurO6J7V62kyZ
	 beq63+f00jVyA6ELiXnOE7O96K6d6PKysHEORoMQBktRPHuq4YQ2YaMUGfC63dNowL
	 7LBkT0hZXbduNBytcLt/N0A30EBhJlxwlds43ZOE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAAF7F805C2; Fri, 23 May 2025 19:22:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1B86F805C0;
	Fri, 23 May 2025 19:22:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DF3CF8057E; Fri, 23 May 2025 19:22:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AA0F1F80508
	for <alsa-devel@alsa-project.org>; Fri, 23 May 2025 19:22:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA0F1F80508
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184237cdda41b700-webhooks-bot@alsa-project.org>
In-Reply-To: <184237cdda3c1800-webhooks-bot@alsa-project.org>
References: <184237cdda3c1800-webhooks-bot@alsa-project.org>
Subject: Ubuntu Level 3 Log Error:
 /usr/lib/udev/rules.d/90-alsa-restore.rules:20 GOTO="alsa_restore_std" has no
 matching label, ignoring.
Date: Fri, 23 May 2025 19:22:44 +0200 (CEST)
Message-ID-Hash: 2BTOJ2JSBFSVFLXXMULC4UHVHRKS5BZE
X-Message-ID-Hash: 2BTOJ2JSBFSVFLXXMULC4UHVHRKS5BZE
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2BTOJ2JSBFSVFLXXMULC4UHVHRKS5BZE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #299 was edited from CaptainMorgan12:

Similar issue to https://github.com/alsa-project/alsa-utils/issues/280

<pre>journalctl -u systemd-udevd -b -o cat --grep alsa
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:16 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:16 The line has no effect any more, dropping.</b></font>
<font color="#C01C28"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#C01C28"><b>-restore.rules:20 GOTO=&quot;alsa_restore_std&quot; has no matching label, ignoring.</b></font>
<font color="#D7D75F"><b>/usr/lib/udev/rules.d/90-</b></font><b>alsa</b><font color="#D7D75F"><b>-restore.rules:20 The line has no effect any more, dropping.</b></font>
</pre>

Tried:
```

@@ -3,6 +3,8 @@

ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*",@extratest@ GOTO="alsa_restore_go"

GOTO="alsa_restore_end"




LABEL="alsa_restore_go"




ENV{ALSA_CARD_NUMBER}="$attr{device/number}"



# mark HDA analog card; HDMI/DP card does not have capture devices

@@ -21,7 +23,7 @@ TEST!="/run/udev/alsa-hda-analog-card", GOTO="alsa_restore_std"

IMPORT{program}="/usr/bin/cat /run/udev/alsa-hda-analog-card"

ENV{ALSA_CARD_HDA_ANALOG}!="", ENV{ALSA_CARD_NUMBER}="$env{ALSA_CARD_HDA_ANALOG}"




LABEL="alsa_restore_go"


LABEL="alsa_restore_std"

TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl@args@ restore $env{ALSA_CARD_NUMBER}"

TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl@args@ nrestore $env{ALSA_CARD_NUMBER}"
```

but no cigar

Hardware Config:

<pre>aplay -L | grep CARD
hw:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=0
hw:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=2
plughw:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=0
plughw:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=2
sysdefault:<font color="#C01C28"><b>CARD</b></font>=Audio
dmix:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=0
dmix:<font color="#C01C28"><b>CARD</b></font>=Audio,DEV=2
usbstream:<font color="#C01C28"><b>CARD</b></font>=Audio
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=3
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=7
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=8
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=9
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=10
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=11
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=3
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=7
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=8
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=9
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=10
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=11
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=0
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=1
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=2
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=3
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=4
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=5
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=3
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=7
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=8
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=9
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=10
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI_1,DEV=11
usbstream:<font color="#C01C28"><b>CARD</b></font>=HDMI_1
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=3
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=7
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=8
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=9
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=10
hw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=11
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=3
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=7
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=8
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=9
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=10
plughw:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=11
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=0
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=1
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=2
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=3
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=4
hdmi:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=5
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=3
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=7
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=8
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=9
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=10
dmix:<font color="#C01C28"><b>CARD</b></font>=HDMI,DEV=11
usbstream:<font color="#C01C28"><b>CARD</b></font>=HDMI
hw:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
plughw:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
sysdefault:<font color="#C01C28"><b>CARD</b></font>=DAC
front:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround21:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround40:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround41:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround50:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround51:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
surround71:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
iec958:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
dmix:<font color="#C01C28"><b>CARD</b></font>=DAC,DEV=0
usbstream:<font color="#C01C28"><b>CARD</b></font>=DAC
usbstream:<font color="#C01C28"><b>CARD</b></font>=Webcam
hw:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
hw:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=1
plughw:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
plughw:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=1
sysdefault:<font color="#C01C28"><b>CARD</b></font>=Device
front:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround21:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround40:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround41:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround50:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround51:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
surround71:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
iec958:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
iec958:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=1
dmix:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=0
dmix:<font color="#C01C28"><b>CARD</b></font>=Device,DEV=1
usbstream:<font color="#C01C28"><b>CARD</b></font>=Device
</pre>

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/299
Repository URL: https://github.com/alsa-project/alsa-utils
