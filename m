From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: snd-usb-audio and snd-virmidi problems
Date: Sun, 11 Dec 2005 12:05:00 +0300
Message-ID: <20051211090500.GA11694@procyon.home>
References: <20051210181029.2135.qmail@web33012.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051210181029.2135.qmail@web33012.mail.mud.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Murphy <typetosmurky@yahoo.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2005 at 01:10:29PM -0500, Jonathan Murphy wrote:
[skip]
>  Oops: 0000 [#1]
>  PREEMPT=20
>  Modules linked in: snd_virmidi snd_seq_virmidi snd_rawmidi snd_seq_midi_=
event snd_seq snd_seq_device snd_ali5451 snd_ac97_codec snd_ac97_bus snd_pc=
m snd_timer snd snd_page_alloc
>  CPU:    0
>  EIP:    0060:[<00000000>]    Not tainted VLI
>  EFLAGS: 00010282   (2.6.12.5)=20
>  EIP is at stext+0x3feffdd8/0x8
>  eax: f6fa7780   ebx: f88b5874   ecx: 00000000   edx: f88b5874
>  esi: f6fa7788   edi: c04848a0   ebp: f6fa77ac   esp: f1801e8c
>  ds: 007b   es: 007b   ss: 0068
>  Process modprobe (pid: 3748, threadinfo=3Df1800000 task=3Df4b24a20)
>  Stack: c02a7640 f6fa7780 f88b5874 f88b58a4 f6fa7788 c02a76da f88b5874 f6=
fa7788=20
>         c02301f4 c048486c f6fa7788 f6fa7788 c0484840 c02a797c f6fa7788 c0=
2aab93=20
>         f6fa7788 f6fa7788 f6fa77e0 00000000 c02a6a12 f6fa7788 00000001 f6=
fa77e0=20
>  Call Trace:
>   [<c02a7640>] driver_probe_device+0x29/0x64
>   [<c02a76da>] device_attach+0x5f/0xaa
>   [<c02301f4>] kobject_get+0x17/0x1e
>   [<c02a797c>] bus_add_device+0x56/0xb7
>   [<c02aab93>] device_pm_add+0x56/0x8b
>   [<c02a6a12>] device_add+0xca/0x14f
>   [<c02a9190>] platform_device_register+0x13f/0x186
>   [<f88a9766>] snd_generic_device_register+0x5c/0xa3 [snd]
>   [<f88a97f0>] snd_card_set_generic_dev+0x10/0x3b [snd]
>   [<f888d13b>] snd_card_virmidi_probe+0x13b/0x1ac [snd_virmidi]
>   [<f888d1c5>] alsa_card_virmidi_init+0x19/0x59 [snd_virmidi]
>   [<c0133c66>] sys_init_module+0xc0/0x1fc
>   [<c0102f0f>] sysenter_past_esp+0x54/0x75
>  Code:  Bad EIP value.

Not sure about your first problem (undefined symbols), but this oops
looks similar to the one described in the bug #1623:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1623

Please try the patch attached to that report - it should fix the oops.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDm+u8W82GfkQfsqIRAsXoAJ91e04mX0zvGrbwB2uRCqhbkJIEnACdEwzL
A9oRY/wTks/AwrF61KAJhYA=
=26bZ
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
