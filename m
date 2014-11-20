From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 26/29] ALSA: oxfw: Add support AMDTP
	in-stream
Date: Thu, 20 Nov 2014 19:32:54 +0900
Message-ID: <546DC356.8010207@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-27-git-send-email-o-takashi@sakamocchi.jp>
 <54691544.2020501@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090007060303010305050700"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 33CF7265715
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 11:33:01 +0100 (CET)
In-Reply-To: <54691544.2020501@ladisch.de>
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
--------------090007060303010305050700
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Clemens,

On Nov 17 2014 06:21, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +++ b/sound/firewire/oxfw/oxfw-stream.c
>> +int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
>> +				  struct amdtp_stream *stream,
>> +				  unsigned int rate, unsigned int pcm_channels)
>> +{
>> ...
>> +	if (atomic_read(substreams) =3D=3D 0)
>> +		goto end;
>> +
>>  	mutex_lock(&oxfw->mutex);
>=20
> What happens if hw_free is called between the calls to atomic_read() an=
d
> mutex_lock()?

In the worst case, the codes after the mutex_lock() manage to start
duplex streams with released resources, then it causes kernel panic.

This is a bug. I should have move atmic_read() to the critical section...

> And why are the substreams counters atomic?
> Can't they just be normal variables accessed from inside the mutex?

Just for my convinience. I didn't want to write many
mutex_lock()/mutex_unlock() because wrong coding of them causes-dead
lock, then push them inner stream.c. This idea is good except for
reference couters, so I added atomic_t.

An attached patch achieves your idea over my patchset. Handling
reference counter is easy to understand (because it's arithmetric
operation) but I don't like much mutex_lock()/mutex_unlock().

Can I request you to explain about the advantages of your idea?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

--------------090007060303010305050700
Content-Type: text/x-diff;
 name="0001-dice-use-mutex-only-instead-of-atomic_t-to-handle-cr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-dice-use-mutex-only-instead-of-atomic_t-to-handle-cr.pa";
 filename*1="tch"

=46rom 3e9968a4063f7b5d2977970821f34d5df3b70c57 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 20 Nov 2014 10:28:08 +0900
Subject: [PATCH] dice: use mutex only instead of atomic_t to handle criti=
cal
 section easily

Dice driver has some critical sections. Some of them are protected by ato=
mic_t
and the others are protected by mutex. But they can be merged.

Originally, I added atomic_t for a reference counter to enclose
mutex_lock()/mutex_unlock() inner -stream.c But it's cumbersome that this=

driver uses some mutual primitives for stream handling.

This commit obsoletes atomic_t and use mutex only.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c   | 16 ++++++++++++----
 sound/firewire/dice/dice-pcm.c    | 30 ++++++++++++++++++++++++------
 sound/firewire/dice/dice-stream.c | 29 +++++++----------------------
 sound/firewire/dice/dice.c        |  4 ++++
 sound/firewire/dice/dice.h        |  2 +-
 5 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-m=
idi.c
index 4f4eae7..74cd3b3 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -16,8 +16,10 @@ static int capture_open(struct snd_rawmidi_substream *=
substream)
 	if (err < 0)
 		goto end;
=20
-	atomic_inc(&dice->substreams_counter);
+	mutex_lock(&dice->mutex);
+	dice->substreams_counter++;
 	err =3D snd_dice_stream_start_duplex(dice, 0);
+	mutex_unlock(&dice->mutex);
 	if (err < 0)
 		snd_dice_stream_lock_release(dice);
 end:
@@ -33,8 +35,10 @@ static int playback_open(struct snd_rawmidi_substream =
*substream)
 	if (err < 0)
 		goto end;
=20
-	atomic_inc(&dice->substreams_counter);
+	mutex_lock(&dice->mutex);
+	dice->substreams_counter++;
 	err =3D snd_dice_stream_start_duplex(dice, 0);
+	mutex_unlock(&dice->mutex);
 	if (err < 0)
 		snd_dice_stream_lock_release(dice);
 end:
@@ -45,8 +49,10 @@ static int capture_close(struct snd_rawmidi_substream =
*substream)
 {
 	struct snd_dice *dice =3D substream->rmidi->private_data;
=20
-	atomic_dec(&dice->substreams_counter);
+	mutex_lock(&dice->mutex);
+	dice->substreams_counter--;
 	snd_dice_stream_stop_duplex(dice);
+	mutex_unlock(&dice->mutex);
=20
 	snd_dice_stream_lock_release(dice);
 	return 0;
@@ -56,8 +62,10 @@ static int playback_close(struct snd_rawmidi_substream=
 *substream)
 {
 	struct snd_dice *dice =3D substream->rmidi->private_data;
=20
-	atomic_dec(&dice->substreams_counter);
+	mutex_lock(&dice->mutex);
+	dice->substreams_counter--;
 	snd_dice_stream_stop_duplex(dice);
+	mutex_unlock(&dice->mutex);
=20
 	snd_dice_stream_lock_release(dice);
 	return 0;
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pc=
m.c
index 3427a21..f777145 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -231,8 +231,11 @@ static int capture_hw_params(struct snd_pcm_substrea=
m *substream,
 {
 	struct snd_dice *dice =3D substream->private_data;
=20
-	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&dice->substreams_counter);
+	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&dice->mutex);
+		dice->substreams_counter++;
+		mutex_unlock(&dice->mutex);
+	}
=20
 	amdtp_stream_set_pcm_format(&dice->tx_stream,
 				    params_format(hw_params));
@@ -245,8 +248,11 @@ static int playback_hw_params(struct snd_pcm_substre=
am *substream,
 {
 	struct snd_dice *dice =3D substream->private_data;
=20
-	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN)
-		atomic_inc(&dice->substreams_counter);
+	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&dice->mutex);
+		dice->substreams_counter++;
+		mutex_unlock(&dice->mutex);
+	}
=20
 	amdtp_stream_set_pcm_format(&dice->rx_stream,
 				    params_format(hw_params));
@@ -259,11 +265,15 @@ static int capture_hw_free(struct snd_pcm_substream=
 *substream)
 {
 	struct snd_dice *dice =3D substream->private_data;
=20
+	mutex_lock(&dice->mutex);
+
 	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&dice->substreams_counter);
+		dice->substreams_counter--;
=20
 	snd_dice_stream_stop_duplex(dice);
=20
+	mutex_unlock(&dice->mutex);
+
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
=20
@@ -271,11 +281,15 @@ static int playback_hw_free(struct snd_pcm_substrea=
m *substream)
 {
 	struct snd_dice *dice =3D substream->private_data;
=20
+	mutex_lock(&dice->mutex);
+
 	if (substream->runtime->status->state !=3D SNDRV_PCM_STATE_OPEN)
-		atomic_dec(&dice->substreams_counter);
+		dice->substreams_counter--;
=20
 	snd_dice_stream_stop_duplex(dice);
=20
+	mutex_unlock(&dice->mutex);
+
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
=20
@@ -284,7 +298,9 @@ static int capture_prepare(struct snd_pcm_substream *=
substream)
 	struct snd_dice *dice =3D substream->private_data;
 	int err;
=20
+	mutex_lock(&dice->mutex);
 	err =3D snd_dice_stream_start_duplex(dice, substream->runtime->rate);
+	mutex_unlock(&dice->mutex);
 	if (err >=3D 0)
 		amdtp_stream_pcm_prepare(&dice->tx_stream);
=20
@@ -295,7 +311,9 @@ static int playback_prepare(struct snd_pcm_substream =
*substream)
 	struct snd_dice *dice =3D substream->private_data;
 	int err;
=20
+	mutex_lock(&dice->mutex);
 	err =3D snd_dice_stream_start_duplex(dice, substream->runtime->rate);
+	mutex_unlock(&dice->mutex);
 	if (err >=3D 0)
 		amdtp_stream_pcm_prepare(&dice->rx_stream);
=20
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice=
-stream.c
index 37d1aab..edb6777 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -193,11 +193,9 @@ int snd_dice_stream_start_duplex(struct snd_dice *di=
ce, unsigned int rate)
 	enum cip_flags sync_mode;
 	int err =3D 0;
=20
-	if (atomic_read(&dice->substreams_counter) =3D=3D 0)
+	if (dice->substreams_counter =3D=3D 0)
 		goto end;
=20
-	mutex_lock(&dice->mutex);
-
 	err =3D get_sync_mode(dice, &sync_mode);
 	if (err < 0)
 		goto end;
@@ -271,23 +269,18 @@ int snd_dice_stream_start_duplex(struct snd_dice *d=
ice, unsigned int rate)
 		}
 	}
 end:
