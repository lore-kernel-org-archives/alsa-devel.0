From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] usx2yloader: make fxload work without
	deprecated usbfs
Date: Wed, 25 Apr 2012 12:25:04 +0200
Message-ID: <201204251225.05230.fzu@wemgehoertderstaat.de>
References: <201101040120.38492.fzu@wemgehoertderstaat.de>
	<201112300142.01658.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id B9026104876
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 12:27:29 +0200 (CEST)
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
	by mout2.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.76 #1) id 1SMzRZ-0003c7-20
	for alsa-devel@alsa-project.org; Wed, 25 Apr 2012 12:27:29 +0200
Received: from localhost ([::1]:40584 helo=mjail2.freenet.de)
	by mjail2.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (Exim
	4.76 #1) id 1SMzRY-0006C9-UW
	for alsa-devel@alsa-project.org; Wed, 25 Apr 2012 12:27:29 +0200
Received: from [195.4.92.21] (port=60924 helo=11.mx.freenet.de)
	by mjail2.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (Exim
	4.76 #1) id 1SMzPF-0005Ih-KT
	for alsa-devel@alsa-project.org; Wed, 25 Apr 2012 12:25:05 +0200
Received: from p5dd50a10.dip0.t-ipconnect.de ([93.213.10.16]:63896
	helo=a64.localdomain)
	by 11.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.76 #1) id 1SMzPF-0004wB-EW
	for alsa-devel@alsa-project.org; Wed, 25 Apr 2012 12:25:05 +0200
In-Reply-To: <201112300142.01658.fzu@wemgehoertderstaat.de>
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


Use $DEVNAME instead of $DEVICE in script tascam_fw.

Signed-off-by: Karsten Wiese <fzuuzf@googlemail.com>
---
 usx2yloader/tascam_fw.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/usx2yloader/tascam_fw.in b/usx2yloader/tascam_fw.in
index 14bbc6c..d3145e3 100644
--- a/usx2yloader/tascam_fw.in
+++ b/usx2yloader/tascam_fw.in
@@ -53,8 +53,8 @@ if [ ! -x $LOADER ]; then
 fi
 
 if [ -x /usr/bin/logger ]; then
-	/usr/bin/logger -t $0 "load $FIRMWARE for $PRODUCT to $DEVICE"
+	/usr/bin/logger -t $0 "load $FIRMWARE for $PRODUCT to $DEVNAME"
 fi
-$LOADER $FLAGS -s $LOADERFIRMWARE -I $FIRMWARE
+$LOADER $FLAGS -s $LOADERFIRMWARE -I $FIRMWARE -D $DEVNAME
 
 exit 0
-- 
1.7.7.6
