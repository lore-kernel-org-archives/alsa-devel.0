From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: another device for opl3sa2
Date: Mon, 2 Jul 2007 17:27:39 -0700
Message-ID: <20070703002739.GA27389@math.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id C6998243BD
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 02:27:40 +0200 (CEST)
Content-Disposition: inline
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

Folks:

Here's a patch to add support for an (admittedly old) device:


--- linux-2.6.21.5/sound/isa/opl3sa2.c.orig	2007-06-11 11:37:06.000000000 -0700
+++ linux-2.6.21.5/sound/isa/opl3sa2.c	2007-06-30 23:29:43.000000000 -0700
@@ -165,6 +165,8 @@
 	{ .id = "YMH0801", .devs = { { "YMH0021" } } },
 	/* NeoMagic MagicWave 3DX */
 	{ .id = "NMX2200", .devs = { { "YMH2210" } } },
+	/* NeoMagic MagicWave 3D */
+	{ .id = "NMX2200", .devs = { { "NMX2210" } } },
 	/* --- */
 	{ .id = "" }	/* end */
 };


(There may be a bug in the initialization code, though -- it doesn't work
the first time after booting, just the second and subsequent times.
For example, the first time I try running "aplay file.wav" it'll sit there
silently instead of playing the file, but if I type "aplay file.wav" again
then it'll play.)

I don't know whether snd_opl3sa2_pnpbiosids[] should also be changed.

Also, why does nm256.c direct users to the cs423x drivers and not opl3sa2?
If it had mentioned opl3sa2 it would have saved me many hours.

Sincerely,


Paul Vojta
vojta@math.berkeley.edu
