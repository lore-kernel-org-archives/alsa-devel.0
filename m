From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: problems with intel8x0 and 1.0.0pre3 (was: Re:
 [ANN] ALSA 1.0.0pre1 is released)
Date: Fri, 28 Nov 2003 16:06:19 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0311281554030.11873-100000@ecabase.localdomain>
References: <s5h8ym1d6rc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8ym1d6rc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 27 Nov 2003, Takashi Iwai wrote:
>>>   /proc/asound/card0/pcm0p/sub0/hw_params and
>>> .. the rate is locked to 48000 with 1.0.0pre3.
> do you mean both for playback and capture, or only on capture side?
> if the playback rate isn't set correctly (i.e. aplay -Dhw with 44.1kHz
> doesn't work), it's a serious problem.

that seems to be the case. I get this error:

--cut--
[kaiv@hed040-169 ad]$ aplay -Dhw:0 ~/mp3/foo2.wav 
Playing WAVE '/home/kaiv/mp3/foo2.wav' : Signed 16 bit Little Endian, Rate 
44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:hw:0)
--cut--

With an app that opens playback and capture with 8000kHz, the hw_params 
output looks like this:

--cut--
[root@hed040-169 pub]# cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 960
buffer_size: 1920
tick_time: 10000
[root@hed040-169 pub]# cat /proc/asound/card0/pcm0c/sub0/hw_params 
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 8000 (8000/1)
period_size: 160
buffer_size: 320
tick_time: 10000
--cut--

> but, if it's a capture side, right now i found and fixed a bug.
> could you try and check whether it works for you?

The above results are with your patch applied. The ADC rate seems to be
correct.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
