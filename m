From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make snd_ac97_add_vmaster() static
Date: Tue, 22 Jul 2008 20:21:32 +0300
Message-ID: <20080722172132.GZ14846@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id DDB3E1038A8
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 19:21:42 +0200 (CEST)
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
To: Daniel Jacobowitz <dan@codesourcery.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch makes the needlessly global snd_ac97_add_vmaster() static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
8ca0ca6ab50a53faf6c7af44b67408e32d11f69a 
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 0746e9c..f4fbc79 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3381,8 +3381,8 @@ static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
 }
 
 /* create a virtual master control and add slaves */
-int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
-			 const unsigned int *tlv, const char **slaves)
+static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
+				const unsigned int *tlv, const char **slaves)
 {
 	struct snd_kcontrol *kctl;
 	const char **s;
