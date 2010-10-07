From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Thu, 07 Oct 2010 10:05:17 +0200
Message-ID: <4CAD7F3D.3090205@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>
	<i8ce5u$fj3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C306A243E3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 10:03:48 +0200 (CEST)
In-Reply-To: <i8ce5u$fj3$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please try this patch.

--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -606,6 +606,24 @@ static hda_nid_t stac9205_pin_nids[12] = {
 	0x21, 0x22,
 };
 
+static int stac92xx_minmute_volume_tlv(struct snd_kcontrol *control,
+				       int op_flag, unsigned int size,
+				       unsigned int __user *_tlv)
+{
+	int ret;
+	unsigned int val;
+
+	ret = snd_hda_mixer_amp_tlv(control, op_flag, size, _tlv);
+	if (ret >= 0) {
+		if (get_user(val, _tlv + 3))
+			return -EFAULT;
+		val |= 0x10000; /* min is mute */
+		if (put_user(val, _tlv + 3))
+			return -EFAULT;
+	}
+	return ret;
+}
+
 static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -959,6 +977,21 @@ static struct hda_verb stac9205_core_init[] = {
 	{}
 };
 
+#define STAC_MINMUTE_VOLUME(xname, xnid) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.subdevice = HDA_SUBDEV_AMP_FLAG, \
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			  SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+		.info = snd_hda_mixer_amp_volume_info, \
+		.get = snd_hda_mixer_amp_volume_get, \
+		.put = snd_hda_mixer_amp_volume_put, \
+		.tlv = { .c = stac92xx_minmute_volume_tlv }, \
+		.private_value = HDA_COMPOSE_AMP_VAL(xnid, 3, 0, HDA_OUTPUT), \
+	}
+
 #define STAC_MONO_MUX \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -992,7 +1025,7 @@ static struct hda_verb stac9205_core_init[] = {
 	}
 
 static struct snd_kcontrol_new stac9200_mixer[] = {
-	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
+	STAC_MINMUTE_VOLUME("Master Playback Volume", 0xb),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
