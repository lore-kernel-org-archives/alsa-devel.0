From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel PCM - still not
	quite working
Date: Sat, 23 Oct 2004 15:55:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1098561304.13176.92.camel@krustophenia.net>
References: <1097267526.1442.47.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1097267526.1442.47.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-10-08 at 16:32 -0400, Lee Revell wrote:
> Here is my first attempt at adding multichannel PCM playback support to
> the emu10k1 
...
> it correctly opens 16 playback and 16 capture channels.  However,
> the pointer callback and the interrupt handler only get called once; the
> jackd watchdog thread kills jackd eventually.  Looks like only the first
> period is handled, then it hangs.

OK, I think I might have figured this out.  It is important that the
playback stream be started before the capture.  If the capture stream is
started first, the playback pointer will not have reached the period
boundary by the time we call period_elapsed on the playback stream
inside the capture interrupt handler.  This will cause the ALSA middle
layer to wake up the playback stream prematurely, before there is enough
space in the buffer.

Also, I think I found a way to start and stop up to 32 playback voices
in sync.  Currently in the playback trigger callback we start the voices
one at a time:

        case SNDRV_PCM_TRIGGER_START:
	[...]
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
                snd_emu10k1_playback_trigger_voice(emu, epcm->voices[0], 1, 0);
                snd_emu10k1_playback_trigger_voice(emu, epcm->voices[1], 0, 0);
                snd_emu10k1_playback_trigger_voice(emu, epcm->extra, 1, 1);
                epcm->running = 1;

We prepare the voice, apply the mixer settings in playback_trigger_voice:

        if (evoice == NULL)     /* skip second voice for mono */
                return;
        substream = evoice->epcm->substream;
        runtime = substream->runtime;
        mix = &emu->pcm_mixer[substream->number];
        voice = evoice->number;
        pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
        pitch_target = emu10k1_calc_pitch_target(runtime->rate);
        attn = extra ? 0 : 0x00ff;
        tmp = runtime->channels == 2 ? (master ? 1 : 2) : 0;
        snd_emu10k1_ptr_write(emu, IFATN, voice, attn);
        snd_emu10k1_ptr_write(emu, VTFT, voice, (mix->attn[tmp] << 16) | 0xffff);
        snd_emu10k1_ptr_write(emu, CVCF, voice, (mix->attn[tmp] << 16) | 0xffff);
        snd_emu10k1_voice_clear_loop_stop(emu, voice);
        if (extra)
                snd_emu10k1_voice_intr_enable(emu, voice);
             
Then snd_emu10k1_voice_clear_loop_stop() actually starts the DMA
transfer:

        /* voice interrupt */
        if (voicenum >= 32) {
                outl(SOLEH << 16, emu->port + PTR);
                sol = inl(emu->port + DATA);
                sol &= ~(1 << (voicenum - 32));
        } else {
                outl(SOLEL << 16, emu->port + PTR);
                sol = inl(emu->port + DATA);
                sol &= ~(1 << voicenum);
        }
        outl(sol, emu->port + DATA);

SOLEL (Stop On Loop Enable Low) and SOLEH (Stop On Loop Enable High) are
not per-channel registers, but two 32-bit masks that correspond to the
64 total voices.  But the current code only flips one bit at a time.  If
we change snd_emu10k1_voice_clear_loop_stop to accept a 64 bit mask as
its argument, for up to a 32 channel PCM we preparing the voices
sequentially, then start them all in perfect sync with a single PCI
write.

This change would also benefit the standard PCM playback, because we
currently start the main voice(s) and the extra voice sequentially.  So
by the time the channel loop interrupt fires, the main voice is 1-2
samples ahead.  By triggering them simultaneously, we have 20-40 usecs
more headroom.

Patch forthcoming...

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
