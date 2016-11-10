From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/30] ALSA: doc: Remove alsa-parameters.txt
Date: Thu, 10 Nov 2016 22:06:12 +0100
Message-ID: <20161110210641.5907-2-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 373FF26647B
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7D57AACF3
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:52 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a really obsoleted information, effectively just listing the
module names.  Let's get rid of it for avoiding confusions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/alsa-parameters.txt | 135 ---------------------------
 1 file changed, 135 deletions(-)
 delete mode 100644 Documentation/sound/alsa/alsa-parameters.txt

diff --git a/Documentation/sound/alsa/alsa-parameters.txt b/Documentation/sound/alsa/alsa-parameters.txt
deleted file mode 100644
index 0fa40679b080..000000000000
--- a/Documentation/sound/alsa/alsa-parameters.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-                          ALSA Kernel Parameters
-                          ~~~~~~~~~~~~~~~~~~~~~~
-
-See Documentation/kernel-parameters.txt for general information on
-specifying module parameters.
-
-This document may not be entirely up to date and comprehensive. The command
-"modinfo -p ${modulename}" shows a current list of all parameters of a loadable
-module. Loadable modules, after being loaded into the running kernel, also
-reveal their parameters in /sys/module/${modulename}/parameters/. Some of these
-parameters may be changed at runtime by the command
-"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
-
-
-	snd-ad1816a=	[HW,ALSA]
-
-	snd-ad1848=	[HW,ALSA]
-
-	snd-ali5451=	[HW,ALSA]
-
-	snd-als100=	[HW,ALSA]
-
-	snd-als4000=	[HW,ALSA]
-
-	snd-azt2320=	[HW,ALSA]
-
-	snd-cmi8330=	[HW,ALSA]
-
-	snd-cmipci=	[HW,ALSA]
-
-	snd-cs4231=	[HW,ALSA]
-
-	snd-cs4232=	[HW,ALSA]
-
-	snd-cs4236=	[HW,ALSA]
-
-	snd-cs4281=	[HW,ALSA]
-
-	snd-cs46xx=	[HW,ALSA]
-
-	snd-dt019x=	[HW,ALSA]
-
-	snd-dummy=	[HW,ALSA]
-
-	snd-emu10k1=	[HW,ALSA]
-
-	snd-ens1370=	[HW,ALSA]
-
-	snd-ens1371=	[HW,ALSA]
-
-	snd-es968=	[HW,ALSA]
-
-	snd-es1688=	[HW,ALSA]
-
-	snd-es18xx=	[HW,ALSA]
-
-	snd-es1938=	[HW,ALSA]
-
-	snd-es1968=	[HW,ALSA]
-
-	snd-fm801=	[HW,ALSA]
-
-	snd-gusclassic=	[HW,ALSA]
-
-	snd-gusextreme=	[HW,ALSA]
-
-	snd-gusmax=	[HW,ALSA]
-
-	snd-hdsp=	[HW,ALSA]
-
-	snd-ice1712=	[HW,ALSA]
-
-	snd-intel8x0=	[HW,ALSA]
-
-	snd-interwave=	[HW,ALSA]
-
-	snd-interwave-stb=
-			[HW,ALSA]
-
-	snd-korg1212=	[HW,ALSA]
-
-	snd-maestro3=	[HW,ALSA]
-
-	snd-mpu401=	[HW,ALSA]
-
-	snd-mtpav=	[HW,ALSA]
-
-	snd-nm256=	[HW,ALSA]
-
-	snd-opl3sa2=	[HW,ALSA]
-
-	snd-opti92x-ad1848=
-			[HW,ALSA]
-
-	snd-opti92x-cs4231=
-			[HW,ALSA]
-
-	snd-opti93x=	[HW,ALSA]
-
-	snd-pmac=	[HW,ALSA]
-
-	snd-rme32=	[HW,ALSA]
-
-	snd-rme96=	[HW,ALSA]
-
-	snd-rme9652=	[HW,ALSA]
-
-	snd-sb8=	[HW,ALSA]
-
-	snd-sb16=	[HW,ALSA]
-
-	snd-sbawe=	[HW,ALSA]
-
-	snd-serial=	[HW,ALSA]
-
-	snd-sgalaxy=	[HW,ALSA]
-
-	snd-sonicvibes=	[HW,ALSA]
-
-	snd-sun-amd7930=
-			[HW,ALSA]
-
-	snd-sun-cs4231=	[HW,ALSA]
-
-	snd-trident=	[HW,ALSA]
-
-	snd-usb-audio=	[HW,ALSA,USB]
-
-	snd-via82xx=	[HW,ALSA]
-
-	snd-virmidi=	[HW,ALSA]
-
-	snd-wavefront=	[HW,ALSA]
-
-	snd-ymfpci=	[HW,ALSA]
-- 
2.10.2
