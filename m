From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Mon, 03 Jun 2002 14:52:57 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CFB0439.8E0367E7@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
		<3CF5B58B.59E5A233@boosthardware.com>
		<s5hwutkhhhj.wl@alsa2.suse.de>
		<3CF74113.46D53687@boosthardware.com>
		<s5hofewhd1u.wl@alsa2.suse.de>
		<s5hk7pkh9pi.wl@alsa2.suse.de>
		<3CF76495.927DAC4C@boosthardware.com> <s5hadqgh1yt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Fri, 31 May 2002 20:55:01 +0900,
> Patrick Shirkey wrote:
> >
> > Takashi Iwai wrote:
> > >
> > > now a new version is cvs.  it dumps the descriptor at
> > > /proc/asound/cardX/descriptor.  if the cvs servers is not sync'ed,
> > > please let me know.  i'll send you a patch.
> > >
> >
> > With this patch there is *alot * more info in lsusb. Excellent work.
> 
> as you already know, it's not me but the update of usb modules :)
> 
> anyway, could you check again whether the driver works?
> just taking a look at the lsusb output, the device has no mixer units.
> there are only input/output terminals.
> so, don't be bothered even if you see no mixer controls.
> 
> Takashi

So far I cannot get sound out using

 cat /bin/bash > dev/dsp2
 aplay -D hw:2,0 -f cd some.wav

both return with device does not exist or similar

The same for recording.

arecord -D hw:2,0 -f cd  -d 10 /art/code/alsa/test.wav
ALSA lib pcm_hw.c:797:(snd_pcm_hw_open) open /dev/snd/pcmC2D0c failed:
No such file or directory
arecord: main:447: audio open error: No such file or directory

---
 ls /dev/snd/
controlC0  controlC3  midiC0D0   pcmC0D1p   pcmC1D0c   
controlC1  controlC4  pcmC0D0c   pcmC0D2c   pcmC1D0p   
controlC2  hwC0D0     pcmC0D0p   pcmC0D2p   timer  
---

Are the pcm devices created by the mixer code? If so then can you use
the descriptor info to hardcode them in?

On a side note I would really like to know how you use the descriptor
info to write a driver. You asked me for the same thing when you were
doing the cmipci driver. It would be a valuable additon to the
developers documentation.

Something like "Using the information provided in /proc/asound to write
a driver". 

If you/Paul/Jaroslav/Abramo or anyone else who grok it could write up
some quick notes I will gladly incorporate them into the online docs.

I am going to write up some info now on the installing the usb-audio
driver and add it to the wiki.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
