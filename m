From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Tue, 17 Aug 2004 10:27:29 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34263.192.168.0.10.1092718649.squirrel@dev.datamax.co.in>
References: <1709.192.168.0.30.1092440735.squirrel@dev.datamax.co.in>
     <s5h4qn29k9w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qn29k9w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Thanks Takashi for the suggestions. But it is not working.

> No, just change snd_trident_ids[] entry for 7018 to 7019's one (maybe
> 0x7019?).  Also, in trident_main.c, you need to change the line 3546
>
> 	trident->device = (pci->vendor << 16) | pci->device;
>
> to
> 	trident->device = TRIDENT_DEVICE_ID_SI7018;
>
> You can leave MODULE_* stuffs as they are.

I made the changes as mentioned above. I am using alsa-driver-1.0.6a
on a board with sis7019 along with AD1881A. The configuration options
were
--with-cards=dummy,seq-dummy,ad1848,cmipci,trident,als4000 --with-oss=yes
--with-sequencer=yes --with-debug=full --with-kernel=/usr/src/linux

The entry in modules.conf is
alias snd-card-0 snd-trident
alias sound-slot-0 snd-trident

When I did modprobe snd-trident, I got following messages in syslog

Aug 18 15:56:15 stb kernel: PCI: Found IRQ 10 for device 00:01.4
Aug 18 15:56:16 stb kernel: ALSA
../../alsa-kernel/pci/trident/trident_main.c:3241: AC'97 codec ready e
rror [0x0]
Aug 18 15:56:20 stb last message repeated 2 times
Aug 18 15:56:21 stb kernel: ALSA
../../alsa-kernel/pci/ac97/ac97_codec.c:1904: AC'97 0 does not respond
 - RESET
Aug 18 15:56:21 stb kernel: ALSA
../../alsa-kernel/pci/ac97/ac97_codec.c:1912: AC'97 0 access is not va
lid [0x0], removing mixer.
Aug 18 15:56:21 stb kernel: ALSA
../../alsa-kernel/pci/trident/trident_main.c:3241: AC'97 codec ready e
rror [0x0]
Aug 18 15:56:25 stb last message repeated 2 times




Does alsa framework need a working driver for AD1881A too which is
the codec I am using right now? Since I don't have much knowledge
about the way the AC97 controller and codec functions, this question
may be stupid.

Thanks for the help.

-vrihad



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
