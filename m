From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [PATCH] let 2.5.51 build
Date: Wed, 11 Dec 2002 16:51:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2k7iga70k.fsf@vador.mandrakesoft.com>
References: <m2k7igc29i.fsf@vador.mandrakesoft.com>
	<s5hlm2w7e8f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm2w7e8f.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 11 Dec 2002 16:43:44 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > this patch enable 2.5.51 kernel to build without sequencer support :
> 
> hmm, applying this is surely harmless but i still don't figure out
> why this fixes the bug.  synth/emux/Makefile is:
> 
> snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
> 		       emux_effect.o emux_proc.o soundfont.o
> ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
>   snd-emux-synth-objs += emux_oss.o
> endif
> 
> # Toplevel Module Dependency
> ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
>   obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
>   obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
> endif
> 
> and if $CONFIG_SND_SEQUENCER is n, snd-emux-synth.o will be never
> compiled nor built-in...

hummmm. must be some sort of "too late in the night to compile a
kernel" workaround for a broken make rule (was not able to build
emux/built-in.o if i remember right)

so you can just discard this patch



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
