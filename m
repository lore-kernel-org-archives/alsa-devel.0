From: Tobin Davis <tdavis@dsl-only.net>
Subject: [Fwd: Re: Code relsease to alsa.]
Date: Mon, 21 Jan 2008 08:14:31 -0800
Message-ID: <1200932071.30379.41.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9mXNC8frVAehKHsDOjZa"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C2992244E2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 17:14:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Linuxant support (Jonathan)" <support@linuxant.com>, Marc Boucher <marc@linuxant.com>
List-Id: alsa-devel@alsa-project.org


--=-9mXNC8frVAehKHsDOjZa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Forwarded from the good people at Linuxant.

Tobin
-------- Forwarded Message --------
From: Marc Boucher <marc@linuxant.com>
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Linuxant support (Jonathan) <support@linuxant.com>
Subject: Re: Code relsease to alsa.
Date: Mon, 21 Jan 2008 10:33:03 -0500


Tobin,

As promised here is our current tentative patch (relative to the  
current ALSA development tree in hg) for merging with ALSA.

It is also available from:

http://www.linuxant.com/alsa-hg-20080120.patch

Naturally the changes are released under the GPL, so feel free to  
integrate them.

Comments and improvements are welcome.

Kind regards,

Marc

--
Marc Boucher
Linuxant inc.
http://www.linuxant.com



On 19-Jan-08, at 6:40 PM, Marc Boucher wrote:

>
> Hi Tobin,
>
> We have isolated the modifications in patch form and are currently  
> working to merge them with the latest ALSA tree / submit them back  
> upstream.
>
> By the way, all changes and code under the modules/GPL/ directory  
> (including the hda subdirectory) of our modem driver are released  
> under the GPL, so you would be free to take these fixes if you'd like.
>
> However you would be also welcome to reviewing the patches that we  
> are about to submit. I will arrange to send you a copy asap (should  
> be next week).
>
> Kind regards, (and many thanks for your great contributions to ALSA)
>
> Marc
>
> PS: We could also try to help you getting any missing info on the  
> CX20561 or other things from Conexant...
>
> --
> Marc Boucher
> Linuxant inc.
> http://www.linuxant.com
>
> On 19-Jan-08, at 1:07 PM, Tobin Davis wrote:
>
>> Hello,
>>
>> I'm the developer that put the current audio support for the  
>> Conexant HD Audio codecs in alsa.  I worked many hours on this,  
>> with testers around the world sending me feedback.  Most of the  
>> work was done prior to Conexant offering me any documentation.  I  
>> have since received documentation for both CX20549 (Venice), and  
>> CX20551 (Waikiki), but am waiting for the latest info on the new  
>> CX20561, which you apparently already have.
>>
>> I have also seen in your mailing list that you are providing  
>> several fixes to the audio portion of my code, but only making them  
>> available to users of your code, which requires a license agreement  
>> that I believe is incompatible with the GPL.  At the least, it  
>> prohibits someone like me taking any of these fixes and putting  
>> them in the mainstream alsa, where more users would benefit from  
>> them.
>>
>> What I'm asking, is if you could at least provide the audio  
>> modifications back upstream to alsa?  It would help out far more  
>> users (modem usage is on the decline - sorry), and you would have  
>> some benefit in that your name would be in the source as well.
>>
>>
>> -- 
>> Tobin Davis <tdavis@dsl-only.net>
>


-- 
Tobin Davis 


no maintenance:
	Impossible to fix.

--=-9mXNC8frVAehKHsDOjZa
Content-Disposition: attachment; filename=alsa-hg-20080120.patch
Content-Type: application/octet-stream; x-unix-mode=0644; name="alsa-hg-20080120.patch"
Content-Transfer-Encoding: 7bit

diff -ur hda/patch_conexant.c hda-new/patch_conexant.c
--- hda/patch_conexant.c	2008-01-20 12:37:59.000000000 -0500
+++ hda-new/patch_conexant.c	2008-01-20 13:38:49.000000000 -0500
@@ -1,10 +1,12 @@
 /*
- * HD audio interface patch for Conexant HDA audio codec
+ * HD audio interface patch for Conexant HDA audio/modem codec
  *
  * Copyright (c) 2006 Pototskiy Akex <alex.pototskiy@gmail.com>
  * 		      Takashi Iwai <tiwai@suse.de>
  * 		      Tobin Davis  <tdavis@dsl-only.net>
  *
+ * Copyright (c) 2005-2008 Linuxant inc.
+ *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -38,6 +40,13 @@
 #define CONEXANT_MIC_EVENT	0x38
 
 
+#if defined(__i386__)
+#define __shimcall__ __attribute__((regparm(0)))
+#else
+#define __shimcall__
+#endif
+
+//#define CONFIG_SND_DEBUG
 
 struct conexant_spec {
 
@@ -57,6 +66,8 @@
 					 */
 	unsigned int cur_eapd;
 	unsigned int hp_present;
+	unsigned int portb_present;
+	unsigned int portc_present;
 	unsigned int need_dac_fix;
 
 	/* capture */
@@ -74,7 +85,7 @@
 	int num_channel_mode;
 
 	/* PCM information */
-	struct hda_pcm pcm_rec[2];	/* used in build_pcms() */
+	struct hda_pcm pcm[3];	/* used in build_pcms() */
 
 	struct mutex amp_mutex;	/* PCM volume/mute control mutex */
 	unsigned int spdif_route;
@@ -86,6 +97,13 @@
 	struct hda_input_mux private_imux;
 	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
 
+	/* HSF modem */
+	void *modem_devnode;
+	unsigned int modem_stream_tags[2];
+	int modem_do_prepare[2];
+	void (*modem_cbHdaEvent)(void *Context, unsigned int res) __shimcall__;
+	void *modem_cbHdaEventContext;
+	unsigned char modem_cbHdaTag;
 };
 
 static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
@@ -157,8 +175,23 @@
 				      struct snd_pcm_substream *substream)
 {
 	struct conexant_spec *spec = codec->spec;
-	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
-				   stream_tag, 0, format);
+
+	if (spec->num_adc_nids > 1)
+	{
+//	printk(KERN_DEBUG"conexant_capture_pcm_prepare spec->portb_present =%x\n",spec->portb_present);
+//	printk(KERN_DEBUG"conexant_capture_pcm_prepare spec->portc_present =%x\n",spec->portc_present);
+//		if(spec->portb_present)
+//			snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+//						stream_tag, 0, format);
+//		else
+			snd_hda_codec_setup_stream(codec, spec->adc_nids[spec->portc_present],
+						stream_tag, 0, format);
+	}
+	else
+	{
+		snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+					stream_tag, 0, format);
+	}
 	return 0;
 }
 
@@ -167,12 +200,53 @@
 				      struct snd_pcm_substream *substream)
 {
 	struct conexant_spec *spec = codec->spec;
-	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
-				   0, 0, 0);
+
+	if (spec->num_adc_nids > 1)
+	{
+		snd_hda_codec_setup_stream(codec, spec->adc_nids[0],
+					0, 0, 0);
+		snd_hda_codec_setup_stream(codec, spec->adc_nids[1],
+					0, 0, 0);
+	}
+	else
+	{
+		snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
+					0, 0, 0);
+	}
 	return 0;
 }
 
 
+static int conexant_modem_pcm_prepare(struct hda_pcm_stream *hinfo,
+			      struct hda_codec *codec,
+			      unsigned int stream_tag,
+			      unsigned int format,
+			      struct snd_pcm_substream *substream)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	//printk(KERN_DEBUG"%s: codec=%p stream=%d stream_tag=%x format=0x%x substream=%p\n", __FUNCTION__, codec, substream->stream, stream_tag, format, substream);
+
+	spec->modem_stream_tags[substream->stream] = stream_tag;
+
+	return 0;
+}
+
+static int conexant_modem_pcm_open(struct hda_pcm_stream *hinfo, struct hda_codec *codec,
+			    struct snd_pcm_substream *substream)
+{
+	static unsigned int rates[] = { 16000 };
+	static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list = rates,
+		.mask = 0,
+	};
+
+	//printk(KERN_DEBUG"%s: codec=%p substream=%p\n", __FUNCTION__, codec, substream);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
+}
+
 
 static struct hda_pcm_stream conexant_pcm_analog_playback = {
 	.substreams = 1,
@@ -217,28 +291,52 @@
 	/* NID is set in alc_build_pcms */
 };
 
