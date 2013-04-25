From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Sound/HID: wiimote: add speaker support
Date: Thu, 25 Apr 2013 09:11:05 +0200
Message-ID: <5178D709.1060500@canonical.com>
References: <1366481693-5945-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E6DD0265D9D
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 09:11:06 +0200 (CEST)
In-Reply-To: <1366481693-5945-1-git-send-email-dh.herrmann@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/20/2013 08:14 PM, David Herrmann wrote:
> Classic Wii Remotes provide a speaker on the device. We can stream PCM
> data, mute and change volume via special protocol requests and remote
> audio registers.
>
> The device supports several different formats, but fully understood are
> only signed 8-bit PCM and something that looks like 4-bit Yamaha ADPCM.
> Theoretically, we can set data-rates from 183Hz up to 12MHz, but a
> realistic range for Bluetooth l2cap is 1500-4000 Hz.
>
> Data is streamed as 20bytes blocks and must be sent in a constant rate.
> There is no way to read the current position. It would be way too slow,
> anyway.

Hi,

Fun project!

I'm not sure I'm qualified to answer, but I would have allocated a 
buffer of kernel memory, say 64K (or maybe less, since the sample rate 
is so low). That would be the buffer you expose to userspace, and 
userspace would set period and buffer sizes according to this buffer.

Your code doesn't really expose if/how you can tell if you're allowed to 
send 20 more bytes or not. But assuming you have a timer running at a 
reasonable interval, that code would do something like:

if (ready_to_send_packet_to_wiimote()) {
   send_20_bytes_to_wiimote(kernel_buffer_ptr + offset);
   offset += 20;
   offset %= buffer_size;
   if (offset % period_size < 20)
     snd_pcm_period_elapsed();
}

I'm guessing that the hrtimer API would be appropriate, and some kind of 
RT priority. But I'm not really experienced in that area of kernel 
programming.


