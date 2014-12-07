From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/15] ALSA: dice: Add support for
	MIDI	capture/playback
Date: Sun, 07 Dec 2014 22:44:29 +0100
Message-ID: <5484CA3D.5070004@ladisch.de>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417958348-30333-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9E59A2606C1
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 22:44:57 +0100 (CET)
In-Reply-To: <1417958348-30333-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This commit adds a support for MIDI capture/playback
>
> +++ b/sound/firewire/dice/dice-midi.c
> +static int capture_open(struct snd_rawmidi_substream *substream)
> +{
> +	struct snd_dice *dice = substream->rmidi->private_data;
> +	int err;
> +
> +	err = snd_dice_stream_lock_try(dice);
> +	if (err < 0)
> +		return err;
> +
> +	mutex_lock(&dice->mutex);
> +
> +	dice->substreams_counter++;
> +	err = snd_dice_stream_start_duplex(dice, 0);
> +
> +	mutex_unlock(&dice->mutex);
> +
> +	if (err < 0)
> +		snd_dice_stream_lock_release(dice);
> +
> +	return err;
> +}
> +
> +static int playback_open(struct snd_rawmidi_substream *substream)
> +{
> +	struct snd_dice *dice = substream->rmidi->private_data;
> +	int err;
> +
> +	err = snd_dice_stream_lock_try(dice);
> +	if (err < 0)
> +		return err;
> +
> +	mutex_lock(&dice->mutex);
> +
> +	dice->substreams_counter++;
> +	err = snd_dice_stream_start_duplex(dice, 0);
> +
> +	mutex_unlock(&dice->mutex);
> +
> +	if (err < 0)
> +		snd_dice_stream_lock_release(dice);
> +
> +	return err;
> +}

These two functions are identical.

> +static int capture_close(struct snd_rawmidi_substream *substream)
> +{
> +	struct snd_dice *dice = substream->rmidi->private_data;
> +
> +	mutex_lock(&dice->mutex);
> +
> +	dice->substreams_counter--;
> +	snd_dice_stream_stop_duplex(dice);
> +
> +	mutex_unlock(&dice->mutex);
> +
> +	snd_dice_stream_lock_release(dice);
> +	return 0;
> +}
> +
> +static int playback_close(struct snd_rawmidi_substream *substream)
> +{
> +	struct snd_dice *dice = substream->rmidi->private_data;
> +
> +	mutex_lock(&dice->mutex);
> +
> +	dice->substreams_counter--;
> +	snd_dice_stream_stop_duplex(dice);
> +
> +	mutex_unlock(&dice->mutex);
> +
> +	snd_dice_stream_lock_release(dice);
> +	return 0;
> +}

These two too.

> +static void set_midi_substream_names(struct snd_dice *dice,
> +				     struct snd_rawmidi_str *str)
> +{
> +	list_for_each_entry(subs, &str->substreams, list) {
> +		snprintf(subs->name, sizeof(subs->name),
> +			 "%s MIDI %d", dice->card->shortname, subs->number + 1);

This is not really important, but the number is useless when the
device has only one MIDI port.


Regards,
Clemens
