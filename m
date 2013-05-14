From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [Fwd: [PATCH] ALSA: snd-aoa: Add a layout entry for
	PowerBook6, 5]
Date: Wed, 15 May 2013 09:44:47 +1000
Message-ID: <1368575087.31689.60.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wmM5+Bt5D0ziIBDp79j3"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F973260865
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 01:45:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Michael Ellerman <michael@ellerman.id.au>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-wmM5+Bt5D0ziIBDp79j3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


--=-wmM5+Bt5D0ziIBDp79j3
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [PATCH] ALSA:
 snd-aoa: Add a layout entry for PowerBook6,5
Content-Type: message/rfc822

Return-Path: <linuxppc-dev-bounces+benh=kernel.crashing.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham
 version=3.1.9
Received: from ozlabs.org (ozlabs.org [203.10.76.45]) by gate.crashing.org
 (8.14.1/8.13.8) with ESMTP id r4611MFx009880 for
 <benh@kernel.crashing.org>; Sun, 5 May 2013 20:01:23 -0500
Received: from ozlabs.org (localhost [IPv6:::1]) by ozlabs.org (Postfix)
 with ESMTP id 38F382C0116 for <benh@kernel.crashing.org>; Mon,  6 May 2013
 11:01:22 +1000 (EST)
Received: by ozlabs.org (Postfix) id 15DDC2C00AD; Mon,  6 May 2013 11:01:14
 +1000 (EST)
Delivered-To: linuxppc-dev@ozlabs.org
Received: by ozlabs.org (Postfix, from userid 1034) id 0D5E32C00EF; Mon,  6
 May 2013 11:01:13 +1000 (EST)
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ALSA: snd-aoa: Add a layout entry for PowerBook6,5
Date: Mon,  6 May 2013 11:01:05 +1000
Message-Id: <1367802065-32150-1-git-send-email-michael@ellerman.id.au>
X-Mailer: git-send-email 1.7.10.4
Cc: newchief@king.net.pl
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Errors-To: linuxppc-dev-bounces+benh=kernel.crashing.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+benh=kernel.crashing.org@lists.ozlabs.org>
Content-Transfer-Encoding: 7bit

Either one or a combination of commits 81e5d86
"Register i2c devices from device-tree" and 3a3dd01
"Improve detection of devices from device-tree" broke sound on
PowerBook6,5 machines.

Fix it by adding an entry to the new driver to match PowerBook6,5
machines.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 sound/aoa/fabrics/layout.c       |    8 ++++++++
 sound/aoa/soundbus/i2sbus/core.c |    3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 552b97a..61ab640 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -113,6 +113,7 @@ MODULE_ALIAS("sound-layout-100");
 MODULE_ALIAS("aoa-device-id-14");
 MODULE_ALIAS("aoa-device-id-22");
 MODULE_ALIAS("aoa-device-id-35");
+MODULE_ALIAS("aoa-device-id-44");
 
 /* onyx with all but microphone connected */
 static struct codec_connection onyx_connections_nomic[] = {
@@ -361,6 +362,13 @@ static struct layout layouts[] = {
 		.connections = tas_connections_nolineout,
 	  },
 	},
+	/* PowerBook6,5 */
+	{ .device_id = 44,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_all,
+	  },
+	},
 	/* PowerBook6,7 */
 	{ .layout_id = 80,
 	  .codecs[0] = {
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 0106583..15e7613 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -200,7 +200,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			 * We probably cannot handle all device-id machines,
 			 * so restrict to those we do handle for now.
 			 */
-			if (id && (*id == 22 || *id == 14 || *id == 35)) {
+			if (id && (*id == 22 || *id == 14 || *id == 35 ||
+				   *id == 44)) {
 				snprintf(dev->sound.modalias, 32,
 					 "aoa-device-id-%d", *id);
 				ok = 1;
-- 
1.7.10.4

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-wmM5+Bt5D0ziIBDp79j3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-wmM5+Bt5D0ziIBDp79j3--
