From: Frank Roth <frashman@freenet.de>
Subject: [PATCH]ctxfi: Swapped SURROUND-SIDE channels on emu20k2
Date: Mon, 20 Jul 2009 17:00:14 +0200
Message-ID: <4A64867E.3060003@freenet.de>
References: <4A5DB59B.2010407@freenet.de>	<s5hvdltnfrp.wl%tiwai@suse.de>	<4A5F016F.1030305@freenet.de>	<4A5F02D0.5080200@freenet.de>	<4A646421.5090708@freenet.de>
	<s5hocrf5y3z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BDD522434E
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 17:00:14 +0200 (CEST)
In-Reply-To: <s5hocrf5y3z.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

My patch description:

On Soundblaster X-FI Titanium with emu20k2 the SIDE and SURROUND channels were swapped and wrong.
I double checked it with connector colors and creative soundblaster windows drivers.

So I swapped them to the true order.
Now "speaker-test -c6" and "speaker-test -c8" are working fine.

It's my first patch submit ever, so if I've done anything wrong, please correct me ;-)


Signed-off-by: Frank Roth <frashman@freenet.de>
--- alsa-driver-unstable/alsa-kernel/pci/ctxfi/ctdaio.c.orig	2009-07-20 16:20:37.273239043 +0200
+++ alsa-driver-unstable/alsa-kernel/pci/ctxfi/ctdaio.c	2009-07-20 14:26:59.798760829 +0200
@@ -57,9 +57,9 @@ struct daio_rsc_idx idx_20k1[NUM_DAIOTYP

  struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
  	[LINEO1] = {.left = 0x40, .right = 0x41},
-	[LINEO2] = {.left = 0x70, .right = 0x71},
+	[LINEO2] = {.left = 0x60, .right = 0x61},
  	[LINEO3] = {.left = 0x50, .right = 0x51},
-	[LINEO4] = {.left = 0x60, .right = 0x61},
+	[LINEO4] = {.left = 0x70, .right = 0x71},
  	[LINEIM] = {.left = 0x45, .right = 0xc5},
  	[SPDIFOO] = {.left = 0x00, .right = 0x01},
  	[SPDIFIO] = {.left = 0x05, .right = 0x85},
