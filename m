From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Sun, 15 Aug 2004 05:18:48 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <35261.192.168.0.10.1092527328.squirrel@dev.datamax.co.in>
References: <1709.192.168.0.30.1092440735.squirrel@dev.datamax.co.in><Pine.HPX.4.3
     3n.0408161131450.27899-100000@studcom.urz.uni-halle.de><3524.192.168.0
     .30.1092454251.squirrel@dev.datamax.co.in>
     <s5h3c2nb542.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c2nb542.wl@alsa2.suse.de>
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

Hi!

Thanks for the quick response.

> The question is whether SIS7019 is an AC97 chip, or it's the one to
> control other AC97 chips.  If it's former, you should have another PCI
> entry for the controller (check lspci).  In the latter case, you can
> try snd-trident module with changes of pci id table from SIS7018 to
> SIS7019.

SiS7019 controls other AC97 chips. The board which we have designed
uses Real Tech's ALC202A (four channel) and ALC650 (six channel).
Now what should I change in
.../alsa-driver-1.0.0rc2/alsa-kernel/pci/trident/trident.c?
I see following entries with SiS7018 mentioned:

<snip>

MODULE_DESCRIPTION("Trident 4D-WaveDX/NX & SiS SI7018");

<snip>

MODULE_DEVICES("{{Trident,4DWave DX},"
                "{Trident,4DWave NX},"
                "{SiS,SI7018 PCI Audio},"
                "{Best Union,Miss Melody 4DWave PCI},"
                "{HIS,4DWave PCI},"
                "{Warpspeed,ONSpeed 4DWave PCI},"
                "{Aztech Systems,PCI 64-Q3D},"
                "{Addonics,SV 750},"
                "{CHIC,True Sound 4Dwave},"
                "{Shark,Predator4D-PCI},"
                "{Jaton,SonicWave 4D},"
                "{Hoontech,SoundTrack Digital 4DWave NX}}");

<snip>

static struct pci_device_id snd_trident_ids[] = {
        { 0x1023, 0x2000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* Trident
4DWave DX PCI Audio */
        { 0x1023, 0x2001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* Trident
4DWave NX PCI Audio */
        { 0x1039, 0x7018, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },   /* SiS
SI7018 PCI Audio */
        { 0, }
};

<snip>

There are few more instances where related data structures are used
in the code. In the declarations shown above, what changes should I
make? Will changing the name part from 7018 to 7019 will be enough?

Thanks.

-vrihad



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
