From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: No sound with ladspa plugin in newer alsa versions
Date: Tue, 23 Sep 2003 17:44:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F70E8E7.7050708@pianodisc.com>
References: <3F660300.3000901@pianodisc.com> <3F6F42E7.3060103@pianodisc.com> <Pine.LNX.4.53.0309222113360.7787@pnote.perex-int.cz> <3F6F5DF1.80904@pianodisc.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F6F5DF1.80904@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav,

You've probably been distracted with more pressing matters, but are you 
still looking at this issue?  I'd be happy to look into it or fix it 
myself if you could give me some ideas of where/what/how to fix it.

Thanks,
- Steve

Steve deRosier wrote:
> Jaroslav, thanks for replying.  I'm not 100% sure that my setup is right 
> (it was quoted in the origional email), but since it used to work with 
> these setings, but now doesn't...?...
> 
> I've looked over both the setup in my asound.conf and the output from 
> the verbose mode aplay and I have nearly the same stuff as you show.
> 
> Here's the setup out of my /etc/asound.conf file:
> # cat /etc/asound.conf
> pcm.pd
> {
>    type ladspa
>    slave.pcm "plughw:0,0"
>    path "/lib/ladspa"
>    plugins
>    [
>       {
>          label amPitchshift
>          input
>          {
>             controls [ 0.890899 3 ]
>          }
>       }
>    ]
> }
> 
> And the aplay output:
> # aplay -v -D plug:pd alla_luce.wav
> aplay: /lib/libasound.so.2: no version information available (required 
> by aplay)
> Playing WAVE 'alla_luce.wav' : Signed 16 bit Little Endian, Rate 44100 
> Hz, Stereo
> Plug PCM: Linear Integer <-> Linear Float conversion PCM (FLOAT_LE)
> Its setup is:
> stream       : PLAYBACK
> access       : RW_INTERLEAVED
> format       : S16_LE
> subformat    : STD
> channels     : 2
> rate         : 44100
> exact rate   : 44100 (44100/1)
> msbits       : 16
> buffer_size  : 16384
> period_size  : 4096
> period_time  : 92879
> tick_time    : 10000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 4096
> xfer_align   : 4096
> start_threshold  : 16384
> stop_threshold   : 16384
> silence_threshold: 0
> silence_size : 0
> boundary     : 1073741824
> Slave: LADSPA PCM
> Control input port initial values: 0 = 0.89089900 1 = 3.00000000
> Its setup is:
> stream       : PLAYBACK
> access       : MMAP_NONINTERLEAVED
> format       : FLOAT_LE
> subformat    : STD
> channels     : 2
> rate         : 44100
> exact rate   : 44100 (44100/1)
> msbits       : 32
> buffer_size  : 16384
> period_size  : 4096
> period_time  : 92879
> tick_time    : 10000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 4096
> xfer_align   : 4096
> start_threshold  : 16384
> stop_threshold   : 16384
> silence_threshold: 0
> silence_size : 0
> boundary     : 1073741824
> Slave: Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)
> Its setup is:
> stream       : PLAYBACK
> access       : MMAP_NONINTERLEAVED
> format       : FLOAT_LE
> subformat    : STD
> channels     : 2
> rate         : 44100
> exact rate   : 44100 (44100/1)
> msbits       : 32
> buffer_size  : 16384
> period_size  : 4096
> period_time  : 92879
> tick_time    : 10000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 4096
> xfer_align   : 4096
> start_threshold  : 16384
> stop_threshold   : 16384
> silence_threshold: 0
> silence_size : 0
> boundary     : 1073741824
> Slave: Hardware PCM card 0 'VIA 82C686A/B rev50' device 0 subdevice 0
> 
> Its setup is:
> stream       : PLAYBACK
> access       : MMAP_INTERLEAVED
> format       : S16_LE
> subformat    : STD
> channels     : 2
> rate         : 44100
> exact rate   : 44100 (44100/1)
> msbits       : 16
> buffer_size  : 16384
> period_size  : 4096
> period_time  : 92879
> tick_time    : 10000
> tstamp_mode  : NONE
> period_step  : 1
> sleep_min    : 0
> avail_min    : 4096
> xfer_align   : 4096
> start_threshold  : 16384
> stop_threshold   : 16384
> silence_threshold: 0
> silence_size : 0
> boundary     : 1073741824
> Aborted by signal Interrupt...
> #
> 
> Anymore ideas?
> 
> Thanks,
> - Steve
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
