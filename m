From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Tue, 17 Aug 2004 10:12:51 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34115.192.168.0.10.1092717771.squirrel@dev.datamax.co.in>
References: <200408171057.i7HAvbv9012682@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408171057.i7HAvbv9012682@www6.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Thanks Peter, for the sugggestions.

>The simplest I think is:
>
> add in trident.h
>
> #ifndef PCI_DEVICE_ID_SI_7019
> #define PCI_DEVICE_ID_SI_7019		0x7019
> #endif
>
> after
>
> #ifndef PCI_DEVICE_ID_SI_7018
> #define PCI_DEVICE_ID_SI_7018		0x7018
> #endif
>
> and change this
> #define TRIDENT_DEVICE_ID_SI7018
> ((PCI_VENDOR_ID_SI<<16)|PCI_DEVICE_ID_SI_7018)
>
> to
> #define TRIDENT_DEVICE_ID_SI7018
> ((PCI_VENDOR_ID_SI<<16)|PCI_DEVICE_ID_SI_7019)
>
> and in trident.c change line
> { 0x1039, 0x7018, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* SiS SI7018
> PCI Audio */
> to
> { 0x1039, 0x7019, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* SiS SI7018
> PCI Audio */
>
> If driver will load it will still print sis7018 (but this is not problem).


I made the changes as specified by you. The configuration options were
--with-cards=dummy,seq-dummy,ad1848,cmipci,trident,als4000 --with-oss=yes
--with-sequencer=yes --with-debug=full --with-kernel=/usr/src/linux

The alsa-driver-1.0.6a package is built and installed successfully.
I made following entry in /etc/modules.conf

alias snd-card-0 snd-trident
alias sound-slot-0 snd-trident

Now when I do modprobe snd-trident, I get following errors

/lib/modules/2.4.18/kernel/sound/acore/snd.o: unresolved symbol
unregister_sound_special
/lib/modules/2.4.18/kernel/sound/acore/snd.o: unresolved symbol
register_sound_special
/lib/modules/2.4.18/kernel/sound/acore/snd.o: insmod
/lib/modules/2.4.18/kernel/sound/acore/snd.o failed
/lib/modules/2.4.18/kernel/sound/acore/snd.o: insmod snd-trident failed

There is no message in syslog, even though I have set debug=full in
configure option.

The AC97 codec chip I am using is AD1881A.

Got any pointer for more debugging?

-vrihad



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
