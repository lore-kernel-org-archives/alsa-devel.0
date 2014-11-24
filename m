From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Mon, 24 Nov 2014 10:03:05 +0900
Message-ID: <547283C9.8040206@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>
 <54691544.2020501@ladisch.de> <546DC356.8010207@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030306080200070005060105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B6845261A5E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 02:03:13 +0100 (CET)
In-Reply-To: <546DC356.8010207@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030306080200070005060105
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Clemens,

On Nov 20 2014 19:32, Takashi Sakamoto wrote:
>> And why are the substreams counters atomic?
>> Can't they just be normal variables accessed from inside the mutex?
>=20
> Just for my convinience. I didn't want to write many
> mutex_lock()/mutex_unlock() because wrong coding of them causes-dead
> lock, then push them inner stream.c. This idea is good except for
> reference couters, so I added atomic_t.
>=20
> An attached patch achieves your idea over my patchset. Handling
> reference counter is easy to understand (because it's arithmetric
> operation) but I don't like much mutex_lock()/mutex_unlock().
>=20
> Can I request you to explain about the advantages of your idea?

Oops. I attached a patch for Dice driver...

But my strategy for programming is nearly the same. Would you please
give me some comments so as I can post new patchsets in this week?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp


--------------030306080200070005060105
Content-Type: text/x-diff;
 name="0001-oxfw-use-mutex-only-instead-of-atomic_t-to-handle-cr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-oxfw-use-mutex-only-instead-of-atomic_t-to-handle-cr.pa";
 filename*1="tch"

=46rom cecd70d492e343e802f71e9cca94b94fb46efa93 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 20 Nov 2014 09:57:09 +0900
Subject: [PATCH] oxfw: use mutex only instead of atomic_t to handle criti=
cal
 section easily

OXFW driver has some critical sections. Some of them are protected by ato=
mic_t
and the others are protected by mutex. But they can be merged.

Originally, I added atomic_t for a reference counter to enclose
mutex_lock()/mutex_unlock() inner -stream.c. But it's cumbersome that thi=
s
driver has some mutual primitives for stream handling.

This commit obsoletes atomic_t and use mutex only.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-midi.c   | 16 ++++++++++++----
 sound/firewire/oxfw/oxfw-pcm.c    | 34 ++++++++++++++++++++++++++-------=
-
 sound/firewire/oxfw/oxfw-stream.c | 39 +++++++++++----------------------=
------
 sound/firewire/oxfw/oxfw.c        |  4 ++++
 sound/firewire/oxfw/oxfw.h        |  4 ++--
 5 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-m=
idi.c
index 94bc8d0..331838e 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -17,8 +17,10 @@ static int midi_capture_open(struct snd_rawmidi_substr=
eam *substream)
 	if (err < 0)
 		goto end;
=20
-	atomic_inc(&oxfw->capture_substreams);
+	mutex_lock(&oxfw->mutex);
+	oxfw->capture_substreams++;
 	err =3D snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream, 0, 0);
+	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		snd_oxfw_stream_lock_release(oxfw);
 end:
@@ -34,8 +36,10 @@ static int midi_playback_open(struct snd_rawmidi_subst=
ream *substream)
 	if (err < 0)
 		goto end;
=20
-	atomic_inc(&oxfw->playback_substreams);
+	mutex_lock(&oxfw->mutex);
+	oxfw->playback_substreams++;
 	err =3D snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream, 0, 0);
+	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		snd_oxfw_stream_lock_release(oxfw);
 end:
