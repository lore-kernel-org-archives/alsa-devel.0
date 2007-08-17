From: Michael Gerdau <mgerdau@tiscali.de>
Subject: Re: Impossible to make subwoofer work on a Dell XPS
	M1710w
Date: Fri, 17 Aug 2007 19:09:36 +0200
Message-ID: <200708171909.49451.mgerdau@tiscali.de>
References: <46C4E23A.5090000@gia.usb.ve>
	<Pine.LNX.4.64.0708162003310.22506@info.physics.ubc.ca>
	<s5hodh6nsev.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0176051178=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodh6nsev.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0176051178==
Content-Type: multipart/signed; boundary="nextPart1381009.nKDXhiQFqt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1381009.nKDXhiQFqt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[crossposting to alsa-devel as adviced in ALSA-Configuration.txt]

> The model option is _the_ important option for HD-audio driver.
> It overrides the configuration preset.  As default, the driver reads
> the PCI (subsystem) IDs to identify which configuration preset to
> use.  If not found, the driver does a guess work from the BIOS setup
> in most cases.
>=20
> Now, since many laptops are shipped with broken BIOS and the guess
> work is imperfect, you often face the famous problem -- "sound
> doesn't work" (great words that explain everything).  Then you can
> pass model option for the preset designed for anohter hardware
> (e.g. model=3Dthinkpad) to make the driver probe as if it's such a=20
> hardware.  If you are lucky, your device is similar with others, and
> the driver works with such a preset.  If not, we'd need to hack
> another preset for matching with your device.
>=20
> The list of available model option is found in
> ALSA-Configuration.txt.

So it seems the Dell XPS M1710 isn't yet listed among the known models
and also does not seem to be detected properly (as of hg20070816).

'lspci -v' gives:
=2E..
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definitio=
n Audio Controller (rev 01)
        Subsystem: Dell Unknown device 01ce
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at efffc000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=
=3D0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
=2E..

'lspci -nv' gives:
=2E..
00:1b.0 Class 0403: 8086:27d8 (rev 01)
        Subsystem: 1028:01ce
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at efffc000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=
=3D0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
=2E..

Anything else I could do to help getting it (fully) supported ?

Best,
Michael
=2D-=20
 Vote against SPAM - see http://www.politik-digital.de/spam/
 !tagline
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver

--nextPart1381009.nKDXhiQFqt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGxdZdUYYhyuxDQc4RApjBAKCIo0dDMsHP5aBvSQ0MHK3vZvu4EgCfQsCp
XAZLrQgeXqUVyROjRhQTRcw=
=Rq7j
-----END PGP SIGNATURE-----

--nextPart1381009.nKDXhiQFqt--


--===============0176051178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0176051178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============0176051178==--