+static struct hda_pcm_stream conexant_modem_pcm = {
+	.substreams = 1,
+	.channels_min = 1,
+	.channels_max = 1,
+	.nid = 0x1,
+	.rates = SNDRV_PCM_RATE_16000,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.maxbps = 16,
+	.ops = {
+		.open = conexant_modem_pcm_open,
+		.prepare = conexant_modem_pcm_prepare,
+	},
+};
+
+/* Used by conexant_build_pcms to flag that a PCM has no playback stream */
+static struct hda_pcm_stream conexant_pcm_null_playback = {
+	.substreams = 0,
+	.channels_min = 0,
+	.channels_max = 0,
+};
+
 static int conexant_build_pcms(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	struct hda_pcm *info = spec->pcm_rec;
+	struct hda_pcm *info = spec->pcm;
 
-	codec->num_pcms = 1;
+	codec->num_pcms = 0;
 	codec->pcm_info = info;
 
-	info->name = "CONEXANT Analog";
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = conexant_pcm_analog_playback;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
-		spec->multiout.max_channels;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
-		spec->multiout.dac_nids[0];
-	info->stream[SNDRV_PCM_STREAM_CAPTURE] = conexant_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_adc_nids;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+	if(codec->afg) {
+		info->name = "Conexant Analog Audio";
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = conexant_pcm_analog_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
+			spec->multiout.max_channels;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
+			spec->multiout.dac_nids[0];
+		info->stream[SNDRV_PCM_STREAM_CAPTURE] = conexant_pcm_analog_capture;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
 
-	if (spec->multiout.dig_out_nid) {
 		info++;
 		codec->num_pcms++;
-		info->name = "Conexant Digital";
+	}
+
+	if (spec->multiout.dig_out_nid) {
+		info->name = "Conexant Digital Audio";
 		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
 			conexant_pcm_digital_playback;
 		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
@@ -249,6 +347,23 @@
 			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =
 				spec->dig_in_nid;
 		}
+
+		info++;
+		codec->num_pcms++;
+	}
+
+	if(codec->mfg) {
+		conexant_modem_pcm.nid = codec->mfg;
+
+		info->name = "Conexant HSF Modem";
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = conexant_modem_pcm;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = conexant_modem_pcm.nid;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE]  = conexant_modem_pcm;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid  = conexant_modem_pcm.nid;
+		info->is_modem = 1;
+
+		info++;
+		codec->num_pcms++;
 	}
 
 	return 0;
@@ -286,13 +401,61 @@
 				     &spec->cur_mux[adc_idx]);
 }
 
+static void *conexant_hsfmodem_interface_funcs[];
+
 static int conexant_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	int i;
+	int i, ret;
+
+	//printk(KERN_DEBUG"%s: codec=%p\n", __FUNCTION__, codec);
+	if(codec->mfg) {
+		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode, void **ppInterfaceFuncs);
+
+    	//snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
+
+		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+		if(!cnxthwhda_probe) {
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+			if(!codec->afg)
+				return -ENOENT;
+		} else {
+			ret = cnxthwhda_probe(codec, codec->bus->card->dev, &spec->modem_devnode, conexant_hsfmodem_interface_funcs);
+			if(ret) {
+				printk(KERN_ERR"%s: cnxthwhda_probe() failed: %d\n", __FUNCTION__, ret);
+				symbol_put(cnxthwhda_probe);
+				if(!codec->afg)
+					return ret;
+			}
+		}
+	}
 
 	for (i = 0; i < spec->num_init_verbs; i++)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
+
+	return 0;
+}
+
+static int conexant_exit(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	//printk(KERN_DEBUG"%s: codec=%p spec=%p\n", __FUNCTION__, codec, spec);
+
+	if(codec->mfg && spec && spec->modem_devnode) {
+		void (*cnxthwhda_remove)(void *ptr);
+
+		cnxthwhda_remove = (void*)symbol_request(cnxthwhda_remove);
+		if(cnxthwhda_remove) {
+			cnxthwhda_remove(spec->modem_devnode);
+			spec->modem_devnode = NULL;
+			symbol_put(cnxthwhda_remove);
+			symbol_put(cnxthwhda_probe);
+		} else {
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_remove) failed\n", __FUNCTION__);
+		}
+	}
+
 	return 0;
 }
 
@@ -301,14 +464,118 @@
         struct conexant_spec *spec = codec->spec;
         unsigned int i;
 
-        if (spec->kctl_alloc) {
+		if(spec) {
+			codec->spec = NULL;
+			memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+
+        	if (spec->kctl_alloc) {
                 for (i = 0; i < spec->num_kctl_used; i++)
                         kfree(spec->kctl_alloc[i].name);
                 kfree(spec->kctl_alloc);
-        }
+        	}
+			kfree(spec);
+		}
+}
+
+static void conexant_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	//printk(KERN_DEBUG"%s: codec=%p res=0x%02x spec=%p cbHdaEvent=%p\n", __FUNCTION__, codec, res, spec, spec->modem_cbHdaEvent);
+
+	if(codec->mfg && spec && spec->modem_cbHdaEvent) {
+		if(((res >> 26) & 0x3f) == spec->modem_cbHdaTag) {
+			//printk(KERN_DEBUG"%s: res=0x%02x cbHdaEvent=%p\n", __FUNCTION__, res, spec->modem_cbHdaEvent);
+			//printk(KERN_DEBUG"%s: calling cbHdaEvent=%p ctx=%p\n", __FUNCTION__, spec->modem_cbHdaEvent, spec->modem_cbHdaEventContext);
+			spec->modem_cbHdaEvent(spec->modem_cbHdaEventContext, res);
+		} else {
+			printk(KERN_DEBUG"%s: ignoring res=0x08%x\n", __FUNCTION__, res);
+		}
+	}
+}
+
+typedef struct tagHDAOSHAL {
+	void *hda_codec;
+	int bInSuspendResume;
+} HDAOSHAL, *PHDAOSHAL;
+
+typedef struct tagOS_DEVNODE {
+    void *hwDev;
+    // intentionally left incomplete
+} OS_DEVNODE, *POS_DEVNODE;
+
+#ifdef CONFIG_PM
+static int conexant_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	struct conexant_spec *spec = codec->spec;
+	int (*cnxthwhda_suspend)(void *devnode, pm_message_t state);
+	int ret = 0;
+
+	//printk(KERN_DEBUG"%s: codec=%p spec=%p state=0x%x\n", __FUNCTION__, codec, spec, *((u32 *)&state));
+
+	if(spec && spec->modem_devnode) {
+		cnxthwhda_suspend = (void*)symbol_request(cnxthwhda_suspend);
+		if(!cnxthwhda_suspend) {
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_suspend) failed\n", __FUNCTION__);
+			return -ENOSYS;
+		}
+
+		if(((POS_DEVNODE)spec->modem_devnode)->hwDev) {
+			((PHDAOSHAL)((POS_DEVNODE)spec->modem_devnode)->hwDev)->bInSuspendResume++;
+		}
+		ret = cnxthwhda_suspend(spec->modem_devnode, state);
+		if(((POS_DEVNODE)spec->modem_devnode)->hwDev) {
+			((PHDAOSHAL)((POS_DEVNODE)spec->modem_devnode)->hwDev)->bInSuspendResume--;
+		}
+		symbol_put(cnxthwhda_suspend);
+	}
+
+	return ret;
+}
+
+static int conexant_resume(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	int ret = 0;
+	hda_nid_t mfg;
+
+	mfg = codec->mfg;
+	codec->mfg = 0;
+	codec->patch_ops.init(codec);
+	codec->mfg = mfg;
+
+	snd_hda_codec_resume_amp(codec);
+	snd_hda_codec_resume_cache(codec);
+
+	if(spec && spec->modem_devnode) {
+		int (*cnxthwhda_resume)(void *devnode);
 
-	kfree(codec->spec);
+		//printk(KERN_DEBUG"%s: codec=%p spec=%p\n", __FUNCTION__, codec, spec);
+
+		cnxthwhda_resume = (void*)symbol_request(cnxthwhda_resume);
+		if(!cnxthwhda_resume) {
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_resume) failed\n", __FUNCTION__);
+			return -ENOSYS;
+		}
+
+    	//snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
+
+		if(((POS_DEVNODE)spec->modem_devnode)->hwDev) {
+			((PHDAOSHAL)((POS_DEVNODE)spec->modem_devnode)->hwDev)->bInSuspendResume++;
+		}
+
+		ret = cnxthwhda_resume(spec->modem_devnode);
+
+		if(((POS_DEVNODE)spec->modem_devnode)->hwDev) {
+			((PHDAOSHAL)((POS_DEVNODE)spec->modem_devnode)->hwDev)->bInSuspendResume--;
+		}
+
+		symbol_put(cnxthwhda_resume);
+	}
+
+	return ret;
 }
