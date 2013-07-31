From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: dapm: using freed pointer in
	dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 11:52:44 +0300
Message-ID: <20130731085244.GB8210@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id A1B8F2615CD
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 10:52:58 +0200 (CEST)
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
To: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a typo here so we end up using the old freed pointer instead of
the newly allocated one.  (If the "n" is zero then the code works,
obviously).

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9abb3b2..d74c356 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -225,13 +225,13 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 
 	new_data = krealloc(data, sizeof(*data) + sizeof(widget) * n,
 		GFP_KERNEL);
-	if (!data)
+	if (!new_data)
 		return -ENOMEM;
 
-	data->wlist.widgets[n - 1] = widget;
-	data->wlist.num_widgets = n;
+	new_data->wlist.widgets[n - 1] = widget;
+	new_data->wlist.num_widgets = n;
 
-	kcontrol->private_data = data;
+	kcontrol->private_data = new_data;
 
 	return 0;
 }
