From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: status of usb audio driver
Date: Fri, 14 Jun 2002 10:58:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206140858.KAA03305@papaschlumpf.wg>
References: <s5hn0tzz5vg.wl@alsa2.suse.de> <200206131321.PAA09889@papaschlumpf.wg> <s5hit4nz325.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit4nz325.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Thursday, 13. June 2002 16:05, wurde geschrieben:
>
> which kernel version are you using?
> i can see the error of firmware downloading above.  can it be related
> with the lock-up of alsa driver?

2.4.18 vanilla with emi26-patch
Well, using the oss-driver this doesn't happen (Well, the firmware-error 
remains, but nevertheless, after reconnecting the device all is fine and 
the firmware gets loaded)

>
> > At least I can reproduce this easily using xmms to playback some 7
> > minutes or so of 48kHz mp3s....
> >
> > Using aplay and waves this effect tends to appear later.
> > Using xmms' alsa-plugin crashes the sound-driver at once...
>
> then perhps difference is the period / buffer size.
> my driver allows very small period size up to 1msec, while oss driver
> uses always 10msec (5ms x 2).
>
> could you check the files under /proc/asound/cardX/pcm0p/sub0
> directory during playback?  they show the running set-up of pcm.

aplay:

Schlumpfine:~ # cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
tick_time: 10000

play (ie sox->/dev/dsp):
Schlumpfine:~ # cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 5638
buffer_size: 11276
tick_time: 10000
OSS format: U8
OSS channels: 1
OSS rate: 8000
OSS period bytes: 1024
OSS periods: 2

xmms:

Schlumpfine:~ # cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
tick_time: 10000
OSS format: S16_LE
OSS channels: 2
OSS rate: 48000
OSS period bytes: 4096
OSS periods: 16

aplay 96KHz:
Schlumpfine:~ # cat /proc/asound/card0/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 96000 (96000/1)
period_size: 4096
buffer_size: 16384
tick_time: 10000

obviously, I now can't get the system to lock up,... demonstration 
effect...

I'll get back to you, when I find other hints (the odd buffer/period size 
when accessing /dev/dsp directly seems strange...)

Have fun*

Niklas

BTW.: regarding the powermac-driver: I think I didn't answer your 
question with mic-sliders:
It doesn't matter where to put the value of the mic-slider to get the 
sound, simply moving it gets the sound out of the screamer.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