+#endif
 
 static int conexant_build_controls(struct hda_codec *codec)
 {
@@ -339,9 +606,47 @@
 	.build_controls = conexant_build_controls,
 	.build_pcms = conexant_build_pcms,
 	.init = conexant_init,
+	.exit = conexant_exit,
 	.free = conexant_free,
+	.unsol_event = conexant_unsol_event,
+#ifdef CONFIG_PM
+	.suspend = conexant_suspend,
+	.resume = conexant_resume,
+#endif
 };
 
+static int patch_cxthsfmodem(struct hda_codec *codec)
+{
+	struct conexant_spec *spec;
+	int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
+
+	//printk(KERN_DEBUG"%s: codec=%p\n", __FUNCTION__, codec);
+	if(!codec->mfg) { // we only support modems here
+		return -ENODEV;
+	}
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	mutex_init(&spec->amp_mutex);
+	codec->spec = spec;
+
+	codec->patch_ops = conexant_patch_ops;
+
+	cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+	if(cnxthwhda_probe) {
+		symbol_put(cnxthwhda_probe);
+	} else {
+		printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+		codec->spec = NULL;
+		memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+		kfree(spec);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 /*
  * EAPD control
  * the private value = nid | (invert << 8)
@@ -438,18 +743,19 @@
 
 #endif /* CONFIG_SND_DEBUG */
 
-/* Conexant 5045 specific */
-
-static hda_nid_t cxt5045_dac_nids[1] = { 0x19 };
-static hda_nid_t cxt5045_adc_nids[1] = { 0x1a };
-static hda_nid_t cxt5045_capsrc_nids[1] = { 0x1a };
-#define CXT5045_SPDIF_OUT	0x13
+/* Conexant 5051 specific */
+static hda_nid_t cxt5051_dac_nids[1] = { 0x10 };
+static hda_nid_t cxt5051_adc_nids[2] = { 0x14,0x15 };
+static hda_nid_t cxt5051_capsrc_nids[2] = { 0x14,0x15 };
+#define CXT5051_SPDIF_OUT	0x1C
+#define CXT5051_PORTB_EVENT	0x38
+#define CXT5051_PORTC_EVENT	0x39
 
-static struct hda_channel_mode cxt5045_modes[1] = {
+static struct hda_channel_mode cxt5051_modes[1] = {
 	{ 2, NULL },
 };
 
-static struct hda_input_mux cxt5045_capture_source = {
+static struct hda_input_mux cxt5051_capture_source = {
 	.num_items = 2,
 	.items = {
 		{ "IntMic", 0x1 },
@@ -467,6 +773,362 @@
 };
 
 /* turn on/off EAPD (+ mute HP) as a master switch */
+static int cxt5051_hp_master_sw_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	static struct hda_verb spk_on[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb spk_off[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+	static struct hda_verb hp_on[] = {
+		{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb hp_off[] = {
+		{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct conexant_spec *spec = codec->spec;
+	unsigned int bits;
+
+	if (!cxt_eapd_put(kcontrol, ucontrol))
+		return 0;
+
+	/* toggle internal speakers mute depending of presence of
+	 * the headphone jack
+	 */
+	bits = (!spec->hp_present && spec->cur_eapd) ? 0 : 0x80;
+	if (bits)
+		snd_hda_sequence_write(codec, spk_off);
+	else
+		snd_hda_sequence_write(codec, spk_on);
+
+	bits = (spec->cur_eapd) ? 0 : 0x80;
+	if (bits)
+		snd_hda_sequence_write(codec, hp_off);
+	else
+		snd_hda_sequence_write(codec, hp_on);
+
+	return 1;
+}
+
+/* bind volumes of both NID 0x10 and 0x11 */
+static int cxt5051_hp_master_vol_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change;
+
+	change = snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0,
+					  0x7f, valp[0] & 0x7f);
+	change |= snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0,
+					   0x7f, valp[1] & 0x7f);
+	return change;
+}
+
+/* toggle input of built-in and mic jack appropriately */
+static void cxt5051_portb_automic(struct hda_codec *codec)
+{
+	static struct hda_verb mic_jack_on[] = {
+		{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+		{}
+	};
+	static struct hda_verb mic_jack_off[] = {
+		{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+		{}
+	};
+	unsigned int present;
+	struct conexant_spec *spec = codec->spec;
+
+	present = snd_hda_codec_read(codec, 0x17, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	printk(KERN_DEBUG"cxt5051_portb_automic present =%x\n",present);
+
+	if (present)
+	{
+		spec->portb_present = 1;
+		snd_hda_sequence_write(codec, mic_jack_on);
+	}
+	else
+	{
+		spec->portb_present = 0;
+		snd_hda_sequence_write(codec, mic_jack_off);
+	}
+
+}
+
+static void cxt5051_portc_automic(struct hda_codec *codec)
+{
+	unsigned int present;
+	struct conexant_spec *spec = codec->spec;
+	present = snd_hda_codec_read(codec, 0x18, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	printk(KERN_DEBUG"cxt5051_portc_automic present =%x\n",present);
+
+	if (present)
+			spec->portc_present = 1;
+	else
+			spec->portc_present = 0;
+
+}
+
+/* mute internal speaker if HP is plugged */
+static void cxt5051_hp_automute(struct hda_codec *codec)
+{
+	static struct hda_verb spk_on[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+		{}
+	};
+	static struct hda_verb spk_off[] = {
+		{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+		{}
+	};
+
+	struct conexant_spec *spec = codec->spec;
+	unsigned int bits;
+
+	spec->hp_present = snd_hda_codec_read(codec, 0x16, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+
+	bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0; 
+	if (bits)
+		snd_hda_sequence_write(codec, spk_off);
+	else
+		snd_hda_sequence_write(codec, spk_on);
+
+	printk(KERN_DEBUG"cxt5051_hp_automute bits =%x\n",bits);
+}
+
+/* unsolicited event for HP jack sensing */
+static void cxt5051_hp_unsol_event(struct hda_codec *codec,
+				   unsigned int res)
+{
+	switch (res >> 26) {
+	case CONEXANT_HP_EVENT:
+		cxt5051_hp_automute(codec);
+		break;
+	case CXT5051_PORTB_EVENT:
+		cxt5051_portb_automic(codec);
+		break;
+	case CXT5051_PORTC_EVENT:
+		cxt5051_portc_automic(codec);
+		break;
+
+	default:
+		conexant_unsol_event(codec, res);
+		break;
+
+	}
+}
+
+static struct snd_kcontrol_new cxt5051_mixers[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put
+	},
+//	HDA_CODEC_VOLUME("Int Mic Volume", 0x14, 0x00, HDA_INPUT),
+//	HDA_CODEC_MUTE("Int Mic Switch", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Volume", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("External Mic Volume", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("External Mic Switch", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Docking Mic Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Docking Mic Switch", 0x15, 0x00, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = snd_hda_mixer_amp_volume_info,
+		.get = snd_hda_mixer_amp_volume_get,
+		.put = cxt5051_hp_master_vol_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x10, 3, 0, HDA_OUTPUT),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
+		.put = cxt5051_hp_master_sw_put,
+		.private_value = 0x1A,
+	},
+
+	{}
+};
+
+static struct hda_verb cxt5051_init_verbs[] = {
+	/* Line in, Mic */
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	|AC_AMP_SET_RIGHT|0x3},
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	|AC_AMP_SET_RIGHT|0x3},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x1D, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x1D, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_LEFT
+	|AC_AMP_SET_RIGHT|0x3},
+	/* SPK  */
+	{0x1A, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x00},
+	/* HP, Amp  */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP|PIN_OUT },
+	{0x16, AC_VERB_SET_CONNECT_SEL,0x00},
+	/* DAC1 */	
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x01},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x02},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x03},
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x04},
+	/* Record selector: Int mic */
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x44},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|
+	AC_AMP_SET_LEFT|0x44|1<<AC_AMP_SET_INDEX_SHIFT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x44},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE,AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|
+	AC_AMP_SET_LEFT|0x44|1<<AC_AMP_SET_INDEX_SHIFT},
+	/* SPDIF route: PCM */
+	{ 0x1C, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	/* EAPD */
+	{0x1A, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5051_PORTB_EVENT},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CXT5051_PORTC_EVENT},
+	{ } /* end */
+};
+
+
+#if 0
+static struct hda_verb cxt5051_mic_wid1d_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x14, AC_VERB_SET_CONNECT_SEL,0x0},
+	{ } /* end */
+};
+#endif
+
+/* For HP's configuration always use portB as Internal and External Mic */
+static struct hda_verb cxt5051_mic_wid17_init_verbs[] = {
+	/* pin sensing on HP jack */
+	{0x14, AC_VERB_SET_CONNECT_SEL,0x1},
+	{ } /* end */
+};
+
+
+/* initialize jack-sensing, too */
+static int cxt5051_init(struct hda_codec *codec)
+{
+	conexant_init(codec);
+	return 0;
+}
+
+
+enum {
+	CXT5051_LAPTOP,	 /* Laptops w/ EAPD support */
+	CXT5051_MODELS
+};
+
+static const char *cxt5051_models[CXT5051_MODELS] = {
+	[CXT5051_LAPTOP]	= "laptop",
+};
+
+static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x14F1, 0x0101, "Conexant Reference board", CXT5051_LAPTOP),
+	{}
+};
+
+static int patch_cxt5051(struct hda_codec *codec)
+{
+	struct conexant_spec *spec;
+	int board_config;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	mutex_init(&spec->amp_mutex);
+	codec->spec = spec;
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = ARRAY_SIZE(cxt5051_dac_nids);
+	spec->multiout.dac_nids = cxt5051_dac_nids;
+	spec->multiout.dig_out_nid = CXT5051_SPDIF_OUT;
+	spec->num_adc_nids = 2;
+	spec->adc_nids = cxt5051_adc_nids;
+	spec->capsrc_nids = cxt5051_capsrc_nids;
+	spec->input_mux = &cxt5051_capture_source;
+	spec->num_mixers = 1;
+	spec->mixers[0] = cxt5051_mixers;
+	spec->num_init_verbs = 1;
+	spec->init_verbs[0] = cxt5051_init_verbs;
+	spec->spdif_route = 0;
+	spec->num_channel_mode = ARRAY_SIZE(cxt5051_modes),
+	spec->channel_mode = cxt5051_modes,
+	spec->portb_present = 0;
+	spec->portc_present = 0;
+
+	codec->patch_ops = conexant_patch_ops;
+
+	board_config = snd_hda_check_board_config(codec, CXT5051_MODELS,
+						  cxt5051_models,
+						  cxt5051_cfg_tbl);
+	switch (board_config) {
+	default:
+	case CXT5051_LAPTOP:
+		codec->patch_ops.unsol_event = cxt5051_hp_unsol_event;
+		spec->input_mux = &cxt5051_capture_source;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5051_mic_wid17_init_verbs;
+		spec->mixers[0] = cxt5051_mixers;
+		codec->patch_ops.init = cxt5051_init;
+		break;
+	}
+
+	if(codec->mfg) {
+		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
+		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+		if(cnxthwhda_probe)
+			symbol_put(cnxthwhda_probe);
+		else
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+	}
+
+	return 0;
+}
+
+
+
+
+/* Conexant 5045 specific */
+
+static hda_nid_t cxt5045_dac_nids[1] = { 0x19 };
+static hda_nid_t cxt5045_adc_nids[1] = { 0x1a };
+static hda_nid_t cxt5045_capsrc_nids[1] = { 0x1a };
+#define CXT5045_SPDIF_OUT	0x13
+
+static struct hda_channel_mode cxt5045_modes[1] = {
+	{ 2, NULL },
+};
+
+static struct hda_input_mux cxt5045_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "IntMic", 0x1 },
+		{ "ExtMic", 0x2 },
+	}
+};
+
+/* turn on/off EAPD (+ mute HP) as a master switch */
 static int cxt5045_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
