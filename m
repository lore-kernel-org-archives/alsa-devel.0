From: Robert Jarzmik <rjarzmik@free.fr>
Subject: [PATCH] dapm_new_mixer and 32 bytes limitation
Date: 18 Jan 2008 21:13:36 +0100
Message-ID: <87r6geevtb.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 48943244E4
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:13:38 +0100 (CET)
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 02CC25FE79
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:13:38 +0100 (CET)
Received: from polgara (mur31-2-82-243-122-54.fbx.proxad.net [82.243.122.54])
	by smtp6-g19.free.fr (Postfix) with ESMTP id BDC935FE78
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:13:37 +0100 (CET)
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

--=-=-=

Dapm mixer names are truncated to 32 bytes, while alsa control names are 44
bytes wide. 

Subsequent usage of functions like snd_ctl_find_id fail because of the
mismatch. Unless there's a limitation I don't understand, the following patch
fixes the limit back to 44 bytes.

--
Robert


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=wname44cars.diff
Content-Description: Patch for 44 bytes wide dapm mixer names

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ea20138..f22a1bb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -281,7 +281,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
-	char name[32];
+	char name[44];
 	struct snd_soc_dapm_path *path;
 
 	/* add kcontrol */
@@ -295,7 +295,8 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 				continue;
 
 			/* add dapm control with long name */
-			snprintf(name, 32, "%s %s", w->name, w->kcontrols[i].name);
+			snprintf(name, 43, "%s %s", w->name, w->kcontrols[i].name);
+			name[43] = 0;
 			path->long_name = kstrdup (name, GFP_KERNEL);
 			if (path->long_name == NULL)
 				return -ENOMEM;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
