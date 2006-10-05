From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.19-rc1: hda_intel: azx_get_response timeout,
	switching to polling mode...
Date: Thu, 5 Oct 2006 23:11:35 +0200
Message-ID: <200610052311.35446.prakash@punnoor.de>
References: <200610050954.57677.prakash@punnoor.de>
	<s5hr6xnoykt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0043676619=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 495E4171
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 23:11:42 +0200 (MEST)
In-Reply-To: <s5hr6xnoykt.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============0043676619==
Content-Type: multipart/signed; boundary="nextPart1603768.TI8Bz8LKgq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1603768.TI8Bz8LKgq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 05 Oktober 2006 12:18 schrieb Takashi Iwai:
> At Thu, 5 Oct 2006 09:54:57 +0200,
> Prakash Punnoor wrote:
> > I didn't get above message with 2.6.18. Usign irqpoll above message
> > doesn't appear, but I think neither it optimal.
>
> The latest snd-hda-intel driver uses MSI as default.
> Pass disable_msi=3D1 module option and see whether it works.

Yes, no more message, but what is even better: My nforce nic works again (w=
/o=20
using irqpoll)! So the alsa driver broke it. Now both are using same irq an=
d=20
peaceful again. (Though Alsa still reports that no soundcard was detetcted.)

           CPU0       CPU1
  0:      53826          0   IO-APIC-edge     timer
  1:         66          0   IO-APIC-edge     i8042
  7:          0          0   IO-APIC-edge     parport0
  8:          0          0   IO-APIC-edge     rtc
  9:          0          0   IO-APIC-fasteoi  acpi
 12:       1650          0   IO-APIC-edge     i8042
 14:         63          0   IO-APIC-edge     ide0
 16:       2095          0   IO-APIC-fasteoi  nvidia
 19:          6          0   IO-APIC-fasteoi  ohci1394
 20:          0          0   IO-APIC-fasteoi  ohci_hcd:usb1
 21:         66          0   IO-APIC-fasteoi  ehci_hcd:usb2
 22:       5652          0   IO-APIC-fasteoi  libata
 23:       5105          0   IO-APIC-fasteoi  HDA Intel, eth0
NMI:        155         75
LOC:      53715  =20
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1603768.TI8Bz8LKgq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJXUHxU2n/+9+t5gRAiqyAKDCcF9mLM4xlxUdzcA9JC8XJwi+fwCg7opF
t1wFv2NXj2zIXcJIwsE1UGQ=
=NYAN
-----END PGP SIGNATURE-----

--nextPart1603768.TI8Bz8LKgq--


--===============0043676619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0043676619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0043676619==--