@@ -504,13 +1166,15 @@
 static void cxt5045_hp_automic(struct hda_codec *codec)
 {
 	static struct hda_verb mic_jack_on[] = {
-		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT | AC_AMP_MUTE},
+		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT},
+		{0x1a, AC_VERB_SET_CONNECT_SEL, 0x02},
 		{}
 	};
 	static struct hda_verb mic_jack_off[] = {
-		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT | AC_AMP_MUTE},
+		{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT},
+		{0x1a, AC_VERB_SET_CONNECT_SEL, 0x01},
 		{}
 	};
 	unsigned int present;
@@ -542,14 +1206,19 @@
 static void cxt5045_hp_unsol_event(struct hda_codec *codec,
 				   unsigned int res)
 {
-	res >>= 26;
-	switch (res) {
+	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
+		//printk("%s: CONEXANT_HP_EVENT\n", __FUNCTION__);
 		cxt5045_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
+		//printk("%s: CONEXANT_MIC_EVENT\n", __FUNCTION__);
 		cxt5045_hp_automic(codec);
 		break;
+	default:
+		//printk("%s: CONEXANT_OTHER_EVENT\n", __FUNCTION__);
+		conexant_unsol_event(codec, res);
+		break;
 
 	}
 }
@@ -595,8 +1264,9 @@
 };
 
 static struct hda_verb cxt5045_init_verbs[] = {
-	/* Line in, Mic */
-	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	/* ExtMic in, IntMic */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x12, AC_VERB_SET_CONNECT_SEL, 0x1 },
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
 	/* HP, Amp  */
 	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -673,6 +1343,11 @@
 
 static struct snd_kcontrol_new cxt5045_test_mixer[] = {
 
+	HDA_CODEC_VOLUME("Int Mic Volume", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Volume", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Switch", 0x1a, 0x02, HDA_INPUT),
+
 	/* Output controls */
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x10, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x10, 0x0, HDA_OUTPUT),
@@ -781,8 +1456,9 @@
 
 
 enum {
-	CXT5045_LAPTOP,	 /* Laptops w/ EAPD support */
-	CXT5045_FUJITSU, /* Laptops w/ EAPD support */ 
+	CXT5045_LAPTOP_HPSENSE,
+	CXT5045_LAPTOP_MICSENSE,
+	CXT5045_LAPTOP_HPMICSENSE,
 	CXT5045_BENQ,
 #ifdef CONFIG_SND_DEBUG
 	CXT5045_TEST,
@@ -791,27 +1467,34 @@
 };
 
 static const char *cxt5045_models[CXT5045_MODELS] = {
-	[CXT5045_LAPTOP]	= "laptop",
-	[CXT5045_FUJITSU]	= "fujitsu",
-	[CXT5045_BENQ]		= "benq",
+	[CXT5045_LAPTOP_HPSENSE]	= "laptop-hpsense",
+	[CXT5045_LAPTOP_MICSENSE]	= "laptop-micsense",
+	[CXT5045_LAPTOP_HPMICSENSE]	= "laptop-hpmicsense",
+	[CXT5045_BENQ]			= "benq",
 #ifdef CONFIG_SND_DEBUG
 	[CXT5045_TEST]		= "test",
 #endif
 };
 
 static struct snd_pci_quirk cxt5045_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x103c, 0x30b2, "HP DV Series", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30b7, "HP DV6000Z", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x103c, 0x30d9, "HP Spartan", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30a5, "HP", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30b2, "HP DV Series", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30b7, "HP DV6000Z", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30d9, "HP Spartan", CXT5045_LAPTOP_HPSENSE),
 	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
