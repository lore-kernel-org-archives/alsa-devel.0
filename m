From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: ab8500-codec: info leak in anc_status_control_put()
Date: Fri, 13 Sep 2013 10:53:36 +0300
Message-ID: <20130913075336.GD19211@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If the user passes an invalid value it leads to an info leak when we
print the error message or it could oops.  This is called with user
supplied data from snd_ctl_elem_write().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index b8ba0ad..80555d7 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1225,13 +1225,18 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 	struct device *dev = codec->dev;
 	bool apply_fir, apply_iir;
-	int req, status;
+	unsigned int req;
+	int status;
 
 	dev_dbg(dev, "%s: Enter.\n", __func__);
 
 	mutex_lock(&drvdata->anc_lock);
 
 	req = ucontrol->value.integer.value[0];
+	if (req >= ARRAY_SIZE(enum_anc_state)) {
+		status = -EINVAL;
+		goto cleanup;
+	}
 	if (req != ANC_APPLY_FIR_IIR && req != ANC_APPLY_FIR &&
 		req != ANC_APPLY_IIR) {
 		dev_err(dev, "%s: ERROR: Unsupported status to set '%s'!\n",
