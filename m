From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Fix ALC662 DAC mixer mutes also
	for auto config model
Date: Thu, 18 Sep 2008 16:41:49 -0300
Message-ID: <200809181641.49657.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id E800624496
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 21:41:35 +0200 (CEST)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 56A743EAD
	for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2008 15:41:51 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id 6t-SHnRK53Ir for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 15:41:51 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E98643EA7
	for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2008 15:41:50 -0400 (EDT)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 7CEB42F547
	for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2008 16:41:31 -0300 (BRT)
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

In previous change "[ALSA] hda-codec - Fix ALC662 DAC mixer mutes", I
missed to fix the mixer mute switches also for the auto config model of
ALC662. Now mute for mixer items "Front", "Surround", "Center" and "LFE"
when available will work too with "auto" model.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff -p -up linux-2.6.27/sound/pci/hda/patch_realtek.c.orig linux-2.6.27/sound/pci/hda/patch_realtek.c
--- linux-2.6.27/sound/pci/hda/patch_realtek.c.orig	2008-09-18 16:24:50.000000000 -0300
+++ linux-2.6.27/sound/pci/hda/patch_realtek.c	2008-09-18 16:25:35.000000000 -0300
@@ -15975,15 +15975,15 @@ static int alc662_auto_create_multi_out_
 							      HDA_OUTPUT));
 			if (err < 0)
 				return err;
-			err = add_control(spec, ALC_CTL_BIND_MUTE,
+			err = add_control(spec, ALC_CTL_WIDGET_MUTE,
 					  "Center Playback Switch",
-					  HDA_COMPOSE_AMP_VAL(nid, 1, 2,
+					  HDA_COMPOSE_AMP_VAL(0x0e, 1, 0,
 							      HDA_INPUT));
 			if (err < 0)
 				return err;
-			err = add_control(spec, ALC_CTL_BIND_MUTE,
+			err = add_control(spec, ALC_CTL_WIDGET_MUTE,
 					  "LFE Playback Switch",
-					  HDA_COMPOSE_AMP_VAL(nid, 2, 2,
+					  HDA_COMPOSE_AMP_VAL(0x0e, 2, 0,
 							      HDA_INPUT));
 			if (err < 0)
 				return err;
@@ -15995,9 +15995,9 @@ static int alc662_auto_create_multi_out_
 			if (err < 0)
 				return err;
 			sprintf(name, "%s Playback Switch", chname[i]);
-			err = add_control(spec, ALC_CTL_BIND_MUTE, name,
-					  HDA_COMPOSE_AMP_VAL(nid, 3, 2,
-							      HDA_INPUT));
+			err = add_control(spec, ALC_CTL_WIDGET_MUTE, name,
+				HDA_COMPOSE_AMP_VAL(alc880_idx_to_mixer(i),
+						    3, 0, HDA_INPUT));
 			if (err < 0)
 				return err;
 		}


-- 
[]'s
Herton
