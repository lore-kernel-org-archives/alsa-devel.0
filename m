From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-via82xx whitelist addition: ASUS A7V8X
Date: Sun, 30 Nov 2003 15:23:31 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031130122331.GB15972@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On the ASUS A7V8X motherboard, the built-in sound works fine with the
full DXS support in snd-via82xx.  Tested with ALSA 0.9.8 and
1.0.0pre3.

Here is the patch to add this motherboard to the whitelist.

BTW, the "ASUS A7V8-X" in the nearby comment probably should be
A7V8X-X (however, I don't own such a board and can't confirm this).

--- alsa-driver-0.9.8/alsa-kernel/pci/via82xx.c.via82xx-whitelist	2003-11-25 12:56:28 +0300
+++ alsa-driver-0.9.8/alsa-kernel/pci/via82xx.c	2003-11-28 22:39:40 +0300
@@ -1961,6 +1961,7 @@
 {
 	static struct dxs_whitelist whitelist[] = {
 		{ .vendor = 0x1019, .device = 0x0996, .action = VIA_DXS_48K },
+		{ .vendor = 0x1043, .device = 0x8095, .action = VIA_DXS_ENABLE }, /* ASUS A7V8X */
 		{ .vendor = 0x1043, .device = 0x80a1, .action = VIA_DXS_NO_VRA }, /* ASUS A7V8-X */
 		{ .vendor = 0x1043, .device = 0x80b0, .action = VIA_DXS_ENABLE }, /* ASUS A7V600 */
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */

Just for information:

$ cat /proc/asound/cards
0 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 at 0xe000, irq 22

$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
SPDIF In Status  : Not Locked

-- 
Sergey Vlasov

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yeFDW82GfkQfsqIRAtwuAJ9kvcA8BPx0L3nviq+puaiFNSdDjgCfUOfU
LWe2GnFR4c4u1/n5pwqVkLc=
=J1Pa
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
