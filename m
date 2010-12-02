From: John Baboval <john.baboval@virtualcomputer.com>
Subject: [PATCH 1/1] ThinkPad T410[s] docking station line-out
Date: Thu, 02 Dec 2010 11:21:31 -0500
Message-ID: <4CF7C78B.7010301@virtualcomputer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server514.appriver.com (server514a.exghost.com [72.32.253.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 358F5103AD7
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:21:33 +0100 (CET)
Received: from [72.32.253.153] (HELO fe04.exg4.exghost.com)
	by server514.appriver.com (CommuniGate Pro SMTP 5.3.2)
	with ESMTP id 160235011 for alsa-devel@alsa-project.org;
	Thu, 02 Dec 2010 10:21:40 -0600
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

Signed-off-by: John Baboval <john.baboval at virtualcomputer.com>
---

diff -r e37815d2e813 sound/pci/hda/patch_conexant.c
--- a/sound/pci/hda/patch_conexant.c	Mon Nov 29 12:56:29 2010 -0500
+++ b/sound/pci/hda/patch_conexant.c	Mon Nov 29 17:35:36 2010 -0500
@@ -2060,20 +2060,29 @@
  	struct conexant_spec *spec = codec->spec;
  	unsigned int pinctl;

-	snd_printdd("CXT5066: update speaker, hp_present=%d\n",
-		spec->hp_present);
+	snd_printdd("CXT5066: update speaker, hp_present=%d, cur_eapd=%d\n",
+		    spec->hp_present, spec->cur_eapd);

  	/* Port A (HP) */
  	pinctl = ((spec->hp_present&  1)&&  spec->cur_eapd) ? PIN_HP : 0;
  	snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
  			pinctl);

-	/* Port D (HP/LO) */
-	pinctl = ((spec->hp_present&  2)&&  spec->cur_eapd)
-		? spec->port_d_mode : 0;
-	/* Mute if Port A is connected on Thinkpad */
-	if (spec->thinkpad&&  (spec->hp_present&  1))
-		pinctl = 0;
+	/* Port D (HP/LO */
+	if (spec->dell_automute) {
+                /* DELL AIO Port Rule: PortA>  PortD>  IntSpk */
+                pinctl = (!(spec->hp_present&  1)&&  spec->cur_eapd)
+                        ? PIN_OUT : 0;
+	} else if (spec->thinkpad) {
+		if (spec->cur_eapd)
+			pinctl = spec->port_d_mode;
+		/* Mute dock line-out if Port A (laptop HP) is present */
+		if (spec->hp_present&  1)
+			pinctl = 0;
+	} else {
+		pinctl = ((spec->hp_present&  2)&&  spec->cur_eapd)
+		        ? spec->port_d_mode : 0;
+	}
  	snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
  			pinctl);

@@ -2081,14 +2090,6 @@
  	pinctl = (!spec->hp_present&&  spec->cur_eapd) ? PIN_OUT : 0;
  	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
  			pinctl);
-
-	if (spec->dell_automute) {
-		/* DELL AIO Port Rule: PortA>  PortD>  IntSpk */
-		pinctl = (!(spec->hp_present&  1)&&  spec->cur_eapd)
-			? PIN_OUT : 0;
-		snd_hda_codec_write(codec, 0x1c, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl);
-	}
  }

  /* turn on/off EAPD (+ mute HP) as a master switch */