@@ -46,8 +50,10 @@ static int midi_capture_close(struct snd_rawmidi_subst=
ream *substream)
 {
 	struct snd_oxfw *oxfw =3D substream->rmidi->private_data;
=20
-	atomic_dec(&oxfw->capture_substreams);
+	mutex_lock(&oxfw->mutex);
+	oxfw->capture_substreams--;
 	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+	mutex_unlock(&oxfw->mutex);
=20
 	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
@@ -57,8 +63,10 @@ static int midi_playback_close(struct snd_rawmidi_subs=
tream *substream)
 {
 	struct snd_oxfw *oxfw =3D substream->rmidi->private_data;
=20
-	atomic_dec(&oxfw->playback_substreams);
+	mutex_lock(&oxfw->mutex);
+	oxfw->playback_substreams--;
 	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+	mutex_unlock(&oxfw->mutex);
=20
 	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pc=
m.c
index c508a1f..475d1aa 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -232,8 +232,12 @@ static int pcm_capture_hw_params(struct snd_pcm_subs=
tream *substream,
 {
 	struct snd_oxfw *oxfw =3D substream->private_data;
=20
-	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&oxfw->capture_substreams);
+	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->capture_substreams++;
+		mutex_unlock(&oxfw->mutex);
+	}
+
 	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params))=
;
=20
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -244,8 +248,12 @@ static int pcm_playback_hw_params(struct snd_pcm_sub=
stream *substream,
 {
 	struct snd_oxfw *oxfw =3D substream->private_data;
=20
-	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&oxfw->playback_substreams);
+	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->playback_substreams++;
+		mutex_unlock(&oxfw->mutex);
+	}
+
 	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params))=
;
=20
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -256,8 +264,11 @@ static int pcm_capture_hw_free(struct snd_pcm_substr=
eam *substream)
 {
 	struct snd_oxfw *oxfw =3D substream->private_data;
=20
-	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&oxfw->capture_substreams);
+	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->capture_substreams--;
+		mutex_unlock(&oxfw->mutex);
+	}
=20
 	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
=20
@@ -267,8 +278,11 @@ static int pcm_playback_hw_free(struct snd_pcm_subst=
ream *substream)
 {
 	struct snd_oxfw *oxfw =3D substream->private_data;
=20
-	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&oxfw->playback_substreams);
+	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&oxfw->mutex);
+		oxfw->playback_substreams--;
+		mutex_unlock(&oxfw->mutex);
+	}
=20
 	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
=20
@@ -281,8 +295,10 @@ static int pcm_capture_prepare(struct snd_pcm_substr=
eam *substream)
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	int err;
=20
+	mutex_lock(&oxfw->mutex);
 	err =3D snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream,
 					    runtime->rate, runtime->channels);
+	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
=20
@@ -296,8 +312,10 @@ static int pcm_playback_prepare(struct snd_pcm_subst=
ream *substream)
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	int err;
=20
+	mutex_lock(&oxfw->mutex);
 	err =3D snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream,
 					    runtime->rate, runtime->channels);
+	mutex_unlock(&oxfw->mutex);
 	if (err < 0)
 		goto end;
=20
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw=
-stream.c
index b1dcc68..00870df 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -219,8 +219,6 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxf=
w,
 		s_dir =3D AMDTP_OUT_STREAM;
 	}
=20
-	mutex_lock(&oxfw->mutex);
-
 	err =3D cmp_connection_init(conn, oxfw->unit, c_dir, 0);
 	if (err < 0)
 		goto end;
@@ -236,7 +234,6 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxf=
w,
 	if (stream =3D=3D &oxfw->tx_stream)
 		oxfw->tx_stream.flags |=3D CIP_SKIP_INIT_DBC_CHECK;
 end:
-	mutex_unlock(&oxfw->mutex);
 	return err;
 }
=20
@@ -247,17 +244,17 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *=
oxfw,
 	struct amdtp_stream *opposite;
 	struct snd_oxfw_stream_formation formation;
 	enum avc_general_plug_dir dir;
-	atomic_t *substreams, *opposite_substreams;
+	unsigned int substreams, opposite_substreams;
 	int err =3D 0;