-	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
-	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x1734, 0x110e, "Fujitsu V5505", CXT5045_LAPTOP),
-	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP_MICSENSE),
+	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x1734, 0x110e, "Fujitsu V5505", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x1509, 0x1e40, "FIC", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x1509, 0x2f05, "FIC", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x1509, 0x2f06, "FIC", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x1631, 0xc106, "Packard Bell", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x1631, 0xc107, "Packard Bell", CXT5045_LAPTOP_HPMICSENSE),
+	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP_HPSENSE),
 	{}
 };
 
@@ -848,8 +1531,9 @@
 	board_config = snd_hda_check_board_config(codec, CXT5045_MODELS,
 						  cxt5045_models,
 						  cxt5045_cfg_tbl);
+	//printk(KERN_DEBUG"%s: board_config=%d\n", __FUNCTION__, board_config);
 	switch (board_config) {
-	case CXT5045_LAPTOP:
+	case CXT5045_LAPTOP_HPSENSE:
 		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
 		spec->input_mux = &cxt5045_capture_source;
 		spec->num_init_verbs = 2;
@@ -857,13 +1541,24 @@
 		spec->mixers[0] = cxt5045_mixers;
 		codec->patch_ops.init = cxt5045_init;
 		break;
-	case CXT5045_FUJITSU:
+	case CXT5045_LAPTOP_MICSENSE:
+		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
 		spec->input_mux = &cxt5045_capture_source;
 		spec->num_init_verbs = 2;
 		spec->init_verbs[1] = cxt5045_mic_sense_init_verbs;
 		spec->mixers[0] = cxt5045_mixers;
 		codec->patch_ops.init = cxt5045_init;
 		break;
+	default:
+	case CXT5045_LAPTOP_HPMICSENSE:
+		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
+		spec->input_mux = &cxt5045_capture_source;
+		spec->num_init_verbs = 3;
+		spec->init_verbs[1] = cxt5045_hp_sense_init_verbs;
+		spec->init_verbs[2] = cxt5045_mic_sense_init_verbs;
+		spec->mixers[0] = cxt5045_mixers;
+		codec->patch_ops.init = cxt5045_init;
+		break;
 	case CXT5045_BENQ:
 		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
 		spec->input_mux = &cxt5045_capture_source_benq;
@@ -880,6 +1575,8 @@
 		spec->mixers[0] = cxt5045_test_mixer;
 		spec->init_verbs[0] = cxt5045_test_init_verbs;
 #endif	
+		break;
+		
 	}
 
 	/*
@@ -892,6 +1589,15 @@
 				  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
 				  (1 << AC_AMPCAP_MUTE_SHIFT));
 
+	if(codec->mfg) {
+		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
+		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+		if(cnxthwhda_probe)
+			symbol_put(cnxthwhda_probe);
+		else
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+	}
+
 	return 0;
 }
 
@@ -1000,13 +1706,13 @@
 static void cxt5047_hp_automic(struct hda_codec *codec)
 {
 	static struct hda_verb mic_jack_on[] = {
-		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT | AC_AMP_MUTE},
+		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT},
 		{}
 	};
 	static struct hda_verb mic_jack_off[] = {
-		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
+		{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT | AC_AMP_MUTE},
+		{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AC_AMP_SET_RIGHT | AC_AMP_SET_LEFT | AC_AMP_SET_OUTPUT},
 		{}
 	};
 	unsigned int present;
@@ -1023,14 +1729,16 @@
 static void cxt5047_hp_unsol_event(struct hda_codec *codec,
 				  unsigned int res)
 {
-	res >>= 26;
-	switch (res) {
+	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
 		cxt5047_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
 		cxt5047_hp_automic(codec);
 		break;
+	default:
+		conexant_unsol_event(codec, res);
+		break;
 	}
 }
 
@@ -1233,6 +1941,17 @@
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put,
 	},
+	HDA_CODEC_VOLUME("Input-1 Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-1 Switch", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-2 Volume", 0x1a, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-2 Switch", 0x1a, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-3 Volume", 0x1a, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-3 Switch", 0x1a, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-4 Volume", 0x1a, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-4 Switch", 0x1a, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-5 Volume", 0x1a, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-5 Switch", 0x1a, 0x4, HDA_INPUT),
+
 	{ } /* end */
 };
 
@@ -1388,6 +2107,16 @@
 		codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
 #endif	
 	}
+
+	if(codec->mfg) {
+		int (*cnxthwhda_probe)(void *codec, struct device *hwDev, void **ppDevNode);
+		cnxthwhda_probe = (void*)symbol_request(cnxthwhda_probe);
+		if(cnxthwhda_probe)
+			symbol_put(cnxthwhda_probe);
+		else
+			printk(KERN_ERR"%s: symbol_request(cnxthwhda_probe) failed\n", __FUNCTION__);
+	}
+
 	return 0;
 }
 
@@ -1396,5 +2125,430 @@
 	  .patch = patch_cxt5045 },
 	{ .id = 0x14f15047, .name = "CX20551 (Waikiki)",
 	  .patch = patch_cxt5047 },
+	{ .id = 0x14f15051, .name = "CX20561 (Hermosa)",
+	  .patch = patch_cxt5051 },
+	{ .id = 0x14f12bfa, .mfg = 2, .name = "HSF",
+	  .patch = patch_cxthsfmodem },
+	{ .id = 0x14f12c06, .mfg = 2, .name = "HSF",
+	  .patch = patch_cxthsfmodem },
+	{ .id = 0x14f10000, .mask = 0xffff0000, .mfg = 2, .name = "HSF",
+	  .patch = patch_cxthsfmodem },
 	{} /* terminator */
 };
