From: Albert Jongkit Wong <awong@cs.washington.edu>
Subject: Re: ppc usb-audio problems
Date: Thu, 10 Oct 2002 22:31:33 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021010222040.I24345-100000@fiji.cs.washington.edu>
References: <s5hbs62ecxo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs62ecxo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> i don't think all of them are broken.
> possibly this behavior might be influenced by the period size, etc.
> can you check /proc/asound/card0/pcm0p/sub0/hw_params at each case and
> compare them?


So I tried playing the same mp3 in 3 methods.  The first was using xmms 
through its oss output device. The second was using xmms with its alsa 
plugin.  The third was using the pipe of raw sound data from mpg123 to 
aplay (mpg321 -s /mnt/mp3/Mpegs/Anime/Arc\ en\ Ciel,\ Le/DIVE_T~1.MP3 | 
aplay -c 2 -t raw -r 44100 -f S16_LE -).  Here's the output of hw_params 
for each:

xmms (oss)
terran@Mittermeyer terran $ cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 16384
tick_time: 10000
OSS format: S16_BE
OSS channels: 2
OSS rate: 44100
OSS period bytes: 4096
OSS periods: 16

xmms (alsa)
terran@Mittermeyer terran $ cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 2205
buffer_size: 16384
tick_time: 10000


mpg123 piped to aplay
terran@Mittermeyer terran $ cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
tick_time: 10000



You'ore right, the period_size is different for each test.  The xmms alsa 
plugin is not a power of 2 however.  Is that problem?

esd and mplayer still refuse to start.

Esd failing to set any format giving this output:

terran@Mittermeyer terran $ esd
Audio device open for 44.1Khz, stereo, 16bit failed
Trying 44.1Khz, 8bit stereo.
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.
Audio device open for 48Khz, stereo,16bit failed
Trying 22.05Khz, 8bit stereo.
Audio device open for 22.05Khz, stereo, 8bit failed
Trying 44.1Khz, 16bit mono.
Audio device open for 44.1Khz, mono, 8bit failed
Trying 22.05Khz, 8bit mono.
Audio device open for 22.05Khz, mono, 8bit failed
Trying 11.025Khz, 8bit stereo.
Audio device open for 11.025Khz, stereo, 8bit failed
Trying 11.025Khz, 8bit mono.
Audio device open for 11.025Khz, mono, 8bit failed
Trying 8.192Khz, 8bit mono.
Audio device open for 8.192Khz, mono, 8bit failed
Trying 8Khz, 8bit mono.
Sound device inadequate for Esound. Fatal.


And mplayer apparently couldn't initialize its alsa9 codec:
 
==========================================================================
AO: [alsa9] 24000Hz 2ch Signed 16-bit (Big-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 24000 Hz, 2 channels, Signed 16-bit 
(Big-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa-init: unable to set format: Invalid argument
couldn't open/init audio device -> no sound
Audio: no sound!!!


Is there any more information I can provide?


Thanks for being so patient with this.  It is very much appreciated.


-Albert





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
