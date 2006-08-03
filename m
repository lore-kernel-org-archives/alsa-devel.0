From: Krivenok Dmitry <_asr_@inbox.ru>
Subject: Re: =?koi8-r?b?VmlydHVhbCBzb3VuZCBjYXJk?=
Date: Thu, 03 Aug 2006 18:36:32 +0400
Message-ID: <E1G8eJM-000DH9-00._asr_-inbox-ru@f66.mail.ru>
References: <s5hfygegd7e.wl%tiwai=40suse.de>
Reply-To: Krivenok Dmitry <_asr_@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: =?koi8-r?Q?<s5hfygegd7e.wl%tiwai=40suse.de>?=
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
To: Krivenok Dmitry <_asr_@inbox.ru>
Date: Thu, 03 Aug 2006 15:29:09 +0200
Subject: Re: Re[6]: [Alsa-devel] Virtual sound card

> 
> At Wed, 02 Aug 2006 23:34:30 +0400,
> Krivenok Dmitry wrote:
> > 
> > 
> > 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > To: Krivenok Dmitry <_asr_@inbox.ru>
> > Date: Wed, 02 Aug 2006 20:26:28 +0200
> > Subject: Re: Re[4]: [Alsa-devel] Virtual sound card
> > 
> > > 
> > > At Wed, 02 Aug 2006 21:57:52 +0400,
> > > Krivenok Dmitry wrote:
> > > > 
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Takashi Iwai <tiwai@suse.de>
> > > > To: Krivenok Dmitry <_asr_@inbox.ru>
> > > > Date: Wed, 02 Aug 2006 19:37:46 +0200
> > > > Subject: Re: Re[2]: [Alsa-devel] Virtual sound card
> > > > 
> > > > > 
> > > > > At Wed, 02 Aug 2006 21:31:18 +0400,
> > > > > Krivenok Dmitry wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Takashi Iwai <tiwai@suse.de>
> > > > > > To: Krivenok Dmitry <_asr_@inbox.ru>
> > > > > > Date: Wed, 02 Aug 2006 18:26:52 +0200
> > > > > > Subject: Re: [Alsa-devel] Virtual sound card
> > > > > > 
> > > > > > > 
> > > > > > > At Wed, 02 Aug 2006 16:16:03 +0400,
> > > > > > > Krivenok Dmitry wrote:
> > > > > > > > 
> > > > > > > > Hello All!
> > > > > > > >  
> > > > > > > > What is the simplest way to implement virtual sound card?
> > > > > > > > Special kernel module, which represents virtual device driver? Special plugin? 
> > > > > > > > Or something else?
> > > > > > > 
> > > > > > > How about JACK?
> > > > > > > 
> > > > > > > We have already some alsa-lib plugins, such as file plugin.
> > > > > > > You can record a PCM stream to a file while using another real
> > > > > > > device.
> > > > > > > 
> > > > > > 
> > > > > > Yes, I know about file plugin. 
> > > > > > It works fine with commands like this:
> > > > > > aplay -D file myfile.wav
> > > > > > 
> > > > > > Unfortunately, I don't know how to use it with Skype (new version, which supports ALSA).
> > > > > > Skype supports real cards (e.g. my VIA8233) and virtual cards (e.g. dummy), i.e.
> > > > > > devices with ALSA interface.
> > > > > > But "file" isn't ALSA-device.
> > > > > 
> > > > > So, skype checks only the devices of kernel drivers?  And no way to
> > > > > edit it manually?
> > > > > 
> > > > > Sigh, we really have to provide a good API for the device
> > > > > enumeration.
> > > > > 
> > > > > > How to combine file plugin with alsa-device? Is it possible at all?
> > > > > 
> > > > > It's hackish but possible.  You can override "hw" and/or "plughw"
> > > > > definition as you like, such as
> > > > > 
> > > > > pcm.!hw {
> > > > > 	type file
> > > > > 	slave.pcm {
> > > > > 		type hw
> > > > > 		card 0
> > > > > 	}
> > > > > 	file "foo.out"
> > > > > }
> > > > > 
> > > > 
> > > > This is my asoundrc:
> > > > 
> > > > krivenok-home linux # cat ~/.asoundrc
> > > > pcm.!hw {
> > > >         type file
> > > >         slave.pcm {
> > > >                         type hw
> > > >                         card 0
> > > >         }
> > > >         file "foo.out"
> > > > }
> > > > 
> > > > Attempt to play the file:
> > > > 
> > > > krivenok-home linux # aplay /tmp/pcm.raw
> > > > ALSA lib confmisc.c:670:(snd_func_card_driver) cannot find card '0'
> > > > ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
> > > > ALSA lib confmisc.c:391:(snd_func_concat) error evaluating strings
> > > > ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_concat returned error: No such device
> > > > ALSA lib confmisc.c:1070:(snd_func_refer) error evaluating name
> > > > ALSA lib conf.c:3479:(_snd_config_evaluate) function snd_func_refer returned error: No such device
> > > > ALSA lib conf.c:3947:(snd_config_expand) Evaluate error: No such device
> > > > ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM default
> > > > aplay: main:547: audio open error: No such device
> > > > 
> > > > What is wrong?
> > > 
> > > It should work if you pass '-D hw'.
> > > When -D is omitted, aplay opens "default" PCM.  So, you have to
> > > override this one, too, for example,
> > > 
> > > pcm.!default "hw"
> > > 
> > 
> > Thanks! 
> > Your solution works fine with aplay and mplayer.
> > But it isn't work with Skype :(
> > 
> > In Skype's "Tool->Options->Sound devices" I choose:
> > 1) Audio System to Use = ALSA
> > 2) Audio device = VIA8233
> > Skype works, but foo.out is not created.
> > 
> > I can't understand how Skype works with audio.
> > krivenok-home ~ # strace skype 2>log
> > krivenok-home ~ # cat log | grep snd | wc -l
> > 0
> > krivenok-home ~ # cat log | grep dsp | wc -l
> > 0
> > 
> > There is no ALSA or OSS related system calls (open, etc...)!
> 
> Does it fork or use threads?  Try with strace -f option.
> 

