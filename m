From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/2] ALSA: HDA: Sigmatel: work around incorrect
	master muting
Date: Fri, 15 Oct 2010 10:32:50 +0200
Message-ID: <4CB811B2.4050901@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>	<4CAF27B7.9080909@colin.guthr.ie>	<4CAF2DD1.5050306@ladisch.de>	<4CAF37D
 E.8070205@colin.guthr.ie>	<4CAF38D7.6030901@colin.guthr.ie>
	<4CAF3D97.8070209@colin.guthr.ie>
	<4CB4218C.6070501@colin.guthr.ie> <4CB8119D.7090505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6943F103BFB
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 10:31:30 +0200 (CEST)
In-Reply-To: <4CB8119D.7090505@ladisch.de>
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

The HDA specification does not allow for a codec to mute itself just
because the volume is reduced, so _of course_ somebody had to go and do
it.  This wouldn'\''t hurt too much when the volume is adjusted by hand,
but programs like PA that try to set the volume automatically could
inadvertently mute the output.

To work around this, change the TLV dB information for the Master volume
on all Sigmatel HDA codecs to indicate the the minimal volume setting
actually mutes.

Reported-by: Colin Guthrie <gmane@colin.guthr.ie>
Reported-by: "Alexander E. Patrakov" <patrakov@gmail.com>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6/sound/pci/hda/hda_local.h
+++ linux-2.6/sound/pci/hda/hda_local.h
@@ -38,10 +38,11 @@
  */
 #define HDA_COMPOSE_AMP_VAL_OFS(nid,chs,idx,dir,ofs)		\
 	((nid) | ((chs)<<16) | ((dir)<<18) | ((idx)<<19) | ((ofs)<<23))
+#define HDA_AMP_VAL_MIN_MUTE (1<<29)
 #define HDA_COMPOSE_AMP_VAL(nid,chs,idx,dir) \
 	HDA_COMPOSE_AMP_VAL_OFS(nid, chs, idx, dir, 0)
 /* mono volume with index (index=0,1,...) (channel=1,2) */
-#define HDA_CODEC_VOLUME_MONO_IDX(xname, xcidx, nid, channel, xindex, direction) \
+#define HDA_CODEC_VOLUME_MONO_IDX(xname, xcidx, nid, channel, xindex, dir, flags) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xcidx,  \
 	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
 	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
@@ -51,16 +52,20 @@
 	  .get = snd_hda_mixer_amp_volume_get, \
 	  .put = snd_hda_mixer_amp_volume_put, \
 	  .tlv = { .c = snd_hda_mixer_amp_tlv },		\
-	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, xindex, direction) }
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, xindex, dir) | flags }
 /* stereo volume with index */
 #define HDA_CODEC_VOLUME_IDX(xname, xcidx, nid, xindex, direction) \
-	HDA_CODEC_VOLUME_MONO_IDX(xname, xcidx, nid, 3, xindex, direction)
+	HDA_CODEC_VOLUME_MONO_IDX(xname, xcidx, nid, 3, xindex, direction, 0)
 /* mono volume */
 #define HDA_CODEC_VOLUME_MONO(xname, nid, channel, xindex, direction) \
-	HDA_CODEC_VOLUME_MONO_IDX(xname, 0, nid, channel, xindex, direction)
+	HDA_CODEC_VOLUME_MONO_IDX(xname, 0, nid, channel, xindex, direction, 0)
 /* stereo volume */
 #define HDA_CODEC_VOLUME(xname, nid, xindex, direction) \
 	HDA_CODEC_VOLUME_MONO(xname, nid, 3, xindex, direction)
+/* stereo volume with min=mute */
+#define HDA_CODEC_VOLUME_MIN_MUTE(xname, nid, xindex, direction) \
+	HDA_CODEC_VOLUME_MONO_IDX(xname, 0, nid, 3, xindex, direction, \
+				  HDA_AMP_VAL_MIN_MUTE)
 /* mono mute switch with index (index=0,1,...) (channel=1,2) */
 #define HDA_CODEC_MUTE_MONO_IDX(xname, xcidx, nid, channel, xindex, direction) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xcidx, \
@@ -581,6 +586,7 @@ int snd_hda_check_amp_list_power(struct
 #define get_amp_direction(kc)	(((kc)->private_value >> 18) & 0x1)
 #define get_amp_index(kc)	(((kc)->private_value >> 19) & 0xf)
 #define get_amp_offset(kc)	(((kc)->private_value >> 23) & 0x3f)
+#define get_amp_min_mute(kc)	(((kc)->private_value >> 29) & 0x1)
 
 /*
  * CEA Short Audio Descriptor data
--- linux-2.6/sound/pci/hda/hda_codec.c
+++ linux-2.6/sound/pci/hda/hda_codec.c
@@ -1831,6 +1831,7 @@ int snd_hda_mixer_amp_tlv(struct snd_kco
 	hda_nid_t nid = get_amp_nid(kcontrol);
 	int dir = get_amp_direction(kcontrol);
 	unsigned int ofs = get_amp_offset(kcontrol);
+	bool min_mute = get_amp_min_mute(kcontrol);
 	u32 caps, val1, val2;
 
 	if (size < 4 * sizeof(unsigned int))
@@ -1841,6 +1842,8 @@ int snd_hda_mixer_amp_tlv(struct snd_kco
 	val1 = -((caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT);
 	val1 += ofs;
 	val1 = ((int)val1) * ((int)val2);
+	if (min_mute)
+		val2 |= 0x10000;
 	if (put_user(SNDRV_CTL_TLVT_DB_SCALE, _tlv))
 		return -EFAULT;
 	if (put_user(2 * sizeof(unsigned int), _tlv + 1))
--- linux-2.6/sound/pci/hda/patch_sigmatel.c
+++ linux-2.6/sound/pci/hda/patch_sigmatel.c
@@ -992,7 +992,7 @@ static struct hda_verb stac9205_core_ini
 	}
 
 static struct snd_kcontrol_new stac9200_mixer[] = {
-	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MIN_MUTE("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
@@ -1020,7 +1020,7 @@ static struct snd_kcontrol_new stac92hd7
 };
 
 static struct snd_kcontrol_new stac925x_mixer[] = {
-	HDA_CODEC_VOLUME("Master Playback Volume", 0x0e, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MIN_MUTE("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0x0e, 0, HDA_OUTPUT),
 	{ } /* end */
 };
@@ -1144,6 +1144,8 @@ static int stac92xx_build_controls(struc
 					HDA_OUTPUT, vmaster_tlv);
 		/* correct volume offset */
 		vmaster_tlv[2] += vmaster_tlv[3] * spec->volume_offset;
+		/* minimum value is actually mute */
+		vmaster_tlv[3] |= 0x1000;
 		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
 					  vmaster_tlv, slave_vols);
 		if (err < 0)
