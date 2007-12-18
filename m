From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] Dmux mixer conflict
Date: Tue, 18 Dec 2007 17:40:05 -0500
Message-ID: <47684C45.2080601@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050208090300080009060402"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.mud.yahoo.com (smtp108.biz.mail.mud.yahoo.com
	[68.142.201.177]) by alsa0.perex.cz (Postfix) with SMTP id 7E4C324561
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 23:40:07 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Tim Gardner <tim.gardner@canonical.com>, Jose_De_La_Rosa@Dell.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050208090300080009060402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

DMUX mixers need to be created before input source mixers, otherwise 
some STAC9228 codecs fail to record correctly or at all.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------050208090300080009060402
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="dmux_mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmux_mixer.patch"

diff -r fbe3540c8df4 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Dec 18 18:05:52 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Dec 18 15:27:34 2007 -0700
@@ -834,15 +834,16 @@ static int stac92xx_build_controls(struc
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < spec->num_mixers; i++) {
-		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
-		if (err < 0)
-			return err;
-	}
 	if (spec->num_dmuxes > 0) {
 		stac_dmux_mixer.count = spec->num_dmuxes;
 		err = snd_ctl_add(codec->bus->card,
 				  snd_ctl_new1(&stac_dmux_mixer, codec));
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < spec->num_mixers; i++) {
+		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
 		if (err < 0)
 			return err;
 	}

--------------050208090300080009060402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050208090300080009060402--