>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
>
> I'm reworking large parts of the HID Nintendo Wii Remote driver and wanted to
> add speaker support. I have never worked with the sound subsystem until now
> and need some help.
>
> The Wii Remote is a Bluetooth gamepad that features a small speaker on the
> remote. All information was gathered via reverse-engineering so I cannot tell
> you any specifics about the hardware, sorry. What I figured out so far is how
> to set up the speaker, stream data, set volume and mute the speaker.
>
> Supported formats are:
>    signed 8-bit PCM
>    4-bit Yamaha ADPCM
>
> I implemented only the 8-bit PCM as I couldn't figure out whether the kernel
> supports the other format?
>
> The wiiproto_* helpers in hid-wiimote-core.c are used to send the requests.
> Data is streamed as 20-bytes packets and must be sent at a constant rate.
>
> I would really appreciate if someone can have a look at hid-wiimote-speaker.c
> and help me fill the gaps. I figured out how to write the basic snd_card
> management and PCM setup, but I am stuck with buffer management now.
>
> I have a function called wiiproto_req_audio() which sends up to 20bytes of PCM
> data to the device. However, I cannot figure out how to integrate that into the
> snd_pcm object. The problem is that all other drivers I found have large DMA
> buffers which are filled whenever an interrupt signals more data. However, I
> don't have this setup but instead I need a timer (does the sound-core provide
> that?) which causes the "copy" callback to be called with 20bytes of data at a
> constant rate.
>
> Any help welcome! And if this whole idea is stupid, please tell me! ;)
>
> Thanks
> David
>
>   drivers/hid/Kconfig               |   3 +
>   drivers/hid/Makefile              |   3 +
>   drivers/hid/hid-wiimote-core.c    |  54 +++-
>   drivers/hid/hid-wiimote-modules.c |   5 +
>   drivers/hid/hid-wiimote-speaker.c | 539 ++++++++++++++++++++++++++++++++++++++
>   drivers/hid/hid-wiimote.h         |  17 ++
>   6 files changed, 619 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/hid/hid-wiimote-speaker.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e8ef86c..0b4d7e2 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -715,6 +715,9 @@ config HID_WIIMOTE
>   	the Wii U Gamepad) might be supported in the future. But currently
>   	support is limited to Bluetooth based devices.
>
> +	If Alsa sound support (CONFIG_SND) is enabled, this driver also provides
> +	a sound card interface for Wii Remote speakers.
> +
>   	If unsure, say N.
>
>   	To compile this driver as a module, choose M here: the
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 8b7106b..d149e10 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -32,6 +32,9 @@ hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
>   ifdef CONFIG_DEBUG_FS
>   	hid-wiimote-y	+= hid-wiimote-debug.o
>   endif
> +ifdef CONFIG_SND
> +	hid-wiimote-y	+= hid-wiimote-speaker.o
> +endif
>
>   obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
>   obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 906c146..53f1e88 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -17,6 +17,7 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/spinlock.h>
> +#include <linux/uaccess.h>
>   #include "hid-ids.h"
>   #include "hid-wiimote.h"
>
> @@ -309,8 +310,8 @@ void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags)
>   #define wiiproto_req_weeprom(wdata, os, buf, sz) \
>   			wiiproto_req_wmem((wdata), true, (os), (buf), (sz))
>
> -static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
> -				__u32 offset, const __u8 *buf, __u8 size)
> +void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
> +		       __u32 offset, const __u8 *buf, __u8 size)
>   {
>   	__u8 cmd[22];
>
> @@ -359,6 +360,52 @@ void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom, __u32 offset,
>   	wiimote_queue(wdata, cmd, sizeof(cmd));
>   }
>
> +void wiiproto_req_speaker(struct wiimote_data *wdata, bool on)
> +{
> +	__u8 cmd[2];
> +
> +	cmd[0] = WIIPROTO_REQ_SPEAKER;
> +	cmd[1] = on ? 0x04 : 0x00;
> +
> +	wiiproto_keep_rumble(wdata, &cmd[1]);
> +	wiimote_queue(wdata, cmd, sizeof(cmd));
> +}
> +
> +void wiiproto_req_mute(struct wiimote_data *wdata, bool on)
> +{
> +	__u8 cmd[2];
> +
> +	cmd[0] = WIIPROTO_REQ_MUTE;
> +	cmd[1] = on ? 0x04 : 0x00;
> +
> +	wiiproto_keep_rumble(wdata, &cmd[1]);
> +	wiimote_queue(wdata, cmd, sizeof(cmd));
> +}
> +
> +/* must not be called from atomic contexts */
> +int wiiproto_req_audio_user(struct wiimote_data *wdata,
> +			    void __user *buf, size_t len)
> +{
> +	unsigned long flags;
> +	__u8 cmd[22];
> +
> +	if (len > 20)
> +		len = 20;
> +
> +	cmd[0] = WIIPROTO_REQ_AUDIO;
> +	cmd[1] = (len & 0xff) << 3;
> +
> +	if (copy_from_user(&cmd[2], buf, len))
> +		return -EFAULT;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +	wiiproto_keep_rumble(wdata, &cmd[1]);
> +	wiimote_queue(wdata, cmd, sizeof(cmd));
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +	return 0;
> +}
> +
>   /* requries the cmd-mutex to be held */
>   int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
>   						const __u8 *wmem, __u8 size)
> @@ -570,6 +617,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
>   		WIIMOD_LED4,
>   		WIIMOD_ACCEL,
>   		WIIMOD_IR,
> +		WIIMOD_SPEAKER,
>   		WIIMOD_NULL,
>   	},
>   	[WIIMOTE_DEV_GEN10] = (const __u8[]){
> @@ -582,6 +630,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
>   		WIIMOD_LED4,
>   		WIIMOD_ACCEL,
>   		WIIMOD_IR,
> +		WIIMOD_SPEAKER,
>   		WIIMOD_NULL,
>   	},
>   	[WIIMOTE_DEV_GEN20] = (const __u8[]){
> @@ -595,6 +644,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
>   		WIIMOD_ACCEL,
>   		WIIMOD_IR,
>   		WIIMOD_BUILTIN_MP,
> +		WIIMOD_SPEAKER,
>   		WIIMOD_NULL,
>   	},
>   	[WIIMOTE_DEV_BALANCE_BOARD] = (const __u8[]) {
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
> index 4ce0e02..7acf721 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -2072,6 +2072,11 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
>   	[WIIMOD_IR] = &wiimod_ir,
>   	[WIIMOD_BUILTIN_MP] = &wiimod_builtin_mp,
>   	[WIIMOD_NO_MP] = &wiimod_no_mp,
> +#ifdef CONFIG_SND
> +	[WIIMOD_SPEAKER] = &wiimod_speaker,
> +#else
> +	[WIIMOD_SPEAKER] = &wiimod_dummy,
> +#endif
>   };
>
>   const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
> diff --git a/drivers/hid/hid-wiimote-speaker.c b/drivers/hid/hid-wiimote-speaker.c
> new file mode 100644
> index 0000000..ecec5d9
> --- /dev/null
> +++ b/drivers/hid/hid-wiimote-speaker.c
> @@ -0,0 +1,539 @@
> +/*
> + * Driver for audio speakers of Nintendo Wii / Wii U peripherals
> + * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +/*
> + * Audio Speakers
> + * Some Wii peripherals provide an audio speaker that supports 8bit PCM and
> + * some other mostly unknown formats. Not all setup options are known, but we
> + * know how to setup an 8bit PCM or 4bit ADPCM stream and adjust volume. Data
> + * is sent as 20bytes chunks and needs to be streamed at a constant rate.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <sound/control.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include "hid-wiimote.h"
> +
> +struct wiimote_speaker {
> +	struct snd_card *card;
> +	unsigned int online : 1;
> +	unsigned int mute : 1;
> +	__u8 volume;
> +};
> +
> +enum wiimod_speaker_mode {
> +	WIIMOD_SPEAKER_MODE_PCM8,
> +	WIIMOD_SPEAKER_MODE_ADPCM4,
> +};
> +
> +static int wiimod_speaker_enable(struct wiimote_data *wdata)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +
> +	if (!speaker->online) {
> +		speaker->online = 1;
> +		wiiproto_req_speaker(wdata, true);
> +		wiiproto_req_mute(wdata, speaker->mute);
> +	}
> +
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +	return 0;
> +}
> +
> +static void wiimod_speaker_disable(struct wiimote_data *wdata)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +
> +	if (speaker->online) {
> +		speaker->online = 0;
> +		wiiproto_req_speaker(wdata, false);
> +	}
> +
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +}
> +
> +static void wiimod_speaker_set_mute(struct wiimote_data *wdata, bool mute)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +
> +	if (speaker->mute != mute) {
> +		speaker->mute = mute;
> +		if (speaker->online)
> +			wiiproto_req_mute(wdata, mute);
> +	}
> +
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +}
> +
> +static void wiimod_speaker_set_volume(struct wiimote_data *wdata, __u8 volume)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +
> +	if (speaker->volume != volume) {
> +		speaker->volume = volume;
> +		if (speaker->online)
> +			wiiproto_req_wmem(wdata, false, 0xa20005, &volume,
> +					  sizeof(volume));
> +	}
> +
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +}
> +
> +/* Change speaker configuration. \mode can be one of WIIMOD_SPEAKER_MODE_*,
> + * \rate is the PCM sample rate and \volume is the requested volume. */
> +static int wiimod_speaker_setup(struct wiimote_data *wdata,
> +				__u8 mode, __u16 rate, __s16 volume)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +	__u8 config[7], m, wmem;
> +	__u16 r;
> +	int ret;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	switch (mode) {
> +	case WIIMOD_SPEAKER_MODE_PCM8:
> +		r = 12000000ULL / rate;
> +		m = 0x40;
> +		break;
> +	case WIIMOD_SPEAKER_MODE_ADPCM4:
> +		r = 6000000ULL / rate;
> +		m = 0x00;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	config[0] = 0x00;
> +	config[1] = m;
> +	config[2] = r & 0x00ff;
> +	config[3] = (r & 0xff00) >> 8;
> +	config[4] = volume & 0xff;
> +	config[5] = 0x00;
> +	config[6] = 0x00;
> +
> +	wiimote_cmd_acquire_noint(wdata);
> +
> +	/* mute speaker during setup and read/write volume field */
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +
> +	wiiproto_req_mute(wdata, true);
> +	if (volume < 0)
> +		config[4] = speaker->volume;
> +	else
> +		speaker->volume = volume;
> +
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +	/* power speaker */
> +	wmem = 0x01;
> +	ret = wiimote_cmd_write(wdata, 0xa20009, &wmem, sizeof(wmem));
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* prepare setup */
> +	wmem = 0x08;
> +	ret = wiimote_cmd_write(wdata, 0xa20001, &wmem, sizeof(wmem));
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* write configuration */
> +	ret = wiimote_cmd_write(wdata, 0xa20001, config, sizeof(config));
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* enable speaker */
> +	wmem = 0x01;
> +	ret = wiimote_cmd_write(wdata, 0xa20008, &wmem, sizeof(wmem));
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* unmute speaker after setup if not muted */
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +	if (!speaker->mute)
> +		wiiproto_req_mute(wdata, false);
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +out_unlock:
> +	wiimote_cmd_release(wdata);
> +	return ret;
> +}
> +
> +/* PCM layer */
> +
> +static const struct snd_pcm_hardware wiimod_speaker_playback_hw = {
> +	.info = SNDRV_PCM_INFO_NONINTERLEAVED,
> +	.formats = SNDRV_PCM_FMTBIT_S8,
> +	.rates = SNDRV_PCM_RATE_CONTINUOUS,
> +	.rate_min = 1500,
> +	.rate_max = 4000,
> +	.channels_min = 1,
> +	.channels_max = 1,
> +	.buffer_bytes_max = 20,
> +	.period_bytes_min = 20,
> +	.period_bytes_max = 20,
> +	.periods_min = 1,
> +	.periods_max = 1,
> +};
> +
> +static int wiimod_speaker_playback_open(struct snd_pcm_substream *substream)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	runtime->hw = wiimod_speaker_playback_hw;
> +	runtime->private_data = wdata;
> +
> +	return wiimod_speaker_enable(wdata);
> +}
> +
> +static int wiimod_speaker_playback_close(struct snd_pcm_substream *substream)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(substream);
> +
> +	wiimod_speaker_disable(wdata);
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_playback_hw_params(struct snd_pcm_substream *subs,
> +					     struct snd_pcm_hw_params *hw)
> +{
> +	/* TODO: anything to do here? */
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_playback_hw_free(struct snd_pcm_substream *subs)
> +{
> +	return 0;
> +}
> +
> +static int wiimod_speaker_playback_prepare(struct snd_pcm_substream *subs)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(subs);
> +	struct snd_pcm_runtime *runtime = subs->runtime;
> +	size_t buf_size, period_size, periods;
> +	int ret;
> +
> +	/* TODO: If I have set the hw-params to a fixed 20 bytes buffer, do
> +	 * I actually need to do any computations here? */
> +	buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> +	period_size = frames_to_bytes(runtime, runtime->period_size);
> +	periods = runtime->periods;
> +
> +	switch (runtime->format) {
> +	case SNDRV_PCM_FMTBIT_S8:
> +		ret = wiimod_speaker_setup(wdata, WIIMOD_SPEAKER_MODE_PCM8,
> +					   runtime->rate, -1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int wiimod_speaker_playback_trigger(struct snd_pcm_substream *subs,
> +					   int cmd)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(subs);
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_START:
> +		/* unmute device on start if not muted by user-space */
> +		spin_lock_irqsave(&wdata->state.lock, flags);
> +		if (!speaker->mute)
> +			wiiproto_req_mute(wdata, false);
> +		spin_unlock_irqrestore(&wdata->state.lock, flags);
> +		break;
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		/* mute device when stopping transmission */
> +		spin_lock_irqsave(&wdata->state.lock, flags);
> +		wiiproto_req_mute(wdata, true);
> +		spin_unlock_irqrestore(&wdata->state.lock, flags);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static snd_pcm_uframes_t wiimod_speaker_playback_pointer(struct snd_pcm_substream *subs)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(subs);
> +	unsigned long pos;
> +
> +	/* There is no way to read the current position. Even if there was a
> +	 * way to do that, it would be so slow that it would be useless.
> +	 * TODO: Should we interpolate via a timer? Is this function actually
> +	 * needed? When is it called? */
> +	pos = 0;
> +
> +	pos %= 20;
> +
> +	return bytes_to_frames(subs->runtime, pos);
> +}
> +
> +static int wiimod_speaker_playback_copy(struct snd_pcm_substream *subs,
> +					int channel, snd_pcm_uframes_t pos,
> +					void __user *buf,
> +					snd_pcm_uframes_t count)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(subs);
> +	struct snd_pcm_runtime *runtime = subs->runtime;
> +
> +	count = frames_to_bytes(runtime, count);
> +	pos = frames_to_bytes(runtime, pos);
> +
> +	/* TODO: copy from "buf" "count" bytes to "protobuf + pos"
> +	 * With the given hw-params, can pos be non-zero? Can count != 20?
> +	 * If not, should I simply send a 20byte frame to the device here? */
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_playback_silence(struct snd_pcm_substream *subs,
> +					   int channel, snd_pcm_uframes_t pos,
> +					   snd_pcm_uframes_t count)
> +{
> +	struct wiimote_data *wdata = snd_pcm_chip(subs);
> +	struct snd_pcm_runtime *runtime = subs->runtime;
> +
> +	count = frames_to_bytes(runtime, count);
> +	pos = frames_to_bytes(runtime, pos);
> +
> +	/* TODO: set "count" bytes of "protobuf + pos" to zero
> +	 * Can "pos" actually be non-zero with the given hw-params? If not,
> +	 * can I simply send a 20byte zeroed frame to the remote device? */
> +
> +	return 0;
> +}
> +
> +/* TODO: is there a reason this cannot be "const"? */
> +static struct snd_pcm_ops wiimod_speaker_playback_ops = {
> +	.open		= wiimod_speaker_playback_open,
> +	.close		= wiimod_speaker_playback_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= wiimod_speaker_playback_hw_params,
> +	.hw_free	= wiimod_speaker_playback_hw_free,
> +	.prepare	= wiimod_speaker_playback_prepare,
> +	.trigger	= wiimod_speaker_playback_trigger,
> +	.pointer	= wiimod_speaker_playback_pointer,
> +	.copy		= wiimod_speaker_playback_copy,
> +	.silence	= wiimod_speaker_playback_silence,
> +};
> +
> +/* volume control */
> +
> +static int wiimod_speaker_volume_info(struct snd_kcontrol *kcontrol,
> +				      struct snd_ctl_elem_info *info)
> +{
> +	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	info->count = 1;
> +	info->value.integer.min = 0;
> +	info->value.integer.max = 0xff;
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_volume_get(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *val)
> +{
> +	struct wiimote_data *wdata = snd_kcontrol_chip(kcontrol);
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +	val->value.integer.value[0] = speaker->volume;
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_volume_put(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *val)
> +{
> +	struct wiimote_data *wdata = snd_kcontrol_chip(kcontrol);
> +	unsigned long value;
> +
> +	value = val->value.integer.value[0];
> +	if (value > 0xff)
> +		value = 0xff;
> +
> +	wiimod_speaker_set_volume(wdata, value);
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new wiimod_speaker_volume = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
> +	.name = "PCM Playback Volume",
> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.info = wiimod_speaker_volume_info,
> +	.get = wiimod_speaker_volume_get,
> +	.put = wiimod_speaker_volume_put,
> +};
> +
> +/* mute control */
> +
> +static int wiimod_speaker_mute_get(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *val)
> +{
> +	struct wiimote_data *wdata = snd_kcontrol_chip(kcontrol);
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +	val->value.integer.value[0] = !!speaker->mute;
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +
> +	return 0;
> +}
> +
> +static int wiimod_speaker_mute_put(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *val)
> +{
> +	struct wiimote_data *wdata = snd_kcontrol_chip(kcontrol);
> +
> +	wiimod_speaker_set_mute(wdata, val->value.integer.value[0]);
> +
> +	return 0;
> +}
> +
> +/* TODO: Is *_IFACE_CARD the right interface? */
> +static const struct snd_kcontrol_new wiimod_speaker_mute = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
> +	.name = "PCM Playback Switch",
> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.info = snd_ctl_boolean_mono_info,
> +	.get = wiimod_speaker_mute_get,
> +	.put = wiimod_speaker_mute_put,
> +};
> +
> +/* initialization and setup */
> +
> +static int wiimod_speaker_probe(const struct wiimod_ops *ops,
> +				struct wiimote_data *wdata)
> +{
> +	int ret;
> +	struct wiimote_speaker *speaker;
> +	struct snd_card *card;
> +	struct snd_kcontrol *kcontrol;
> +	struct snd_pcm *pcm;
> +
> +	/* create sound card device */
> +	ret = snd_card_create(-1, NULL, THIS_MODULE,
> +			      sizeof(struct wiimote_speaker), &card);
> +	if (ret)
> +		return ret;
> +	speaker = card->private_data;
> +
> +	wdata->speaker = speaker;
> +	speaker->card = card;
> +	speaker->mute = 1;
> +	speaker->volume = 0xff;
> +	strcpy(card->driver, "hid-wiimote");
> +	strcpy(card->shortname, "wiimote");
> +	strcpy(card->longname, "Nintendo Wii Remote speaker");
> +
> +	/* create volume control */
> +	kcontrol = snd_ctl_new1(&wiimod_speaker_volume, wdata);
> +	if (!kcontrol) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	ret = snd_ctl_add(card, kcontrol);
> +	if (ret) {
> +		snd_ctl_free_one(kcontrol);
> +		goto err_free;
> +	}
> +
> +	/* create mute control */
> +	kcontrol = snd_ctl_new1(&wiimod_speaker_mute, wdata);
> +	if (!kcontrol) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	ret = snd_ctl_add(card, kcontrol);
> +	if (ret) {
> +		snd_ctl_free_one(kcontrol);
> +		goto err_free;
> +	}
> +
> +	/* create PCM sub-device for playback */
> +	ret = snd_pcm_new(card, "Speaker", 0, 1, 0, &pcm);
> +	if (ret)
> +		goto err_free;
> +
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
> +			&wiimod_speaker_playback_ops);
> +	pcm->private_data = wdata;
> +
> +	/* register sound card */
> +	snd_card_set_dev(card, &wdata->hdev->dev);
> +	ret = snd_card_register(card);
> +	if (ret)
> +		goto err_free;
> +
> +	return 0;
> +
> +err_free:
> +	snd_card_free(card);
> +	wdata->speaker = NULL;
> +	return ret;
> +}
> +
> +static void wiimod_speaker_remove(const struct wiimod_ops *ops,
> +				  struct wiimote_data *wdata)
> +{
> +	struct wiimote_speaker *speaker = wdata->speaker;
> +
> +	if (!speaker)
> +		return;
> +
> +	snd_card_free_when_closed(speaker->card);
> +	wdata->speaker = NULL;
> +}
> +
> +const struct wiimod_ops wiimod_speaker = {
> +	.flags = 0,
> +	.arg = 0,
> +	.probe = wiimod_speaker_probe,
> +	.remove = wiimod_speaker_remove,
> +};
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 30caef5..4907bc7 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -148,6 +148,7 @@ struct wiimote_data {
>   	struct timer_list timer;
>   	struct wiimote_ext *ext;
>   	struct wiimote_debug *debug;
> +	struct wiimote_speaker *speaker;
>
>   	union {
>   		struct input_dev *input;
> @@ -172,6 +173,7 @@ enum wiimod_module {
>   	WIIMOD_IR,
>   	WIIMOD_BUILTIN_MP,
>   	WIIMOD_NO_MP,
> +	WIIMOD_SPEAKER,
>   	WIIMOD_NUM,
>   	WIIMOD_NULL = WIIMOD_NUM,
>   };
> @@ -208,9 +210,12 @@ enum wiiproto_reqs {
>   	WIIPROTO_REQ_LED = 0x11,
>   	WIIPROTO_REQ_DRM = 0x12,
>   	WIIPROTO_REQ_IR1 = 0x13,
> +	WIIPROTO_REQ_SPEAKER = 0x14,
>   	WIIPROTO_REQ_SREQ = 0x15,
>   	WIIPROTO_REQ_WMEM = 0x16,
>   	WIIPROTO_REQ_RMEM = 0x17,
> +	WIIPROTO_REQ_AUDIO = 0x18,
> +	WIIPROTO_REQ_MUTE = 0x19,
>   	WIIPROTO_REQ_IR2 = 0x1a,
>   	WIIPROTO_REQ_STATUS = 0x20,
>   	WIIPROTO_REQ_DATA = 0x21,
> @@ -241,6 +246,12 @@ extern void wiiproto_req_status(struct wiimote_data *wdata);
>   extern void wiiproto_req_accel(struct wiimote_data *wdata, __u8 accel);
>   extern void wiiproto_req_ir1(struct wiimote_data *wdata, __u8 flags);
>   extern void wiiproto_req_ir2(struct wiimote_data *wdata, __u8 flags);
> +extern void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
> +			      __u32 offset, const __u8 *buf, __u8 size);
> +extern void wiiproto_req_speaker(struct wiimote_data *wdata, bool on);
> +extern void wiiproto_req_mute(struct wiimote_data *wdata, bool on);
> +extern int wiiproto_req_audio_user(struct wiimote_data *wdata,
> +				   void __user *buf, size_t len);
>   extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
>   						const __u8 *wmem, __u8 size);
>   extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
> @@ -283,6 +294,12 @@ static inline void wiidebug_deinit(void *u) { }
>
>   #endif
>
> +#ifdef CONFIG_SND
> +
> +extern const struct wiimod_ops wiimod_speaker;
> +
> +#endif
> +
>   /* requires the state.lock spinlock to be held */
>   static inline bool wiimote_cmd_pending(struct wiimote_data *wdata, int cmd,
>   								__u32 opt)
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
