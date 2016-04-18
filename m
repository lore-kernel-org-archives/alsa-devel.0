From: "Tan, Seng Kai" <seng.kai.tan@intel.com>
Subject: Question about Conversion to S24_LE from S24_3LE
Date: Mon, 18 Apr 2016 09:24:52 +0000
Message-ID: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F2F265019
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 11:24:56 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

I am facing similar problem like this issue, hope to get your advice.
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054241.html

I try to turn on S24_LE support for HDMI Audio using below patch. When I ap=
lay S24_LE file it works fine.
The problem happen when I aplay S24_3LE file, I get and extremely low volum=
e.

When I aplay S24_LE file, I get an left justified value in I2S, this is an =
expected result:
Front end S24_LE=A0 :=A0 0x12345600(in 4bytes, LSB 0 padding)
Back end=A0 S24_3LE :=A0 0x12345600(in 4bytes, LSB 0 padding)

When I aplay S24_3LE file, I get an extremely low output volume. =

Front end S24_3LE=A0 :=A0 0x123456(in 3bytes, No padding)
Back end=A0 S24_LE :=A0 0x00123456(in 4bytes, MSB 0 padding)

Can you advice how to tell the alsa plugin to pad in LSB instead of MSB?

Below are the patch I used to turn on S24_LE for HDA .

Regards,
Seng Kai




>From 33f182fe1f6d1e49d0618559d1212b619ec902ce Mon Sep 17 00:00:00 2001
From: "SengKai,Tan" <seng.kai.tan@intel.com>
Date: Fri, 8 Apr 2016 17:34:51 +0800
Subject: [PATCH] ALSA: hda: S24_LE format support for HDA Audio

This patch is to add S24_LE support for  HDMI audio
and HDA codec.

Before this patch, HDMI and HDA codec audio only
supported S16_LE and S32_LE. Let's say if user would
like to play S24_LE file, it has to use plugin to
convert to either S16_LE or S32_LE which will
increase in processing and less efficient in utilize
the resources.

On the other side, let's say connected HDMI monitor
support S16_LE and S24_LE. Before this patch is applied
audio has to be converted to S16_LE. That will reduce
the audio quality.

Signed-off-by: Tan, Seng Kai <seng.kai.tan@intel.com>
---
 sound/pci/hda/hda_codec.c  | 6 ++++--
 sound/pci/hda/hda_eld.c    | 6 ++++--
 sound/pci/hda/patch_hdmi.c | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 57197be..9e737bb 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3501,14 +3501,16 @@ int snd_hda_query_supported_pcm(struct hda_codec *c=
odec, hda_nid_t nid,
 				if (val & AC_SUPPCM_BITS_32)
 					formats |=3D SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE;
 				if (val & (AC_SUPPCM_BITS_20|AC_SUPPCM_BITS_24))
-					formats |=3D SNDRV_PCM_FMTBIT_S32_LE;
+					formats |=3D SNDRV_PCM_FMTBIT_S24_LE |
+						SNDRV_PCM_FMTBIT_S32_LE;
 				if (val & AC_SUPPCM_BITS_24)
 					bps =3D 24;
 				else if (val & AC_SUPPCM_BITS_20)
 					bps =3D 20;
 			} else if (val & (AC_SUPPCM_BITS_20|AC_SUPPCM_BITS_24|
 					  AC_SUPPCM_BITS_32)) {
-				formats |=3D SNDRV_PCM_FMTBIT_S32_LE;
+				formats |=3D SNDRV_PCM_FMTBIT_S24_LE |
+					SNDRV_PCM_FMTBIT_S32_LE;
 				if (val & AC_SUPPCM_BITS_32)
 					bps =3D 32;
 				else if (val & AC_SUPPCM_BITS_24)
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 0e6d753..65bfe10 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -613,12 +613,14 @@ void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_=
eld *e,
 			channels_max =3D a->channels;
 		if (a->format =3D=3D AUDIO_CODING_TYPE_LPCM) {
 			if (a->sample_bits & AC_SUPPCM_BITS_20) {
-				formats |=3D SNDRV_PCM_FMTBIT_S32_LE;
+				formats |=3D SNDRV_PCM_FMTBIT_S24_LE |
+					SNDRV_PCM_FMTBIT_S32_LE;
 				if (maxbps < 20)
 					maxbps =3D 20;
 			}
 			if (a->sample_bits & AC_SUPPCM_BITS_24) {
-				formats |=3D SNDRV_PCM_FMTBIT_S32_LE;
+				formats |=3D SNDRV_PCM_FMTBIT_S24_LE |
+					SNDRV_PCM_FMTBIT_S32_LE;
 				if (maxbps < 24)
 					maxbps =3D 24;
 			}
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d02eccd..8cbde13 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2489,7 +2489,8 @@ static const struct hda_verb nvhdmi_basic_init_7x_8ch=
[] =3D {
 	 SNDRV_PCM_RATE_192000)
 #define SUPPORTED_MAXBPS	24
 #define SUPPORTED_FORMATS \
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE)
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |\
+	SNDRV_PCM_FMTBIT_S32_LE)
 #endif
 =

 static int nvhdmi_7x_init_2ch(struct hda_codec *codec)
-- =

1.9.1