+
+
+
+typedef enum {
+	OsHdaStreamStateReset = 0,
+	OsHdaStreamStateStop  = 1,
+	OsHdaStreamStateRun   = 2
+} OSHDA_STREAM_STATE;
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecGetAddr(PHDAOSHAL pHdaOsHal)
+{
+	return ((struct hda_codec *)pHdaOsHal->hda_codec)->addr;
+}
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecGetVendorId(PHDAOSHAL pHdaOsHal)
+{
+	return ((struct hda_codec *)pHdaOsHal->hda_codec)->vendor_id;
+}
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecGetSubsystemId(PHDAOSHAL pHdaOsHal)
+{
+	return ((struct hda_codec *)pHdaOsHal->hda_codec)->subsystem_id;
+}
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecGetRevisionId(PHDAOSHAL pHdaOsHal)
+{
+	return ((struct hda_codec *)pHdaOsHal->hda_codec)->revision_id;
+}
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecRead(PHDAOSHAL pHdaOsHal, unsigned short nid, int direct, unsigned int verb, unsigned int para)
+{
+#if 1
+	return snd_hda_codec_read((struct hda_codec *)pHdaOsHal->hda_codec, nid, direct, verb, para);
+#else
+	unsigned int res;
+
+	res = snd_hda_codec_read((struct hda_codec *)pHdaOsHal->hda_codec, nid, direct, verb, para);
+
+	printk(KERN_DEBUG"%s: nid=%x direct=%d verb=0x%x para=0x%x res=0x%08x\n", __FUNCTION__, nid, direct, verb, para, res);
+
+	return res;
+#endif
+}
+
+static __shimcall__
+unsigned int conexant_hsfmodem_OsHdaCodecWallclock(PHDAOSHAL pHdaOsHal)
+{
+	return snd_hda_codec_wallclock((struct hda_codec *)pHdaOsHal->hda_codec);
+}
+
+static __shimcall__
+void conexant_hsfmodem_OsHdaCodecSetEventCallback(PHDAOSHAL pHdaOsHal, void (*cbHdaEvent)(void *Context, unsigned int res), void *cbHdaEventContext, unsigned char *cbHdaTag)
+{
+	struct conexant_spec *spec = ((struct hda_codec *)pHdaOsHal->hda_codec)->spec;
+
+	*cbHdaTag = ((struct hda_codec *)pHdaOsHal->hda_codec)->mfg;
+
+	spec->modem_cbHdaTag = *cbHdaTag;
+	spec->modem_cbHdaEventContext = cbHdaEventContext;
+	spec->modem_cbHdaEvent = (void*)cbHdaEvent;
+}
+
+static __shimcall__
+void conexant_hsfmodem_OsHdaCodecClearEventCallback(PHDAOSHAL pHdaOsHal, unsigned char cbHdaTag)
+{
+	struct conexant_spec *spec = ((struct hda_codec *)pHdaOsHal->hda_codec)->spec;
+
+	if(spec) {
+		spec->modem_cbHdaEvent = NULL;
+		spec->modem_cbHdaEventContext = NULL;
+		spec->modem_cbHdaTag = 0;
+	}
+}
+
+
+#include <sound/pcm_params.h>
+
+static int snd_interval_refine_set(struct snd_interval *i, unsigned int val)
+{
+	struct snd_interval t;
+	t.empty = 0;
+	t.min = t.max = val;
+	t.openmin = t.openmax = 0;
+	t.integer = 1;
+	return snd_interval_refine(i, &t);
+}
+
+static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
+				 snd_pcm_hw_param_t var, unsigned int val,
+				 int dir)
+{
+	int changed;
+	if (hw_is_mask(var)) {
+		struct snd_mask *m = hw_param_mask(params, var);
+		if (val == 0 && dir < 0) {
+			changed = -EINVAL;
+			snd_mask_none(m);
+		} else {
+			if (dir > 0)
+				val++;
+			else if (dir < 0)
+				val--;
+			changed = snd_mask_refine_set(hw_param_mask(params, var), val);
+		}
+	} else if (hw_is_interval(var)) {
+		struct snd_interval *i = hw_param_interval(params, var);
+		if (val == 0 && dir < 0) {
+			changed = -EINVAL;
+			snd_interval_none(i);
+		} else if (dir == 0)
+			changed = snd_interval_refine_set(i, val);
+		else {
+			struct snd_interval t;
+			t.openmin = 1;
+			t.openmax = 1;
+			t.empty = 0;
+			t.integer = 0;
+			if (dir < 0) {
+				t.min = val - 1;
+				t.max = val;
+			} else {
+				t.min = val;
+				t.max = val+1;
+			}
+			changed = snd_interval_refine(i, &t);
+		}
+	} else
+		return -EINVAL;
+	if (changed) {
+		params->cmask |= 1 << var;
+		params->rmask |= 1 << var;
+	}
+	return changed;
+}
+
+static int conexant_modem_snd_pcm_change_params(struct snd_pcm_substream *substream, int hw_param_buffer_bytes)
+{
+	struct snd_pcm_hw_params *sparams;
+	int err;
+
+	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
+	if (/*!params ||*/ !sparams) {
+		return -ENOMEM;
+	}
+
+	_snd_pcm_hw_params_any(sparams);
+	_snd_pcm_hw_param_set(sparams, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+                                      hw_param_buffer_bytes, 0);
+
+	snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
+
+	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, sparams)) < 0) {
+		printk(KERN_ERR"%s: SNDRV_PCM_IOCTL_HW_PARAMS failed (%d)\n", __FUNCTION__, err);
+		//return err;
+	}
+
+	return 0;
+}
+
+static int conexant_modem_snd_pcm_prepare_substream(PHDAOSHAL pHdaOsHal, struct snd_pcm_substream *substream)
+{
+	int err;
+	struct conexant_spec *spec = ((struct hda_codec *)pHdaOsHal->hda_codec)->spec;
+
+	if(spec->modem_do_prepare[substream->stream]) {
+		err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_PREPARE, NULL);
+		if (err < 0) {
+			printk(KERN_ERR"%s: SNDRV_PCM_IOCTL_PREPARE failed (%d)\n", __FUNCTION__, err);
+			return err;
+		}
+		spec->modem_do_prepare[substream->stream] = 0;
+	}
+
+	return 0;
+}
+
+static __shimcall__
+int conexant_hsfmodem_OsHdaCodecOpenDMA(PHDAOSHAL pHdaOsHal, int hw_param_buffer_bytes, void **ppPlaybackStream, void **ppCaptureStream)
+{
+	int i, err;
+	struct hda_codec *codec = (struct hda_codec *)pHdaOsHal->hda_codec;
+	struct hda_pcm *info = codec->pcm_info;
+	struct snd_pcm *pcm;
+	struct conexant_spec *spec = codec->spec;
+
+	struct snd_pcm_substream *psubstream = NULL, *csubstream = NULL;
+	static struct file fil;
+
+	for(i = 0; i < codec->num_pcms && !info[i].is_modem; i++);
+	if(i == codec->num_pcms) {
+		printk(KERN_ERR"%s: modem pcm not found\n", __FUNCTION__);
+		return -ENOENT;
+	}
+	pcm = info[i].pcm;
+
+	if ((err = snd_pcm_open_substream(pcm, SNDRV_PCM_STREAM_PLAYBACK, &fil, &psubstream)) < 0) {
+		printk(KERN_ERR"%s: snd_pcm_open_substream STREAM_PLAYBACK failed (%d)\n", __FUNCTION__, err);
+		return err;
+	}
+
+	if ((err = snd_pcm_open_substream(pcm, SNDRV_PCM_STREAM_CAPTURE, &fil, &csubstream)) < 0) {
+		printk(KERN_ERR"%s: snd_pcm_open_substream STREAM_CAPTURE failed (%d)\n", __FUNCTION__, err);
+		return err;
+	}
+
+	err = conexant_modem_snd_pcm_change_params(psubstream, hw_param_buffer_bytes);
+	if (err < 0) {
+		printk(KERN_ERR"%s: conexant_modem_snd_pcm_change_params STREAM_PLAYBACK failed (%d)\n", __FUNCTION__, err);
+	}
+
+	err = conexant_modem_snd_pcm_change_params(csubstream, hw_param_buffer_bytes);
+	if (err < 0) {
+		printk(KERN_ERR"%s: conexant_modem_snd_pcm_change_params STREAM_CAPTURE failed (%d)\n", __FUNCTION__, err);
+	}
+
+#if 0
+	printk(KERN_DEBUG"%s: psubstream=%p dma_buffer_p=%p area=%p addr=0x%lx bytes=%d\n", __FUNCTION__,
+			psubstream,
+			psubstream->runtime->dma_buffer_p,
+			psubstream->runtime->dma_area,
+			(unsigned long)psubstream->runtime->dma_addr,
+			psubstream->runtime->dma_bytes);
+
+	printk(KERN_DEBUG"%s: csubstream=%p dma_buffer_p=%p area=%p addr=0x%lx bytes=%d\n", __FUNCTION__,
+			csubstream,
+			csubstream->runtime->dma_buffer_p,
+			csubstream->runtime->dma_area,
+			(unsigned long)csubstream->runtime->dma_addr,
+			csubstream->runtime->dma_bytes);
+#endif
+
+	spec->modem_do_prepare[psubstream->stream] = 1;
+	spec->modem_do_prepare[csubstream->stream] = 1;
+
+	if ((err = conexant_modem_snd_pcm_prepare_substream(pHdaOsHal, psubstream)) < 0)
+		return err;
+
+	if ((err = conexant_modem_snd_pcm_prepare_substream(pHdaOsHal, csubstream)) < 0)
+		return err;
+
+	*ppPlaybackStream = psubstream;
+	*ppCaptureStream = csubstream;
+
+	return 0;
+}
+
+static void conexant_modem_snd_pcm_close_stream(struct snd_pcm_substream *substream)
+{
+#if SNDRV_PCM_VERSION <= SNDRV_PROTOCOL_VERSION(2, 0, 7)
+	snd_pcm_stream_lock_irq(substream);
+	if (snd_pcm_running(substream))
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+	snd_pcm_stream_unlock_irq(substream);
+
+	if (substream->ops->hw_free != NULL)
+		substream->ops->hw_free(substream);
+
+	substream->ops->close(substream);
+#endif
+	//printk(KERN_DEBUG"%s: substream=%p refcount=%d\n", __FUNCTION__, substream, substream->ref_count);
+	snd_pcm_release_substream(substream);
+}
+
+static __shimcall__
+void conexant_hsfmodem_OsHdaCodecCloseDMA(PHDAOSHAL pHdaOsHal, void *pPlaybackStream, void *pCaptureStream)
+{
+	//printk(KERN_DEBUG"%s: pHdaOsHal=%p pPlaybackStream=%p pCaptureStream=%p\n", __FUNCTION__, pHdaOsHal, pPlaybackStream, pCaptureStream);
+	if(pHdaOsHal) {
+		if(pPlaybackStream)
+			conexant_modem_snd_pcm_close_stream(pPlaybackStream);
+		if(pCaptureStream)
+			conexant_modem_snd_pcm_close_stream(pCaptureStream);
+	}
+}
+
+static __shimcall__
+void conexant_hsfmodem_OsHdaCodecDMAInfo(PHDAOSHAL pHdaOsHal, void *Stream, unsigned char *StreamID, unsigned long *FifoSize, short unsigned int **ppBufAddr)
+{
+	struct conexant_spec *spec = ((struct hda_codec *)pHdaOsHal->hda_codec)->spec;
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)Stream;
+
+#if 0
+	printk(KERN_DEBUG"%s: substream=%p stream=%u id/tag=%u fifo_size=%u bufAddr=%p\n", __FUNCTION__,
+			substream,
+			substream->stream,
+			spec->modem_stream_tags[substream->stream],
+			substream->runtime->hw.fifo_size,
+			substream->runtime->dma_area);
+#endif
+
+	*StreamID = spec->modem_stream_tags[substream->stream];
+	*FifoSize = substream->runtime->hw.fifo_size; // XXX
+	*ppBufAddr = (short unsigned int *)substream->runtime->dma_area;
+}
+
+static __shimcall__
+int conexant_hsfmodem_OsHdaCodecSetDMAState(PHDAOSHAL pHdaOsHal, OSHDA_STREAM_STATE streamState, void *pPlaybackStream, void *pCaptureStream)
+{
+	struct conexant_spec *spec = ((struct hda_codec *)pHdaOsHal->hda_codec)->spec;
+        struct snd_pcm_substream *psubstream = (struct snd_pcm_substream *)pPlaybackStream;
+        struct snd_pcm_substream *csubstream = (struct snd_pcm_substream *)pCaptureStream;
+	int err = 0, cmd;
+	unsigned long flags, flags2;
+
+	switch(streamState) {
+		case OsHdaStreamStateRun:
+//			printk(KERN_DEBUG"%s: Run\n", __FUNCTION__);
+			if ((err = conexant_modem_snd_pcm_prepare_substream(pHdaOsHal, psubstream)) < 0)
+				return err;
+			if ((err = conexant_modem_snd_pcm_prepare_substream(pHdaOsHal, csubstream)) < 0)
+				return err;
+
+			cmd = SNDRV_PCM_IOCTL_START;
+			psubstream->runtime->start_threshold = 1;
+			psubstream->runtime->stop_threshold = psubstream->runtime->boundary;
+			csubstream->runtime->start_threshold = 1;
+			csubstream->runtime->stop_threshold = csubstream->runtime->boundary;
+			break;
+		case OsHdaStreamStateStop:
+//			printk(KERN_DEBUG"%s: Stop\n", __FUNCTION__);
+			cmd = SNDRV_PCM_IOCTL_DROP;
+			break;
+		case OsHdaStreamStateReset:
+//			printk(KERN_DEBUG"%s: Reset\n", __FUNCTION__);
+			cmd = SNDRV_PCM_IOCTL_RESET;
+			psubstream->runtime->start_threshold = psubstream->runtime->boundary;
+			csubstream->runtime->start_threshold = csubstream->runtime->boundary;
+			break;
+		default:
+			printk(KERN_ERR"%s: unknown state %d\n", __FUNCTION__, streamState);
+			return -ENOSYS;
+	}
+
+	switch(cmd) {
+		case SNDRV_PCM_IOCTL_START:
+			snd_pcm_stream_lock_irqsave(psubstream, flags);
+			snd_pcm_stream_lock_irqsave(csubstream, flags2);
+			psubstream->ops->trigger(psubstream, SNDRV_PCM_TRIGGER_START);
+			csubstream->ops->trigger(csubstream, SNDRV_PCM_TRIGGER_START);
+			snd_pcm_stream_unlock_irqrestore(csubstream, flags2);
+			snd_pcm_stream_unlock_irqrestore(psubstream, flags);
+			break;
+		case SNDRV_PCM_IOCTL_DROP:
+			snd_pcm_stream_lock_irqsave(psubstream, flags);
+			snd_pcm_stream_lock_irqsave(csubstream, flags2);
+			psubstream->runtime->start_threshold = psubstream->runtime->boundary;
+			csubstream->runtime->start_threshold = csubstream->runtime->boundary;
+			psubstream->ops->trigger(psubstream, SNDRV_PCM_TRIGGER_STOP);
+			csubstream->ops->trigger(csubstream, SNDRV_PCM_TRIGGER_STOP);
+			snd_pcm_stream_unlock_irqrestore(csubstream, flags2);
+			snd_pcm_stream_unlock_irqrestore(psubstream, flags);
+			break;
+		case SNDRV_PCM_IOCTL_RESET:
+			//psubstream->ops->trigger(psubstream, SNDRV_PCM_TRIGGER_STOP);
+			//csubstream->ops->trigger(csubstream, SNDRV_PCM_TRIGGER_STOP);
+			/*FALLTHROUGH*/
+		default:
+			err = snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
+			if (err < 0) {
+				printk(KERN_ERR"%s: snd_pcm_kernel_ioctl (playback) failed (%d)\n", __FUNCTION__, err);
+			}
+
+			err = snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
+			if (err < 0) {
+				printk(KERN_ERR"%s: snd_pcm_kernel_ioctl (capture) failed (%d)\n", __FUNCTION__, err);
+			}
+			break;
+	}
+
+	if(cmd != SNDRV_PCM_IOCTL_START) {
+		spec->modem_do_prepare[psubstream->stream] = 1;
+		spec->modem_do_prepare[csubstream->stream] = 1;
+	}
+
+	return err;
+}
+
+static __shimcall__
+unsigned long conexant_hsfmodem_OsHdaCodecGetDMAPos(PHDAOSHAL pHdaOsHal, void *Stream)
+{
+	struct hda_codec *codec = (struct hda_codec *)pHdaOsHal->hda_codec;
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)Stream;
+	int ret;
+
+	if(codec->bus->ops.get_linkpos)
+		ret = codec->bus->ops.get_linkpos(substream);
+	else
+		ret = frames_to_bytes(substream->runtime, substream->ops->pointer(substream));
+
+	//printk(KERN_DEBUG"%s: substream=%p pos=%ld, ret=%d\n", __FUNCTION__, substream, pos, ret);
+
+	return ret;
+}
+
+
+static void *conexant_hsfmodem_interface_funcs[] = {
+	conexant_hsfmodem_OsHdaCodecGetAddr,
+	conexant_hsfmodem_OsHdaCodecGetVendorId,
+	conexant_hsfmodem_OsHdaCodecGetSubsystemId,
+	conexant_hsfmodem_OsHdaCodecGetRevisionId,
+	conexant_hsfmodem_OsHdaCodecRead,
+	conexant_hsfmodem_OsHdaCodecWallclock,
+	conexant_hsfmodem_OsHdaCodecSetEventCallback,
+	conexant_hsfmodem_OsHdaCodecClearEventCallback,
+	conexant_hsfmodem_OsHdaCodecOpenDMA,
+	conexant_hsfmodem_OsHdaCodecCloseDMA,
+	conexant_hsfmodem_OsHdaCodecDMAInfo,
+	conexant_hsfmodem_OsHdaCodecSetDMAState,
+	conexant_hsfmodem_OsHdaCodecGetDMAPos,
+	NULL
+};
+
diff -ur hda/hda_codec.c hda-new/hda_codec.c
--- hda/hda_codec.c	2008-01-20 12:37:59.000000000 -0500
+++ hda-new/hda_codec.c	2008-01-20 13:31:21.000000000 -0500
@@ -75,6 +75,24 @@
 #endif
 
 /**
+ * snd_hda_codec_wallclock - get the wallclock counter
+ * @codec: the HDA codec
+ *
+ * Get the wallclock counter
+ *
+ * Returns the obtained value, or -1 for an error.
+ */
+unsigned int snd_hda_codec_wallclock(struct hda_codec *codec)
+{
+	u32 res;
+	if(codec->bus->ops.get_wallclock)
+		res = codec->bus->ops.get_wallclock(codec);
+	else
+		res = (u32)-1;
+	return res;
+}
+
+/**
  * snd_hda_codec_read - send a command and get the response
  * @codec: the HDA codec
  * @nid: NID to send the command
@@ -283,7 +301,7 @@
 }
 
 /*
- * process queueud unsolicited events
+ * process queued unsolicited events
  */
 static void process_unsol_events(struct work_struct *work)
 {
@@ -329,6 +347,21 @@
 	return 0;
 }
 
