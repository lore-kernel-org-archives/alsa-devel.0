From: Stanislav Brabec <utx@penguin.cz>
Subject: [PATCH] use convenient treble scale on WM8750
Date: Sun, 11 Nov 2007 23:52:08 +0100
Message-ID: <1194821528.18137.5.camel@utx.utx.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns.penguin.cz (ns.penguin.cz [212.47.7.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BCF72474C
	for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2007 23:52:11 +0100 (CET)
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
Cc: Richard Purdie <richard@openedhand.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Zaurus SL-C3200 (terrier/spitz) based on WM8750, treble scale is
inconveniently reverted (increase level = decrease treble), in opposite
to bass scale, which uses convenient scale.

Fix ALSA WM8750 mixer treble to use convenient treble scale (increase =
increase treble level):

--- linux-2.6.23/sound/soc/codecs/wm8750.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23/sound/soc/codecs/wm8750.c	2007-11-02 16:47:35.000000000 +0100
@@ -189,7 +189,7 @@
 SOC_ENUM("Bass Filter", wm8750_enum[1]),
 SOC_SINGLE("Bass Volume", WM8750_BASS, 0, 15, 1),
 
-SOC_SINGLE("Treble Volume", WM8750_TREBLE, 0, 15, 0),
+SOC_SINGLE("Treble Volume", WM8750_TREBLE, 0, 15, 1),
 SOC_ENUM("Treble Cut-off", wm8750_enum[2]),
 
 SOC_SINGLE("3D Switch", WM8750_3D, 0, 1, 0),


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
