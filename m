From: Carlo Wood <carlo@alinoe.com>
Subject: Re: [xvoice] Hacking ViaVoice, part 4
Date: Sat, 12 Jul 2003 15:50:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030712135025.GA6553@alinoe.com>
References: <20030712120834.GA5378@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030712120834.GA5378@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: xvoice@yahoogroups.com
Cc: kai.vehmanen@wakkanet.fi, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2003 at 02:08:34PM +0200, Carlo Wood wrote:
> Hence, the problem is now reduced to the question:
> Why is snd_pcm_update_hw_ptr_interrupt not called anymore
> after we did run into an xrun?

I added a few more printk's and already I can guess
what is the reason that the 'blackbox' (the rest)
stops calling snd_pcm_update_hw_ptr_interrupt:

Jul 12 15:40:38 ansset kernel: Entering snd_pcm_update_hw_ptr_interrupt
Jul 12 15:40:38 ansset kernel: snd_pcm_update_hw_ptr_interrupt: status->hw_ptr set to 2048
Jul 12 15:40:38 ansset kernel: snd_pcm_capture_avail: boundary = 1073741824, status->hw_ptr = 2048, control->appl_ptr = 1024
Jul 12 15:40:38 ansset kernel: Leaving snd_pcm_update_hw_ptr_interrupt with EPIPE

Lets have a closer look at snd_pcm_update_hw_ptr_interrupt:

        runtime->status->hw_ptr = new_hw_ptr;
        printk("snd_pcm_update_hw_ptr_interrupt: status->hw_ptr set to %li\n", runtime->status->hw_ptr);
        runtime->hw_ptr_interrupt = new_hw_ptr - new_hw_ptr % runtime->period_size;

        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
                avail = snd_pcm_playback_avail(runtime);
        else
                avail = snd_pcm_capture_avail(runtime);
        if (avail > runtime->avail_max)
                runtime->avail_max = avail;
        if (avail >= runtime->stop_threshold) {
                snd_pcm_stop(substream,
                             runtime->status->state == SNDRV_PCM_STATE_DRAINING ?
                             SNDRV_PCM_STATE_SETUP : SNDRV_PCM_STATE_XRUN);
                printk("Leaving snd_pcm_update_hw_ptr_interrupt with EPIPE\n");
                return -EPIPE;
        }
        if (avail >= runtime->control->avail_min)
                wake_up(&runtime->sleep);
        printk("Leaving snd_pcm_update_hw_ptr_interrupt\n");
        return 0;
}

I thought it was said that an xrun should simply be ignored?

What is the correct way to recover from this, to continue
recording in this case, after the xrun?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
