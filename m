From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio - assertion
Date: Fri, 05 Jul 2002 23:24:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D25AC06.1040607@boosthardware.com>
References: <3D259655.9090604@iptime.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?ISO-8859-1?Q?tapio_laxstr=F6m?= <tapio@iptime.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

tapio laxström wrote:
> Hi!
> 
> Seems like USB Audio driver doesn't want to be on /dev/mixer0 ;)

Possibly your card doesn't have mixer properties. The quattro doesn't. I 
don't know exactly how to get round that with xmms though. You could try 
the native alsa plugin available from their site.


> (ecasound thru /dev/dsp0 works fine but xmms, which wants to use mixer, 
> fails).
> 
> I didn't check the code; is it just buggy assertion or something else?
> 
> Current cvs version seems to work fine with my Emagic EMI 2|6 (on 
> /dev/dsp1).
> 
> ---clip---
> [root@zappa asound]# insmod snd-usb-audio ; insmod snd-maestro3
> Using /lib/modules/2.4.19-pre8/kernel/sound/usb/snd-usb-audio.o
> Using /lib/modules/2.4.19-pre8/kernel/sound/pci/snd-maestro3.o
> [root@zappa asound]# cat cards
> 0 [card0          ]: USB-Audio - USB Audio Driver
>                      EMAGIC GmbH Emagic EMI 2|6
> 1 [card1          ]: Allegro - ESS Allegro PCI
>                      ESS Allegro PCI at 0x1400, irq 5
> [root@zappa asound]# xmms
> xmms: simple.c:1376: snd_mixer_selem_get_playback_volume: Assertion 
> `(unsigned int) channel < s->str[0].channels' failed.
> Aborted
> [root@zappa asound]# rmmod snd-usb-audio ; rmmod snd-maestro3
> [root@zappa asound]# insmod snd-maestro3 ; insmod snd-usb-audio
> Using /lib/modules/2.4.19-pre8/kernel/sound/pci/snd-maestro3.o
> Using /lib/modules/2.4.19-pre8/kernel/sound/usb/snd-usb-audio.o
> [root@zappa asound]# xmms
> [root@zappa asound]# cat cards
> 0 [card0          ]: Allegro - ESS Allegro PCI
>                      ESS Allegro PCI at 0x1400, irq 5
> 1 [card1          ]: USB-Audio - USB Audio Driver
>                      EMAGIC GmbH Emagic EMI 2|6
> 
> 
> -- 
> best regards
> -- 
> tapio laxström
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Bringing you mounds of caffeinated joy.
> http://thinkgeek.com/sf
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
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
