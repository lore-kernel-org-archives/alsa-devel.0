From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Thu, 30 May 2002 13:12:28 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF5A6AC.A8967313@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
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

This is great but it seems that the cvs server is down :(


Takashi Iwai wrote:
> 
> Hi,
> 
> right now you can find a driver for USB audio on cvs.
> it's in alsa-driver not in alsa-kernel.
> the driver will be built automatically when CONFIG_USB is specified in
> kernel config.
> 
> please note that this driver is EXPERIMENTAL and TENTATIVE.
> my first plan was to implement a USB library layer on alsa-lib, but it
> was found out that implementation of isochronous transfer via
> usbdevfs will bring some difficulty.  so i started coding of a normal
> kernel driver at first.
> if any feasible solution to port such a stuff into user space, we
> should do that.
> 
> but anyway, it's good to have a working code.  we can move it to other
> place later.
> 
> the current code is partly based on OSS/USB audio.c code, but apart
> from the parsing routine of audio-streaming, the resultant codes
> became fairly different from the oss code.
> 
> almost all mixer controls are supported except for graphic equalizer.
> the mapping of topology might not be perfect, since alsa has a plain
> control structure.
> 
> so far, i've tested only audio playback on my speaker, which is
> adaptive out without pitch/freq setting.  xmms is working.
> the driver accepts the period size up to 1ms.  a courageous user can
> try such a heavy condition.  (me?  did not yet :)
> 24bit / 96kHz should work, too, but i have no such a hardware.
> besides, capture is not tested at all.
> 
> if you have a usb audio device, please test once.
> (oh, i forgot to mention the driver name - it's "snd-usb-audio"
>  quite easy, isn't it?)
> 
> if you find somewhat strange behavior (especially in mixer controls),
> please send me the output of lsusb.
> 
> btw, when you use snd-usb-audio module, please make sure that you
> don't load OSS audio.o together.  hotplug likely loads both modules at
> the same time.
> 
> ciao,
> 
> Takashi
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
