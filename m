From: Jeremy Hall <jhall@maoz.com>
Subject: Re: Intel8x0 problems with rc1
Date: Wed, 3 Dec 2003 11:41:23 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312031641.hB3GfNNd012052@sith.maoz.com>
References: <s5hr7zlc2n3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7zlc2n3.wl@alsa2.suse.de> from Takashi Iwai at "Dec 3, 2003
 05:00:32 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

there also appears to be a delay of upwards of 2 seconds before it starts 
playing

but I don't have anything more in my logs.

_J

In the new year, Takashi Iwai wrote:
> At Wed, 03 Dec 2003 15:47:23 +0100,
> Thomas Charbonnel wrote:
> > 
> > Takashi Iwai wrote :
> > 
> > >>Takashi, I applied your patch but nothings shows up in my logs.
> > >>I even replaced all the KERN_DEBUG by KERN_EMERG, and still nothing.
> > >>The only thing I get is this :
> > >>ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x300100]
> > >>ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x56
> > > 
> > > 
> > > and the driver still works somehow?
> > > 
> > > 
> > >>Is it possible that your code never gets called ?
> > > 
> > > 
> > > if the driver works, it must not happen.
> > > 
> > > 
> > > Takashi
> > 
> > Ok, my fault, sorry Takashi, I stupidly reloaded only the snd-intel8x0 
> > module and forgot snd-ac97-codec, here's the log :
> > 
> > ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198
> > setting ac97 reg 0x2c to rate 48000
> > setting ac97 reg 0x2e to rate 48000
> > ALSA ../../alsa-kernel/pci/ac97/ac97_pcm.c:561: error in 
> > snd_ac97_set_rate: cidx=0, reg=0x2e, rate=48000
> > , err=-22<0>ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198
> > 
> > (The file's rate was 44100 kHz)
> 
> didn't you get any messages before this?
> it should be something like
> 
> checking codec 0, slot = 0xxx / 0xxx
> probing pcm 0
>   ....
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
