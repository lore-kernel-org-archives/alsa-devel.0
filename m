From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsactl init: Mute CD Playback volume by
	default
Date: Mon, 04 Apr 2011 11:36:20 +0200
Message-ID: <4D999114.5060705@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010109070108060801050503"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EF13024399
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:36:22 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1Q6gCq-0003Zf-Nf
	for <alsa-devel@alsa-project.org>; Mon, 04 Apr 2011 09:36:20 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1Q6gCq-0003Hb-LS
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 09:36:20 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010109070108060801050503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The CD analog playback line is seldom used these days, as all
modern players rip the CD and use the DAC on the sound card.
In addition, it causes background hum on some machines.
Therefore keep it muted by default.

BugLink: http://bugs.launchpad.net/bugs/747184
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010109070108060801050503
Content-Type: text/x-patch;
 name="0001-alsactl-init-Mute-CD-Playback-volume-by-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsactl-init-Mute-CD-Playback-volume-by-default.patch"

>From 26b4ad5af8f342fea905ea3682d5a3a512f297e3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 4 Apr 2011 11:28:47 +0200
Subject: [PATCH] alsactl init: Mute CD Playback volume by default

The CD analog playback line is seldom used these days, as all
modern players rip the CD and use the DAC on the sound card.
In addition, it causes background hum on some machines.
Therefore keep it muted by default.

BugLink: http://bugs.launchpad.net/bugs/747184
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/init/default |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/alsactl/init/default b/alsactl/init/default
index 7f8ec4c..b7cb941 100644
--- a/alsactl/init/default
+++ b/alsactl/init/default
@@ -144,17 +144,10 @@ CTL{name}="Music Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
-CTL{name}="CD Playback Volume",PROGRAM!="__ctl_search", GOTO=""
-# if master volume control is present, turn CD volume to max
-ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
-ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
-# exception - some HDA codecs have shifted dB range
-CTL{dBmin}=="-34.50dB",CTL{dBmax}=="12.00dB",CTL{write}=="0dB",GOTO=""
-CTL{dBmin}=="-30.00dB",CTL{dBmax}=="0dB",CTL{write}=="0dB",GOTO=""
-CTL{write}!="$env{pvolume}",CTL{values}="$env{ppercent}"
-LABEL=""
+CTL{name}="CD Playback Volume",CTL{do_search}=="1", \
+  CTL{values}="0%"
 CTL{name}="CD Playback Switch",CTL{do_search}=="1", \
-  CTL{values}="on"
+  CTL{values}="off"
 
 CTL{reset}="mixer"
 CTL{name}="Mono Playback Volume",CTL{do_search}=="1", \
-- 
1.7.4.1


--------------010109070108060801050503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010109070108060801050503--
