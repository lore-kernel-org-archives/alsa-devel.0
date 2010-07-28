From: Valdis.Kletnieks@vt.edu
Subject: mmotm 2010-07-27 - hda-intel audio fails to initialize
Date: Wed, 28 Jul 2010 18:23:07 -0400
Message-ID: <22094.1280355787@localhost>
References: <201007272226.o6RMQRBm008735@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6390954645989908924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
	by alsa0.perex.cz (Postfix) with ESMTP id C29D0103835
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 00:23:09 +0200 (CEST)
In-Reply-To: Your message of "Tue, 27 Jul 2010 14:56:50 PDT."
	<201007272226.o6RMQRBm008735@imap1.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--===============6390954645989908924==
Content-Type: multipart/signed; boundary="==_Exmh_1280355787_3839P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1280355787_3839P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jul 2010 14:56:50 PDT, akpm@linux-foundation.org said:
> The mm-of-the-moment snapshot 2010-07-27-14-56 has been uploaded to
> 
>    http://userweb.kernel.org/~akpm/mmotm/

Dell Latitude E6500.  Soundcard has gone astray, it appears.

>From 2.6.35-rc3-mmotm0719 dmesg:

[    3.372928] usbcore: registered new interface driver usbhid
[    3.372931] usbhid: USB HID core driver 
[    3.395281] input: Dell WMI hotkeys as /devices/virtual/input/input5
[    3.396477] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    3.433604] input: HDA Intel Mic at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    3.433922] input: HDA Intel Mic at Ext Right Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[    3.434402] input: HDA Intel Line Out at Sep Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    3.434668] input: HDA Intel HP Out at Ext Right Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    3.435552] ALSA device list:
[    3.435554]   #0: HDA Intel at 0xf6fdc000 irq 48
[    3.435588] Netfilter messages via NETLINK v0.30. 
[    3.435608] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)

>From 2.6.35-rc6-mmotm0727:

[    3.065797] usbcore: registered new interface driver usbhid
[    3.065800] usbhid: USB HID core driver
[    3.085379] input: Dell WMI hotkeys as /devices/virtual/input/input5
[    3.086706] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    3.086788] HDA Intel 0000:00:1b.0: irq 48 for MSI/MSI-X
[    3.086841] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    3.095165] ALSA sound/pci/hda/hda_intel.c:1450: no codecs initialized
[    3.095492] HDA Intel 0000:00:1b.0: PCI INT A disabled
[    3.095640] ALSA device list:
[    3.095642]   No soundcards found.
[    3.095676] Netfilter messages via NETLINK v0.30.

Am I hitting a known issue?  If not, what other info would help?


--==_Exmh_1280355787_3839P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMUK3LcC3lWbTT17ARArMZAJ9lOl+isLuSNS5qQM1+QLpgJSWGDwCg+DCr
hJDA0FNGvaH4R4FwvG1Mau8=
=vWE9
-----END PGP SIGNATURE-----

--==_Exmh_1280355787_3839P--


--===============6390954645989908924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6390954645989908924==--
