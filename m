From: "Liao, Bard" <bard.liao@intel.com>
Subject: snd_hdac_device_unregister is called twice on ASoC
	driver
Date: Sun, 28 Apr 2019 01:46:56 +0000
Message-ID: <567A313375B6F043A9BE3A1D9B8C6E7F0B425509@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAFFCF8070B
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 03:47:03 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and all,

We meet a problem that snd_hdac_device_unregister will be called twice
on ASoC driver. We will call snd_hdac_ext_bus_device_init ->
snd_hdac_device_register and snd_hdac_ext_bus_device_remove ->
snd_hdac_device_unregister on ASoC driver. It looks even to me.
However, hdac_hda_codec_probe will call snd_hda_codec_device_new
to create a hda codec device. And it will assign snd_hda_codec_dev_free
to the .dev_free ops where snd_hdac_device_unregister will be called.
That's why snd_hdac_device_unregister will be call twice on ASoC driver.
Below patch can "fix" this issue, but I don't know if it is the right way
to fix it. Could you take a look and give me some advice?

--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -841,7 +841,13 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
        struct hda_codec *codec = device->device_data;

        codec->in_freeing = 1;
-       snd_hdac_device_unregister(&codec->core);
+       /*
+        * snd_hda_codec_device_new() is used by legacy HDA and ASoC driver.
+        * We can't unregister ASoC device since it will be unregistered in
+        * snd_hdac_ext_bus_device_remove().
+        */
+       if (codec->core.type == HDA_DEV_LEGACY)
+               snd_hdac_device_unregister(&codec->core);
        codec_display_power(codec, false);
        put_device(hda_codec_dev(codec));
        return 0;

--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -328,6 +328,12 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
                dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);
                goto error_no_pm;
        }
+       /*
+        * Overwrite type to HDA_DEV_ASOC since it is a ASoC driver
+        * hda_codec.c will check this flag to determine if unregister
+        * device is needed.
+        */
+       hdev->type = HDA_DEV_ASOC;

        /*
         * snd_hda_codec_device_new decrements the usage count so call get pm
