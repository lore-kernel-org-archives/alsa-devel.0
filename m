From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Baytrail: fix error handling in sst_byt_dsp_init()
Date: Wed, 5 Mar 2014 14:11:57 +0300
Message-ID: <20140305111157.GD16926@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Calling "kfree(byt)" is a double free because that was allocated with
devm_kzalloc().  There were a couple places which leak "byt->msg".  That
memory is allocated in msg_empty_list_init().

Fixes: f7d01fd6754c ('ASoC: Intel: Add Intel Baytrail SST DSP IPC support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index c12e194bbc6b..d0eaeee21be4 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -796,7 +796,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 
 	err = msg_empty_list_init(byt);
 	if (err < 0)
-		goto list_err;
+		return -ENOMEM;
 
 	/* start the IPC message thread */
 	init_kthread_worker(&byt->kworker);
@@ -806,7 +806,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (IS_ERR(byt->tx_thread)) {
 		err = PTR_ERR(byt->tx_thread);
 		dev_err(byt->dev, "error failed to create message TX task\n");
-		goto list_err;
+		goto err_free_msg;
 	}
 	init_kthread_work(&byt->kwork, sst_byt_ipc_tx_msgs);
 
@@ -816,7 +816,7 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	byt->dsp = sst_dsp_new(dev, &byt_dev, pdata);
 	if (byt->dsp == NULL) {
 		err = -ENODEV;
-		goto list_err;
+		goto err_free_msg;
 	}
 
 	/* keep the DSP in reset state for base FW loading */
@@ -848,9 +848,9 @@ boot_err:
 	sst_fw_free(byt_sst_fw);
 fw_err:
 	sst_dsp_free(byt->dsp);
+err_free_msg:
 	kfree(byt->msg);
-list_err:
-	kfree(byt);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(sst_byt_dsp_init);
