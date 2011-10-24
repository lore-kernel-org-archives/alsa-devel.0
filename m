From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA PulseAudio plugin: snd_pcm_rewindable()
 returns >0, but snd_pcm_rewind() is broken
Date: Tue, 25 Oct 2011 07:00:19 +0800
Message-ID: <CAN8ccibbw6q3g8=ixKoL0oKBbPfc40SJwdBeCf=A07R7RWjOsQ@mail.gmail.com>
References: <4EA567EA.1020603@gmail.com>
	<4ea5858a.4a2acc0a.3bb5.5b58SMTPIN_ADDED@mx.google.com>
	<4EA59886.7000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4FA8924338
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 01:00:21 +0200 (CEST)
Received: by faao24 with SMTP id o24so174249faa.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 16:00:19 -0700 (PDT)
In-Reply-To: <4EA59886.7000205@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/10/25 Nikolay Nikolov <nickysn@gmail.com>:
> On 10/24/2011 06:34 PM, Pierre-Louis Bossart wrote:
>> You want to avoid rewinding completely. Your audio hardware might have
>> prefetched data with the DMA subsystem. Rewinding completely might result in
>> an inconsistent configuration and possibly underflows. If you look at the
>> PulseAudio code, we've introduced some thresholds beyond which we don't
>> rewind (128 bytes or 1ms off the top of my head).

This seem not enough for snd-ymfpci which update hw_ptr on 5.333 ms
intervals using its own timer interrupt (i.e. mininum 256 bytes period
size) at 48000Hz

http://thread.gmane.org/gmane.linux.alsa.devel/89157/focus=89167

This seem to be a design fault of alsa-pulse plugin which provide a
latency (minimum period size of 128 bytes) which is less than some of
the alsa sound drivers (e.g. snd-ymfpci, ...) and even PA server probe
those sound cards during initialisation but there is no negotiation
between PA server and client using alsa-pulse plugin

>> You might argue that snd_pcm_rewindable is broken, but it's somewhat
>> difficult to fix as the amount of prefetched data isn't modeled in the
>> driver and it's very much hardware-specific. Using a less aggressive
>> approach works fine on most hardware.
>> -Pierre

> Yes, I figured this out while experimenting with real hw alsa devices
> and that's why I actually rewind snd_pcm_rewindable() minus some
> threshold, that can be configured. However with the alsa pulseaudio
> plugin, rewinding seems to be broken completely, even with a very large
> threshold.

This is quite complicated when some of alsa driver (e.g.snd-ymfpci)
does not provide an accurate hw_ptr

I guess this may be the reason why aplay using 4 periods per buffer


For pulse plugin ,it will need to add two callback into
snd_pcm_ioplug_callback in alsa-lib/include/pcm_ioplug.h

	snd_pcm_sframes_t (*rewindable)(snd_pcm_ioplug_t *io);
	snd_pcm_sframes_t (*forwardwable)(snd_pcm_ioplug_t *io);

and alsa-lib/src/pcm_ioplug.c


static snd_pcm_sframes_t snd_pcm_ioplug_rewindable(snd_pcm_t *pcm)
{
	ioplug_priv_t *io = pcm->private_data;
+	if (io->data->callback->rewindable) {
+		return io->data->callback->rewindable(io->data);
	return snd_pcm_mmap_hw_avail(pcm);
}

static snd_pcm_sframes_t snd_pcm_ioplug_forwardable(snd_pcm_t *pcm)
{
	ioplug_priv_t *io = pcm->private_data;
+	if (io->data->callback->forwardable) {
+		return io->data->callback->forwardable(io->data);
	return snd_pcm_mmap_avail(pcm);
}

and add pulse_rewindable() and pulse_forwardable() to
alsa-plugin/pulse/pcm_pulse.c
