From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1: difference between _fx8010_ and _efx_
Date: Thu, 24 Jun 2004 15:45:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088106324.1591.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hey,

I have been looking at the emu10k1 driver source and am confused about 
the use of _fx8010_ and _efx_ in variable names.  The FX8010 is the 
DSP used for hardware "efx" in the EMU10K1.  Can someone clarify the 
distinction?

It seems like these are almost used interchangable in some places, but 
I am sure there are important distinctions.

I have heard that these devices have something to do with AC3 
passthrough.

Here is an example from emupcm.c:

int __devinit snd_emu10k1_pcm_efx(emu10k1_t * emu, int device, snd_pcm_t
** rpcm)
{
        snd_pcm_t *pcm;
        int err;

        if (rpcm)
                *rpcm = NULL;

        if ((err = snd_pcm_new(emu->card, "emu10k1 efx", device, 8, 1,
&pcm)) < 0)
                return err;

        pcm->private_data = emu;
        pcm->private_free = snd_emu10k1_pcm_efx_free;

        snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
&snd_emu10k1_fx8010_playback_ops);
        snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
&snd_emu10k1_capture_efx_ops);


Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
