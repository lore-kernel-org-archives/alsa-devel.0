From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: alsasound init script (Re: possible problems with
 rc6 aplay )
Date: Tue, 24 Dec 2002 02:18:33 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E074569.4050101@boosthardware.com>
References: <E18PTTN-0004YV-00@sc8-sf-list2.sourceforge.net>	<200212202353.13933.plcl@telefonica.net> <s5h3coovohq.wl@alsa2.suse.de>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 20 Dec 2002 23:53:13 +0100,
> Pedro Lopez-Cabanillas wrote:
> 
>>Clemens, I remember that /proc/asound/cards returned this bus/device  
>>information for USB MIDI devices some time ago (rc3?), like it does for my SB 
>>128 PCI.
> 
> 
> it would be nice to provide a new generic proc file which shows the
> low-level hardware information as the card number, the module name and
> the PCI/ISA-PnP/USB/PCMCIA IDs like:
> 
> 0 snd-ens1371 0x0123 0xABCD
> 1 snd-usb-audio 0xXXXX 0xYYYY
> 

Could you add to that the irq number?



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
