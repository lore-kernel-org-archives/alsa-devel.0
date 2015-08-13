From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoc: Handle multiple codecs with split
	playback / capture
Date: Thu, 13 Aug 2015 16:12:56 +0200
Message-ID: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A022261A5A
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 16:13:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


(Referring to this thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093214.html)

This patch adds the capability to use multiple codecs on the same DAI =

link where one codec is used for playback and another one is used for =

capture.

As noted in the thread, there might be more places where the new =

snd_soc_dai_stream_valid() function is needed, however, these two were =

sufficient for our use case (SSM2518 playback and ICS-43432 capture).

Signed-off-by: Ricard Wanderlof <ricardw@xis.com>
---
 sound/soc/soc-pcm.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 6b0136e..df1f261 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -35,6 +35,32 @@
 #define DPCM_MAX_BE_USERS	8
 =

 /**
+ * snd_soc_dai_stream_valid() - check if a DAI supports the given stream
+ *
+ * @dai: The DAI to check for stream support
+ * @stream: The stream type (playback / capture) to check for
+ *
+ * Checks if the DAI in question supports the indicated stream type.
+ * Needed to skip over codecs when iterating over
+ * snd_soc_pcm_runtime->codec_dais in order to skip codecs that are playba=
ck-
+ * or capture-only, which would otherwise inhibit capture or playback,
+ * respectively, to the other codec in a multiple codec / common I2S bus
+ * environment.
+ */
+static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
+{
+	struct snd_soc_pcm_stream *codec_stream;
+
+	if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		codec_stream =3D &dai->driver->playback;
+	else
+		codec_stream =3D &dai->driver->capture;
+
+	/* If the codec specifies any rate at all, it supports the stream. */
+	return !!codec_stream->rates;
+}
+
+/**
  * snd_soc_runtime_activate() - Increment active count for PCM runtime com=
ponents
  * @rtd: ASoC PCM runtime that is activated
  * @stream: Direction of the PCM stream
@@ -371,6 +397,12 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_sub=
stream *substream)
 =

 	/* first calculate min/max only for CODECs in the DAI link */
 	for (i =3D 0; i < rtd->num_codecs; i++) {
+
+		/* Skip codecs which don't support the current stream type. */
+		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
+					      substream->stream))
+			continue;
+
 		codec_dai_drv =3D rtd->codec_dais[i]->driver;
 		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
 			codec_stream =3D &codec_dai_drv->playback;
@@ -827,6 +859,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substream =
*substream,
 		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
 		struct snd_pcm_hw_params codec_params;
 =

+		/* Skip codecs which don't support the current stream type. */
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		/* copy params for each codec */
 		codec_params =3D *params;
 =

-- =

1.7.10.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
