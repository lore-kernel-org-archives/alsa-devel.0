From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: No sound with ladspa plugin in newer alsa versions
Date: Mon, 22 Sep 2003 21:18:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309222113360.7787@pnote.perex-int.cz>
References: <3F660300.3000901@pianodisc.com> <3F6F42E7.3060103@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F6F42E7.3060103@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Sep 2003, Steve deRosier wrote:

> Well, after getting no responses, I've spent the last 40 some hours at
> work tracking the problem down.  I've got some more information and some
> more specific questions so someone might be able to help this time.
>
> I've managed to narrow down the problem with ladspa plugins.  Since it
> used to work, but doesn't any more I figured if I could find the
> specific change I would be able to get an idea where to look to fix the
> problem.  I checked out 20 some CVS versions, built and patched them as
> necessary to get things working and found that the ladspa plugins were
> broken on 2/4/2003.  CVS of 2003-02-04 at midnight worked, but CVS of
> 2003-02-05 didn't.  After diffing and then replacing new code with old
> on a change by change basis, I found that snd_pcm_plugin_mmap() and
> snd_pcm_plugin_munmap() in alsa-lib/src/pcm/pcm_plugin.c were stubbed
> out and marked ATTRIBUTE_UNUSED (aparently durring some of perex's DMix
> plugin changes).  Problem is, pcm_ladspa.c and others seem to still use
> these functions.  Adding these functions back into my checked out cvs
> 2/5/2003 version and ladspa plugins magically start working again.
>
> But, alas, things are not this easy.  I took my src copy of the 0.9.6
> release (I can't seem to get a current CVS to compile, it complains
> about a missing alsa-lib/src/userfile.c file) and put the functions back
> in (added the meat and removed the attribute), compiled and tested.  I
> now get sound out but it's all garbled.
>
> After looking a bit at pcm_ladspa.c and doing a few greps I found or
> infered that:
> 1. many of the pcm_{plugintype file here}.c files in there snd_pcm_ops_t
> structure variable they set the mmap and munmap fields still use this
> "ATTRIBUTE_UNUSED" function. Line 710 in pcm_ladspa.c.
> 2. DMix uses it's own version of these functions.
> 3. I'm infering that since just putting this function back in doesn't
> work, that something fundamental has changed with the mmap implmentation
> that makes it so the old functions don't work.
>
> I'm guessing that sometime since Feb., there's been some archetectural
> changes to some of the plugin stuff to get DMix working.  But, the other
> portions, including ladspa support, haven't kept up with the changes
> made and so are broken (am I the ONLY person trying to get ladspa
> plugins working with Alsa?).  I'd like to get this fixed.  I'm perfectly
> happy to do the work myself, but I don't know enough of how Alsa works
> in order to get this done.
>
> Here's what I understand: I'm getting the idea that each plugin type,
> when it is parsed in the config file, gets setup.  I presume that the
> _snd_pcm_ladspa_open() function is the entry point for the ladspa stuff.
>   It opens and does some stuff then it uses the snd_pcm_ops_t structure
> to tell the pcm stuff what functions to call in order to get things done
> when working with this plugin.  Kinda a OOP without C++ concept with the
> pcm_ladspa.c module as the "ladspa plugin handler object".  Origionally
> it seems that the pcm_plugin.c module was to provide the basic
> functionality for all the plugins, and then pcm_ladspa.c could override
> or use those functions in it's snd_pcm_ops_t as it needed to.
>
> So, if I was to fix this, I see two potential courses of action:
> 1. I can put meat back into the snd_pcm_plugin_mmap() ..._munmap()
> functions and then fix it to make it work with the newer stuff so that I
> both get sound out and it comes out properly.
> 2. I can create my own snd_pcm_ladspa_mmap() and ..._munmap() functions
> and use those.
>
> In either situation, I don't have a clue what I need to put in these
> functions to make them work.  Or even how they really fit into the
> structure of how things work with the pcm system.  I don't know enough
> about Alsa internals to hack this easily (though I'm finding I'm quickly
> being forced to learn).
>
> So, can someone either fix this for me
> or,
> please educate me enough on what I need to do to make this work so I can
> fix it myself and give you guys a patch.

Could you send me your configuration (aplay -v)? A quick test on my side
works (trident card) so it looks like a specific problem.

pcm.ladspa {
        type ladspa
        slave.pcm "plughw:0,0";
        path "/home/perex/src/ladspa_sdk/plugins";
        plugins [
                {
                        label delay_5s
                        input {
                                controls [ 0.8 0.2 ]
                        }
                }
        ]
}

perex@pnote:~/alsa/alsa-lib/src> aplay -v -D plug:ladspa ~/audio/audio_10.wav
Playing WAVE '/home/perex/audio/audio_10.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Linear Integer <-> Linear Float conversion PCM (FLOAT_LE)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 3333
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: LADSPA PCM
Control input port initial values: 0 = 0.80000001 1 = 0.20000000
Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : FLOAT_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 3333
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)
Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : FLOAT_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 3333
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'SiS SI7018' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 4096
period_time  : 92879
tick_time    : 3333
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Aborted by signal Interrupt...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