+void snd_hda_codec_remove_notify_all(struct hda_bus *bus)
+{
+	struct list_head *p, *n;
+
+	if (! bus)
+		return;
+	list_for_each_safe(p, n, &bus->codec_list) {
+		struct hda_codec *codec = list_entry(p, struct hda_codec, list);
+
+		if (codec && codec->patch_ops.exit) {
+			codec->patch_ops.exit(codec);
+		}
+	}
+}
+
 /*
  * destructor
  */
@@ -429,6 +462,10 @@
 	for (tbl = hda_preset_tables; *tbl; tbl++) {
 		for (preset = *tbl; preset->id; preset++) {
 			u32 mask = preset->mask;
+			if (preset->afg && (preset->afg != codec->afg))
+				continue;
+			if (preset->mfg && (preset->mfg != codec->mfg))
+				continue;
 			if (!mask)
 				mask = ~0;
 			if (preset->id == (codec->vendor_id & mask) &&
@@ -1685,6 +1722,7 @@
 
 	snd_hda_codec_write(codec, fg, 0, AC_VERB_SET_POWER_STATE,
 			    power_state);
+	msleep(10); // partial workaround for "hda_intel: azx_get_response timeout, switching to polling mode..." issue
 
 	nid = codec->start_nid;
 	for (i = 0; i < codec->num_nodes; i++, nid++) {
diff -ur hda/hda_codec.h hda-new/hda_codec.h
--- hda/hda_codec.h	2008-01-20 12:37:59.000000000 -0500
+++ hda-new/hda_codec.h	2008-01-20 13:31:21.000000000 -0500
@@ -464,6 +464,10 @@
 		       unsigned int verb, unsigned int parm);
 	/* get a response from the last command */
 	unsigned int (*get_response)(struct hda_codec *codec);
+	/* get the wall clock counter */
+	u32 (*get_wallclock)(struct hda_codec *codec);
+	/* get the link position counter */
+	u32 (*get_linkpos)(struct snd_pcm_substream *substream);
 	/* free the private data */
 	void (*private_free)(struct hda_bus *);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -522,6 +526,7 @@
 	unsigned int mask;
 	unsigned int subs;
 	unsigned int subs_mask;
+	hda_nid_t afg, mfg;
 	unsigned int rev;
 	const char *name;
 	int (*patch)(struct hda_codec *codec);
@@ -532,6 +537,7 @@
 	int (*build_controls)(struct hda_codec *codec);
 	int (*build_pcms)(struct hda_codec *codec);
 	int (*init)(struct hda_codec *codec);
+	int (*exit)(struct hda_codec *codec);
 	void (*free)(struct hda_codec *codec);
 	void (*unsol_event)(struct hda_codec *codec, unsigned int res);
 #ifdef SND_HDA_NEEDS_RESUME
@@ -594,6 +600,7 @@
 	char *name;
 	struct hda_pcm_stream stream[2];
 	unsigned int is_modem;	/* modem codec? */
+	struct snd_pcm *pcm;
 };
 
 /* codec information */
@@ -659,10 +666,12 @@
 		    struct hda_bus **busp);
 int snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
 		      struct hda_codec **codecp);
