From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2] ASoC: Handle multiple codecs with split
 playback / capture
Date: Wed, 19 Aug 2015 17:32:03 +0200
Message-ID: <alpine.DEB.2.02.1508191717300.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B39265054
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 17:32:05 +0200 (CEST)
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


Add the capability to use multiple codecs on the same DAI linke where
one codec is used for playback and another one is used for capture.

Tested on a setup using an SSM2518 for playback and an ICS43432 I2S MEMS
microphone for capture.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---

The patch was created after a discussion on the alsa-devel mailing list
as to how best to implement this functionality.
(http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093214.html=
).

V2: Minor code change, otherwise the differences compared to V1 are solely
related to comments, in particular considerations given to the =

potential consequences of the patch. After consideration, it seems to me =

that the patch as it stands augments the current framework with the =

functionality indicated in the commit message above, without restricting =

other current uses. Further functionality could be added, but IMHO that =

should be done as the need arises, when it can be properly tested in a =

real-world setup.

 sound/soc/soc-pcm.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 35fe58f4..08407ba 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -34,6 +34,24 @@
 =

 #define DPCM_MAX_BE_USERS	8
 =

+/*
+ * snd_soc_dai_stream_valid() - check if a DAI supports the given stream
+ *
+ * Returns true if the DAI supports the indicated stream type.
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
+	return codec_stream->rates;
+}
+
 /**
  * snd_soc_runtime_activate() - Increment active count for PCM runtime com=
ponents
  * @rtd: ASoC PCM runtime that is activated
@@ -371,6 +389,20 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_sub=
stream *substream)
 =

 	/* first calculate min/max only for CODECs in the DAI link */
 	for (i =3D 0; i < rtd->num_codecs; i++) {
+
+		/*
+		 * Skip CODECs which don't support the current stream type.
+		 * Otherwise, since the rate, channel, and format values will
+		 * zero in that case, we would have no usable settings left,
+		 * causing the resulting setup to fail.
+		 * At least one CODEC should match, otherwise we should have
+		 * bailed out on a higher level, since there would be no
+		 * CODEC to support the transfer direction in that case.
+		 */
+		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
+					      substream->stream))
+			continue;
+
 		codec_dai_drv =3D rtd->codec_dais[i]->driver;
 		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
 			codec_stream =3D &codec_dai_drv->playback;
@@ -827,6 +859,23 @@ static int soc_pcm_hw_params(struct snd_pcm_substream =
*substream,
 		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
 		struct snd_pcm_hw_params codec_params;
 =

+		/*
+		 * Skip CODECs which don't support the current stream type,
+		 * the idea being that if a CODEC is not used for the currently
+		 * set up transfer direction, it should not need to be
+		 * configured, especially since the configuration used might
+		 * not even be supported by that CODEC. There may be cases
+		 * however where a CODEC needs to be set up although it is
+		 * actually not being used for the transfer, e.g. if a
+		 * capture-only CODEC is acting as an LRCLK and/or BCLK master
+		 * for the DAI link including a playback-only CODEC.
+		 * If this becomes necessary, we will have to augment the
+		 * machine driver setup with information on how to act, so
+		 * we can do the right thing here.
+		 */
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
