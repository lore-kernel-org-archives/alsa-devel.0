From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] ALSA core: misc cleanups
Date: Sun, 28 Nov 2004 04:23:13 +0100
Message-ID: <20041128032312.GG4713@stusta.de>
References: <20041126002448.GM3537@stusta.de> <s5hwtw8nbe8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id F295924E
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 04:23:13 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hwtw8nbe8.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2004 at 11:38:07AM +0100, Takashi Iwai wrote:
> At Fri, 26 Nov 2004 01:24:48 +0100,
> Adrian Bunk wrote:
> > 
> > The patch below does the following cleanups under sound/core/ :
> > - make needlessly global code static
> > - remove the following stale prototypes from pcm.h
> >   (the functions are not or no longer present):
> >   - snd_pcm_capture_ready_jiffies
> >   - snd_pcm_playback_ready_jiffies
> > - remove the following unused global funxtions:
> >   - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
> >   - pcm_lib.c: snd_pcm_playback_ready
> >   - pcm_lib.c: snd_pcm_capture_ready
> >   - pcm_lib.c: snd_pcm_capture_empty
> >   - pcm_misc.c: snd_pcm_format_cpu_endian
> >   - pcm_misc.c: snd_pcm_format_size
> >   - seq/seq_instr.c: snd_seq_cluster_new
> >   - seq/seq_instr.c: snd_seq_cluster_free
> >   - seq/seq_midi_event.c: snd_midi_event_init
> >   - seq/seq_midi_event.c: snd_midi_event_resize_buffer
> >   - seq/seq_virmidi.c: snd_virmidi_receive
> > - remove the following unused EXPORT_SYMBOL's:
> >   - snd_create_proc_entry
> >   - snd_interval_ratden
> >   - snd_midi_channel_init
> >   - snd_midi_channel_init_set
> >   - snd_midi_event_init
> >   - snd_midi_event_resize_buffer
> >   - snd_pcm_capture_empty
> >   - snd_pcm_capture_poll
> >   - snd_pcm_capture_ready
> >   - snd_pcm_format_size
> >   - snd_pcm_lib_preallocate_free
> >   - snd_pcm_open
> >   - snd_pcm_playback_poll
> >   - snd_pcm_playback_ready
> >   - snd_pcm_release
> >   - snd_pcm_subformat_name
> >   - snd_pcm_suspend
> >   - snd_rawmidi_drain_input
> >   - snd_rawmidi_drop_output
> >   - snd_rawmidi_info
> >   - snd_remove_proc_entry
> >   - snd_timer_continue
> >   - snd_timer_system_resolution
> >   - snd_virmidi_receive
> 
> I disagree to remove all of these functions from the middle layer.
> Some of them could be reduced, but others were once used, and might be
> used in future, too.

The intention is not to blindly remove code you might need in the near 
future.

Can you comment on which of them are actually candidates for being 
removed? I'll then send you an updated patch.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
