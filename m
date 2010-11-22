From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Mon, 22 Nov 2010 10:27:24 -0600
Message-ID: <AANLkTimuizeF+p23wrBg9CQFouhRHj2x6g7tD3bQ8g4=@mail.gmail.com>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
	<alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C67D24335
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 17:27:27 +0100 (CET)
Received: by gwaa20 with SMTP id a20so4890070gwa.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 08:27:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, wim.taymans@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

>>> Could you test patch bellow?
>>>
>>>
>>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=ba9332e9192814a5431a3a2505d25d74a9232124
>>
>> Nah, no luck. PulseAudio still reports an error and if I add
>> assert(*delayp >= *availp) the code bombs out.
>> Here is one way to solve the problem. I don't claim it's the right
>> one, but it's compatible with the way the availp value is computed,
>> and it makes the error message go away in PulseAudio.
>
> The double avail_update() calling seems too expensive to me. Could you test
> to use snd_pcm_mmap_capture_avail() instead snd_pcm_avail_update() calls (to
> assign both slave_avail and plugin_avail local variables)?

Nope, it still does not work if you use mmap_capture_avail. The root
cause of the problem is the while loop in snd_pcm_plugin_avail_update
(copied for reference below), it's called only in the capture case and
the value returned by the xfer variable causes the delay to be
eventually lower than the avail samples.
My fix is indeed expensive but it makes sure the same loop is called
twice, so that these two delay and avail values are consistent. I
don't know how to fix it in a different manner since I don't
understand this while loop in the first place. Maybe we need to
refactor this loop so that it's called in the delay() routine as well?
-Pierre

while (size > 0 && slave_size > 0) {
			snd_pcm_uframes_t frames = size;
			snd_pcm_uframes_t cont = pcm->buffer_size - hw_offset;
			const snd_pcm_channel_area_t *slave_areas;
			snd_pcm_uframes_t slave_offset;
			snd_pcm_uframes_t slave_frames = ULONG_MAX;
			snd_pcm_sframes_t result;
			int err;

			err = snd_pcm_mmap_begin(slave, &slave_areas, &slave_offset, &slave_frames);
			if (err < 0)
				return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
			if (frames > cont)
				frames = cont;
			frames = (plugin->read)(pcm, areas, hw_offset, frames,
					      slave_areas, slave_offset, &slave_frames);
			snd_atomic_write_begin(&plugin->watom);
			snd_pcm_mmap_hw_forward(pcm, frames);
			result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
			snd_atomic_write_end(&plugin->watom);
			if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
				snd_pcm_sframes_t res;
				
				res = plugin->undo_read(slave, areas, hw_offset, frames,
slave_frames - result);
				if (res < 0)
					return xfer > 0 ? (snd_pcm_sframes_t)xfer : res;
				frames -= res;
			}
			if (result <= 0)
				return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
			if (frames == cont)
				hw_offset = 0;
			else
				hw_offset += frames;
			size -= frames;
			slave_size -= slave_frames;
			xfer += frames;
		}
		return (snd_pcm_sframes_t)xfer;