+void snd_hda_codec_remove_notify_all(struct hda_bus *bus);
 
 /*
  * low level functions
  */
+unsigned int snd_hda_codec_wallclock(struct hda_codec *codec);
 unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 				int direct,
 				unsigned int verb, unsigned int parm);
diff -ur hda/hda_intel.c hda-new/hda_intel.c
--- hda/hda_intel.c	2008-01-20 12:37:59.000000000 -0500
+++ hda-new/hda_intel.c	2008-01-20 13:31:21.000000000 -0500
@@ -47,6 +47,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include "hda_codec.h"
+#include "hda_local.h"
 
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
@@ -435,6 +436,20 @@
  * Interface for HD codec
  */
 
+static u32 azx_get_wallclock(struct hda_codec *codec)
+{
+	struct azx *chip = codec->bus->private_data;
+
+	return azx_readl(chip, WALCLK);
+}
+
+static u32 azx_get_linkpos(struct snd_pcm_substream *substream)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+
+	return azx_sd_readl(azx_dev, SD_LPIB);
+}
+
 /*
  * CORB / RIRB interface
  */
@@ -629,7 +644,8 @@
 		}
 		udelay(1);
 	}
-	snd_printd(SFX "send_cmd timeout: IRS=0x%x, val=0x%x\n",
+	if(printk_ratelimit())
+		snd_printd(SFX "send_cmd timeout: IRS=0x%x, val=0x%x\n",
 		   azx_readw(chip, IRS), val);
 	return -EIO;
 }
@@ -646,7 +662,8 @@
 			return azx_readl(chip, IR);
 		udelay(1);
 	}
-	snd_printd(SFX "get_response timeout: IRS=0x%x\n",
+	if(printk_ratelimit())
+		snd_printd(SFX "get_response timeout: IRS=0x%x\n",
 		   azx_readw(chip, IRS));
 	return (unsigned int)-1;
 }
@@ -1054,6 +1071,8 @@
 	bus_temp.pci = chip->pci;
 	bus_temp.ops.command = azx_send_cmd;
 	bus_temp.ops.get_response = azx_get_response;
+	bus_temp.ops.get_wallclock = azx_get_wallclock;
+	bus_temp.ops.get_linkpos = azx_get_linkpos;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	bus_temp.ops.pm_notify = azx_power_notify;
 #endif
@@ -1396,6 +1415,7 @@
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci),
 					      1024 * 64, 1024 * 1024);
+	cpcm->pcm = pcm;
 	chip->pcm[pcm_dev] = pcm;
 	if (chip->pcm_devs < pcm_dev + 1)
 		chip->pcm_devs = pcm_dev + 1;
@@ -1961,6 +1981,10 @@
 
 static void __devexit azx_remove(struct pci_dev *pci)
 {
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct azx *chip = card->private_data;
+
+	snd_hda_codec_remove_notify_all(chip->bus);
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
 }

--=-9mXNC8frVAehKHsDOjZa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-9mXNC8frVAehKHsDOjZa--