Yes, You are right.

> 
> > This is mplayer's log:
> > krivenok-home ~ # strace mplayer Uno_momento.mp3  2>log2
> > krivenok-home ~ # grep  snd log2
> > open("/dev/snd/controlC0", O_RDWR)      = 5
> > open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 6
> > 
> > OK :)
> > 
> > P.S.
> > Is there a way to use separate files for in/out?
> 
> You can define different PCMs for playback and capture and bind them
> using asym plugin, such as:
> 
> pcm.!hw {
> 	type asym
> 	playback.pcm {
> 		type file
> 		slave.pcm {
> 			type hw
> 			card 0
> 		}
> 		file "foo.out"
> 	}
> 	capture.pcm {
> 		type file
> 		slave.pcm {
> 			type hw
> 			card 0
> 		}
> 		file "foo.in"
> 	}
> }
> 

It works with skype and mplayer, but aplay crashs (SegFault):

krivenok-home ~ # aplay /tmp/12345
Playing WAVE '/tmp/12345' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
Segmentation fault

Tail of strace output is:

write(2, "Playing WAVE \'/tmp/12345\' : ", 28Playing WAVE '/tmp/12345' : ) = 28
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian, ) = 29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Stereo", 6Stereo)                   = 6
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbfe94224)        = 0
ioctl(4, 0xc25c4110, 0xbfe94224)        = 0
ioctl(4, 0xc25c4110, 0xbfe94224)        = 0
ioctl(4, 0xc25c4110, 0xbfe94224)        = 0
write(2, "Warning: rate is not accurate (r"..., 67Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
) = 67
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


It seems to me that the problem is in .asoundrc:
##########################################################
pcm.!hw {
        type asym
        playback.pcm {
                type file
                slave.pcm {
                        type hw
                        card 0
                }
                file "/root/pcm.out"
        }
        capture.pcm {
                type file
                slave.pcm {
                        type hw
                        card 0
                }
                file "/root/pcm.in"
        }
}

pcm.!default "hw"
##########################################################

aplay works fine after removing .asoundrc file.

> 
> Takashi
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
