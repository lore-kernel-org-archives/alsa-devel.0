From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: current buglets
Date: Thu, 15 Aug 2002 23:39:27 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5BBD1F.6050906@boosthardware.com>
References: <s5hbs84tesw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
> Hi,
> 
> how about to gather the bugs of the current driver and list them as
> known bugs on the web?
> it would be nice to see such things on alsa or wiki's card page,
> so that users can know that you are not alone :)
> 

I have an idea for how to do this nicely. We can have a seperate page 
and also embed them into the alsa-docs. I will get back to you.

> 
> known bugs i know of (and am working on) are:
> 
> OSS emulation
> - Wine OSS (mmap) is not working. (A workaround already known.)
> 
> nm256
> - driver often hangs up at boot time.
> 
> intel8x0
> - driver hangs up at "alsactl restore" on SMP (ICH4 only?)
> - master/master mono mixer elements disappear sometime on ICH4.
> - no 2nd/3rd codec support.
> 
> powermac
> - playback is not audible on screamer until mic-boost is touched.
> 
> opl3sa2
> - on (some?) notebooks, pcm is not audible until pcm mixer is
>   touched. 
> 
> cmi8330
> - is broken.
> 
> trident
> - pcm is not audible on some SIS7012 notebooks.
> 
> ice1712
> - frontbox of TerraTec DMX 6-Fire not working.
> 
> via8233
> - (possible) noises.  (VIA8233A only?)
> 
> usb-audio
> - ambiguous control names on some devices.
> 
> emu10k1
> - MIDI on SB live drive not working properly.
> - wavetable drops notes sometimes.  (a good test example wanted.)
> 
> 
> if you know more bugs, which is reproducable, please let me know.
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
