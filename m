From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: asihpi: a couple array out of bounds
	issues
Date: Fri, 13 Sep 2013 10:44:44 +0300
Message-ID: <20130913074444.GA19211@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C0E260845
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 09:44:59 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Bill Pemberton <wfp5p@virginia.edu>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These ->put() functions are called from snd_ctl_elem_write() with user
supplied data.  snd_asihpi_tuner_band_put() is missing a limit check and
the check in snd_asihpi_clksrc_put() can underflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index dc632cd..5f2acd3 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1913,6 +1913,7 @@ static int snd_asihpi_tuner_band_put(struct snd_kcontrol *kcontrol,
 	struct snd_card_asihpi *asihpi = snd_kcontrol_chip(kcontrol);
 	*/
 	u32 h_control = kcontrol->private_value;
+	unsigned int idx;
 	u16 band;
 	u16 tuner_bands[HPI_TUNER_BAND_LAST];
 	u32 num_bands = 0;
@@ -1920,7 +1921,10 @@ static int snd_asihpi_tuner_band_put(struct snd_kcontrol *kcontrol,
 	num_bands = asihpi_tuner_band_query(kcontrol, tuner_bands,
 			HPI_TUNER_BAND_LAST);
 
-	band = tuner_bands[ucontrol->value.enumerated.item[0]];
+	idx = ucontrol->value.enumerated.item[0];
+	if (idx >= ARRAY_SIZE(tuner_bands))
+		idx = ARRAY_SIZE(tuner_bands) - 1;
+	band = tuner_bands[idx];
 	hpi_handle_error(hpi_tuner_set_band(h_control, band));
 
 	return 1;
@@ -2383,7 +2387,8 @@ static int snd_asihpi_clksrc_put(struct snd_kcontrol *kcontrol,
 	struct snd_card_asihpi *asihpi =
 			(struct snd_card_asihpi *)(kcontrol->private_data);
 	struct clk_cache *clkcache = &asihpi->cc;
-	int change, item;
+	unsigned int item;
+	int change;
 	u32 h_control = kcontrol->private_value;
 
 	change = 1;
