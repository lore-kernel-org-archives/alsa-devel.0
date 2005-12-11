From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: snd-es1968 (+ snd-cs4236) trouble
Date: Sun, 11 Dec 2005 12:08:48 +0300
Message-ID: <20051211090848.GB11694@procyon.home>
References: <439B36E0.3090709@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from master.altlinux.org (master.altlinux.org [62.118.250.235])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0310E16A
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2005 10:08:58 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <439B36E0.3090709@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2005 at 09:13:20PM +0100, Rene Herman wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
>  printing eip:
> 00000000
> *pde =3D 00000000
> Oops: 0000 [#1]
> PREEMPT=20
> Modules linked in: snd_cs4236 snd_opl3_lib snd_hwdep snd_cs4236_lib snd_m=
pu401_uart snd_rawmidi snd_seq_device snd_cs4231_lib snd_pcm snd_timer snd =
soundcore snd_page_alloc nfsd exportfs lockd sunrpc nls_iso8859_1 nls_cp437=
 vfat fat nls_base
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.14.3-local-wc)=20
> EIP is at 0x0
> eax: ef2daa14   ebx: ef2daa1c   ecx: 00000008   edx: f094a494
> esi: 00000000   edi: f094a494   ebp: c01b30e8   esp: ee8c2e3c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1516, threadinfo=3Dee8c2000 task=3Def113a90)
> Stack: f093f00c c01b3097 ee8c2e54 00000000 ef2daa1c c01b2a75 c0299458 c02=
99458=20
>        f094a4ec c016d676 ef2daa1c ef2daa1c c0299360 00000000 c01b3127 c01=
b30e8=20
>        ef2daa84 c01b2b77 ef2daa84 ef2daa1c ef2daac6 00000000 c01b2022 c02=
99240=20
> Call Trace:
>  [<f093f00c>] snd_platform_driver_probe+0xc/0xd [snd]
>  [<c01b3097>] driver_probe_device+0x31/0x82
>  [<c01b2a75>] bus_for_each_drv+0x35/0x59
>  [<c016d676>] create_files+0x27/0x51
>  [<c01b3127>] device_attach+0x3a/0x4d
>  [<c01b30e8>] __device_attach+0x0/0x5
>  [<c01b2b77>] bus_add_device+0x20/0x6f
>  [<c01b2022>] device_add+0x97/0xf8
>  [<c01b41d9>] platform_device_register+0xb5/0x103
>  [<f08f7995>] snd_cs4231_pm_suspend+0x0/0x15 [snd_cs4231_lib]
>  [<f09404b2>] snd_generic_device_register+0x64/0x81 [snd]
>  [<f08f79aa>] snd_cs4231_pm_resume+0x0/0x15 [snd_cs4231_lib]
>  [<f0940682>] snd_card_set_generic_pm_callback+0x13/0x2f [snd]
>  [<f08f7e63>] snd_cs4231_create+0x28a/0x29e [snd_cs4231_lib]
>  [<f09593a2>] snd_cs4236_create+0x70/0x2b1 [snd_cs4236_lib]
>  [<f09784e6>] snd_card_cs423x_probe+0x14c/0x30c [snd_cs4236]
>  [<f09786d0>] snd_cs423x_pnp_detect+0x2a/0x4c [snd_cs4236]
>  [<c0192e39>] card_probe+0x3b/0x85
>  [<c01933f0>] pnp_register_card_driver+0x7a/0x86
>  [<f08e103d>] alsa_card_cs423x_init+0x3d/0x62 [snd_cs4236]
>  [<c0126e59>] sys_init_module+0xae/0x1a5
>  [<c01024d1>] syscall_call+0x7/0xb
> Code:  Bad EIP value.

This also looks like the bug #1623:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1623

Please try the patch attached to that bugreport.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDm+ygW82GfkQfsqIRAnXLAJ9lGEEFZfPupWIsg/hWcwdP+s41lwCfaGLs
fJtXr7Ttm06T1uM/gxsuHsg=
=+eJl
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
