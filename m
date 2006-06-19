From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.17-rc5 1/1] ALSA: AD1888 suspend/resume fix
Date: Mon, 19 Jun 2006 19:40:08 +0800
Message-ID: <200606191140.k5JBe8Ie019357@localhost.localdomain>
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

This patch adds a write to an undocumented register, 0x60 Extended
Codec Register Page in the AD1888 codec. It is neccessary in order
to make suspend/resume work with the AD1888. 

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---
 
 ac97_patch.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

---

diff -X linux-2.6.17-rc5/Documentation/dontdiff -uprN linux-2.6.17-rc5-ltv/sound/pci/ac97/ac97_patch.c linux-2.6.17-rc5-noad1888pm/sound/pci/ac97/ac97_patch.c
--- linux-2.6.17-rc5-ltv/sound/pci/ac97/ac97_patch.c	2006-05-25 19:27:30.000000000 +0800
+++ linux-2.6.17-rc5-noad1888pm/sound/pci/ac97/ac97_patch.c	2006-06-18 12:41:38.000000000 +0800
@@ -1367,6 +1367,13 @@ static void ad18xx_resume(struct snd_ac9
 
 	snd_ac97_restore_iec958(ac97);
 }
+
+static void ad1888_resume(struct snd_ac97 *ac97)
+{
+	ad18xx_resume(ac97);
+	snd_ac97_write_cache(ac97, AC97_CODEC_CLASS_REV, 0x8080);
+}
+
 #endif
 
 int patch_ad1819(struct snd_ac97 * ac97)
@@ -1839,7 +1846,7 @@ static struct snd_ac97_build_ops patch_a
 	.build_post_spdif = patch_ad198x_post_spdif,
 	.build_specific = patch_ad1888_specific,
 #ifdef CONFIG_PM
-	.resume = ad18xx_resume,
+	.resume = ad1888_resume,
 #endif
 	.update_jacks = ad1888_update_jacks,
 };