-	mutex_unlock(&dice->mutex);
 	return err;
 }
=20
 void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 {
-	if (atomic_read(&dice->substreams_counter) > 0)
+	if (dice->substreams_counter > 0)
 		return;
=20
-	mutex_lock(&dice->mutex);
-
 	snd_dice_transaction_clear_enable(dice);
=20
 	stop_stream(dice, &dice->tx_stream);
 	stop_stream(dice, &dice->rx_stream);
-
-	mutex_unlock(&dice->mutex);
 }
=20
 static int init_stream(struct snd_dice *dice, struct amdtp_stream *strea=
m)
@@ -332,7 +325,7 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice=
)
 {
 	int err;
=20
-	atomic_set(&dice->substreams_counter, 0);
+	dice->substreams_counter =3D 0;
=20
 	err =3D init_stream(dice, &dice->tx_stream);
 	if (err < 0)
@@ -345,8 +338,6 @@ end:
=20
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
-	mutex_lock(&dice->mutex);
-
 	snd_dice_transaction_clear_enable(dice);
=20
 	stop_stream(dice, &dice->tx_stream);
@@ -355,13 +346,14 @@ void snd_dice_stream_destroy_duplex(struct snd_dice=
 *dice)
 	stop_stream(dice, &dice->rx_stream);
 	destroy_stream(dice, &dice->rx_stream);
=20
-	atomic_set(&dice->substreams_counter, 0);
-
-	mutex_unlock(&dice->mutex);
+	dice->substreams_counter =3D 0;
 }
