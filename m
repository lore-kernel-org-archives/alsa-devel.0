From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] Kernel crash
Date: Wed, 15 Sep 2004 19:50:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915195008.33713acb.pochini@shiny.it>
References: <s5h7jr7whqj.wl@alsa2.suse.de>
	<XFMail.20040907095502.pochini@shiny.it>
	<20040911210212.317d930b.pochini@shiny.it>
	<s5hekl6tdru.wl@alsa2.suse.de>
	<20040913220729.466531ce.pochini@shiny.it>
	<s5h4qlzx22k.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qlzx22k.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Sep 2004 12:24:03 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> I believe the second part is not needed.  DRAINING in capture implies
> that the DMA is already stopped (like XRUN).

snd_pcm_capture_drain() says:

        case SNDRV_PCM_STATE_RUNNING:
                if (snd_pcm_update_hw_ptr(substream) >= 0) {
                        snd_pcm_stop(substream,
                                     snd_pcm_capture_avail(runtime) > 0 ?
                                     SNDRV_PCM_STATE_DRAINING : SNDRV_PCM_STATE_SETUP);
                        break;
                }
                /* Fall through */
        case SNDRV_PCM_STATE_XRUN:
               _xrun_recovery:
                snd_pcm_change_state(substream,
                                     snd_pcm_capture_avail(runtime) > 0 ?
                                     SNDRV_PCM_STATE_DRAINING : SNDRV_PCM_STATE_SETUP);
                break;

It may not be stopped when snd_pcm_update_hw_ptr()<0, if I'm not missing
something.


> If the second part really fixes the problem, the bug is in somewhere
> else.

It fixes it and yes, there is another problem: snd_pcm_change_state()
overrides the state machine.

snd_pcm_playback_drain() (when state=RUNNING) calls
snd_pcm_change_state(DRAINING). When substreams are linked, it changes the
state of all linked substreams *without* passing through
snd_pcm_capture_drain(DRAINING).

I checked all calls to snd_pcm_change_state() and the only problematic one
is at line 1288 inside snd_pcm_capture_drain(). The problem exists only if
capture and playback substreams are linked because a capture substream in
DRAINING state implies it's stopped, while a playback substream doesn't. My
patch is not the proper fix, but it workarounds the bug by fixing that
asymmetry. I make snd_pcm_capture_drop() and snd_pcm_playback_drop() behave
the same wrt DRAINING substreams.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