=20
 	if (stream =3D=3D &oxfw->tx_stream) {
-		substreams =3D &oxfw->capture_substreams;
+		substreams =3D oxfw->capture_substreams;
 		opposite =3D &oxfw->rx_stream;
-		opposite_substreams =3D &oxfw->playback_substreams;
+		opposite_substreams =3D oxfw->playback_substreams;
 		dir =3D AVC_GENERAL_PLUG_DIR_OUT;
 	} else {
-		substreams =3D &oxfw->playback_substreams;
-		opposite_substreams =3D &oxfw->capture_substreams;
+		substreams =3D oxfw->playback_substreams;
+		opposite_substreams =3D oxfw->capture_substreams;
=20
 		if (oxfw->has_output)
 			opposite =3D &oxfw->rx_stream;
@@ -267,11 +264,9 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *o=
xfw,
 		dir =3D AVC_GENERAL_PLUG_DIR_IN;
 	}
=20
-	if (atomic_read(substreams) =3D=3D 0)
+	if (substreams =3D=3D 0)
 		goto end;
=20
-	mutex_lock(&oxfw->mutex);
-
 	/*
 	 * Considering JACK/FFADO streaming:
 	 * TODO: This can be removed hwdep functionality becomes popular.
@@ -310,7 +305,7 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *ox=
fw,
=20
 		/* Start opposite stream if needed. */
 		if (opposite && !amdtp_stream_running(opposite) &&
-		    (atomic_read(opposite_substreams) > 0)) {
+		    (opposite_substreams > 0)) {
 			err =3D start_stream(oxfw, opposite, rate, 0);
 			if (err < 0) {
 				dev_err(&oxfw->unit->device,
@@ -328,22 +323,17 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *=
oxfw,
 				"fail to start stream: %d\n", err);
 	}
 end:
-	mutex_unlock(&oxfw->mutex);
 	return err;
 }
=20
 void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
 				  struct amdtp_stream *stream)
 {
-	if (((stream =3D=3D &oxfw->tx_stream) &&
-	     (atomic_read(&oxfw->capture_substreams) > 0)) ||
-	    ((stream =3D=3D &oxfw->rx_stream) &&
-	     (atomic_read(&oxfw->playback_substreams) > 0)))
+	if (((stream =3D=3D &oxfw->tx_stream) && (oxfw->capture_substreams > 0)=
) ||
+	    ((stream =3D=3D &oxfw->rx_stream) && (oxfw->playback_substreams > 0=
)))
 		return;
=20
-	mutex_lock(&oxfw->mutex);
 	stop_stream(oxfw, stream);
-	mutex_unlock(&oxfw->mutex);
 }
=20
 void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
@@ -356,14 +346,10 @@ void snd_oxfw_stream_destroy_simplex(struct snd_oxf=
w *oxfw,
 	else
 		conn =3D &oxfw->in_conn;
=20
-	mutex_lock(&oxfw->mutex);
-
 	stop_stream(oxfw, stream);
=20
 	amdtp_stream_destroy(stream);
 	cmp_connection_destroy(conn);
-
-	mutex_unlock(&oxfw->mutex);
 }
=20
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
@@ -376,13 +362,10 @@ void snd_oxfw_stream_update_simplex(struct snd_oxfw=
 *oxfw,
 	else
 		conn =3D &oxfw->in_conn;
=20
-	if (cmp_connection_update(conn) < 0) {
-		mutex_lock(&oxfw->mutex);
+	if (cmp_connection_update(conn) < 0)
 		stop_stream(oxfw, stream);
-		mutex_unlock(&oxfw->mutex);
-	} else {
+	else
 		amdtp_stream_update(stream);
-	}
 }
=20
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 40cd2c0..60c68ce 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -214,10 +214,14 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw =3D dev_get_drvdata(&unit->device);
=20
+	mutex_lock(&oxfw->mutex);
+
 	fcp_bus_reset(oxfw->unit);
 	snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
+
+	mutex_unlock(&oxfw->mutex);
 }
=20
 static void oxfw_remove(struct fw_unit *unit)
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index d2f8ee5..65b95f2 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -56,8 +56,8 @@ struct snd_oxfw {
 	struct cmp_connection in_conn;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
-	atomic_t capture_substreams;
-	atomic_t playback_substreams;
+	unsigned int capture_substreams;
+	unsigned int playback_substreams;
=20
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
--=20
2.1.0


--------------030306080200070005060105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030306080200070005060105--