=20
 void snd_dice_stream_update_duplex(struct snd_dice *dice)
 {
+	/* The enable register becomes initialized, then streams are stopped. *=
/
+	dice->global_enabled =3D false;
+
 	/*
 	 * On a bus reset, the DICE firmware disables streaming and then goes
 	 * off contemplating its own navel for hundreds of milliseconds before
@@ -370,18 +362,11 @@ void snd_dice_stream_update_duplex(struct snd_dice =
*dice)
 	 * to stop so that the application can restart them in an orderly
 	 * manner.
 	 */
-	mutex_lock(&dice->mutex);
-
-	/* The enable register becomes initialized, then streams are stopped. *=
/
-	dice->global_enabled =3D false;
-
 	stop_stream(dice, &dice->rx_stream);
 	stop_stream(dice, &dice->tx_stream);
=20
 	fw_iso_resources_update(&dice->rx_resources);
 	fw_iso_resources_update(&dice->tx_resources);
-
-	mutex_unlock(&dice->mutex);
 }
=20
 static void dice_lock_changed(struct snd_dice *dice)
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index b6b2c92..2a5605f 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -316,10 +316,14 @@ static void dice_update(struct fw_unit *unit)
 {
 	struct snd_dice *dice =3D dev_get_drvdata(&unit->device);
=20
+	mutex_lock(&dice->mutex);
+
 	/* The handler address register becomes initialized. */
 	snd_dice_transaction_reinit(dice);
=20
 	snd_dice_stream_update_duplex(dice);
+
+	mutex_unlock(&dice->mutex);
 }
=20
 #define DICE_INTERFACE	0x000001
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 40552ca..d8b721c 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -77,7 +77,7 @@ struct snd_dice {
 	struct amdtp_stream rx_stream;
 	bool global_enabled;
 	struct completion clock_accepted;
-	atomic_t substreams_counter;
+	unsigned int substreams_counter;
 };
=20
 enum snd_dice_addr_type {
--=20
2.1.0


--------------090007060303010305050700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090007060303010305050700--
