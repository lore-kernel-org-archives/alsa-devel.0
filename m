From: Paul Brossier <piem-lists-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Re: Tascam USB 122 thingy
Date: Wed, 07 Jan 2004 03:21:43 +0000
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <1073445703.23203.51.camel@bastille>
References: <Pine.HPX.4.33n.0309260825560.4970-100000@studcom.urz.uni-halle.de>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <Pine.HPX.4.33n.0309260825560.4970-100000-uTWBjZk67LHpX0crx97Rjzs8JdKFpwrh@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

the tascam 122 is now reported to work on linux.
http://www.langerland.de/us122/index.html

according the thread you mention below, the drivers snd-usb-us428 and
snd-usb-us122 are now merged into snd-usb-usx2y (in alsa 1.0.0-rc2).

i managed to load snd-usb-usx2y, load the firmware in the card, and
create the alsa devices, but still got that same errors
(SNDRV_PCM_IOCTL_HW_PARAMS failed).

some threads i found :
http://www.mail-archive.com/alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg09840.html
http://www.mail-archive.com/alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg10408.html

the error i got was very similar to this :

.ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Operation not permitted
ACCESS: MMAP_NONINTERLEAVED
FORMAT: S32_LE
SUBFORMAT: STD
SAMPLE_BITS: 32
FRAME_BITS: 448
CHANNELS: 14
RATE: NONE
PERIOD_TIME: (85333 85334)
PERIOD_SIZE: 8192
PERIOD_BYTES: 458752
PERIODS: 2
BUFFER_TIME: (170666 170667)
BUFFER_SIZE: 16384
BUFFER_BYTES: 917504
TICK_TIME: 10000

has anyone go any further than that ?

greetings, piem

On Fri, 2003-09-26 at 07:42, Clemens Ladisch wrote:
> Andy Cragg wrote:
> 
> > Clemens Ladisch wrote:
> >
> > >Andy Cragg wrote:
> > >
> > >>Anyone know if the new Tascam US-122 USB audio/midi soundcard is
> > >>supported by the generic USB drivers in Alsa?
> > >
> > >I've heard that it works if you use the loader from
> > ><http://usb-midi-fw.sourceforge.net/>.
> >
> > Thanks for that - looks like I'll have to go out and get one now ...
> 
> It seems what I said was wrong. :-( According to the thread at
> <http://www.mail-archive.com/alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg09292.html>,
> it doesn't work.
> 
> Please ask Martin before buying anything; he's the only one who knows
> if it will work with the current ALSA drivers.
> 
> 
> Regards,
> Clemens
> 
> 
> 
