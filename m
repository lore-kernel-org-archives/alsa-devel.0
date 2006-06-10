From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.17-rc5 1/1] ALSA: fix duplicate control
	creation in AC97
Date: Sat, 10 Jun 2006 17:54:29 +0800
Message-ID: <200606100954.k5A9sTfJ016103@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, marcelo@kvack.org, jordan.crouse@amd.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Jaroslav,

This patch conditions AC97 control creation by whether or not the
codec is an AD18xx codec. This fixes the case where the default control
would get created and then snd_ac97_mixer_build fails out when creation 
of ad18xx specific control would get attempted. This problem was found 
and debuged by Marcelo Tosatti.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---
 
 ac97_codec.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

---

diff -X usbvideo.dontdiff -X cs5535audio.dontdiff -X linux-2.6.17-rc5/Documentation/dontdiff -uprN linux-2.6.17-rc5-ltv/sound/pci/ac97/ac97_codec.c linux-2.6.17-rc5/sound/pci/ac97/ac97_codec.c
--- linux-2.6.17-rc5-ltv/sound/pci/ac97/ac97_codec.c	2006-05-25 19:27:30.000000000 +0800
+++ linux-2.6.17-rc5/sound/pci/ac97/ac97_codec.c	2006-06-10 17:17:15.000000000 +0800
@@ -1226,7 +1226,8 @@ static int snd_ac97_mixer_build(struct s
 	ac97->regs[AC97_CENTER_LFE_MASTER] = 0x8080;
 
 	/* build center controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER)) {
+	if ((snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER)) 
+		&& !(ac97->flags & AC97_AD_MULTI)) {
 		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_center[0], ac97))) < 0)
 			return err;
 		if ((err = snd_ctl_add(card, kctl = snd_ac97_cnew(&snd_ac97_controls_center[1], ac97))) < 0)
@@ -1238,7 +1239,8 @@ static int snd_ac97_mixer_build(struct s
 	}
 
 	/* build LFE controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER+1)) {
+	if ((snd_ac97_try_volume_mix(ac97, AC97_CENTER_LFE_MASTER+1))
+		&& !(ac97->flags & AC97_AD_MULTI)) {
 		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_lfe[0], ac97))) < 0)
 			return err;
 		if ((err = snd_ctl_add(card, kctl = snd_ac97_cnew(&snd_ac97_controls_lfe[1], ac97))) < 0)
@@ -1250,7 +1252,8 @@ static int snd_ac97_mixer_build(struct s
 	}
 
 	/* build surround controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER)) {
+	if ((snd_ac97_try_volume_mix(ac97, AC97_SURROUND_MASTER)) 
+		&& !(ac97->flags & AC97_AD_MULTI)) {
 		/* Surround Master (0x38) is with stereo mutes */
 		if ((err = snd_ac97_cmix_new_stereo(card, "Surround Playback", AC97_SURROUND_MASTER, 1, ac97)) < 0)
 			return err;
