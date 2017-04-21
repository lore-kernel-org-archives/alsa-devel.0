From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: hda: fix a locking bug in dead code
Date: Fri, 21 Apr 2017 23:55:56 +0300
Message-ID: <20170421205555.vjzh3idi2nv3y5k3@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 240B626727F
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 22:56:11 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Libin Yang <libin.yang@linux.intel.com>
Cc: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Hui Wang <hui.wang@canonical.com>, "Pandiyan,
 Dhinakaran" <dhinakaran.pandiyan@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We added an impossible return to silence a static checker warning but it
introduced another warning because we need to drop the lock before
returning.

Fixes: 960a581e22d9 ("ALSA: hda: fix some klockwork scan warnings")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 90e4ff87445e..0dc18c4a3b1b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1808,9 +1808,12 @@ static bool check_non_pcm_per_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 	/* Add sanity check to pass klockwork check.
 	 * This should never happen.
 	 */
-	if (WARN_ON(spdif == NULL))
-		return true;
+	if (WARN_ON(spdif == NULL)) {
+		non_pcm = true;
+		goto unlock;
+	}
 	non_pcm = !!(spdif->status & IEC958_AES0_NONAUDIO);
+unlock:
 	mutex_unlock(&codec->spdif_mutex);
 	return non_pcm;
 }
