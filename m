From: Michael Buesch <mbuesch@freenet.de>
Subject: Re: [2.6.0-test9 ALSA] ALSA-OSS-emulation unable to register
Date: Mon, 3 Nov 2003 21:06:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311032106.28125.mbuesch@freenet.de>
References: <200311021458.59759.mbuesch@freenet.de> <s5hu15ltgb5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mout1.freenet.de (mout1.freenet.de [194.97.50.132])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA11293
	for <alsa-devel@alsa-project.org>; Mon, 3 Nov 2003 21:06:46 +0100
In-Reply-To: <s5hu15ltgb5.wl@alsa2.suse.de>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 03 November 2003 20:14, you wrote:
> > CONFIG_SOUND_BT878=3Dy
>
>   ^^^^^^^^^^^^^^^^^^^^
> this conflicts with ALSA.  try to pass the index parameter via boot
> option of snd-ens1371.

Thanks for your suggestion, but it doesn't work.
Still displays
ALSA sound/core/oss/pcm_oss.c:2353: unable to register OSS PCM device 0:0
Is there some other way to make bttv-audio and
ALSA-ens1371 working both? Would be cool if I
could use both at the same time. :)

> it's already fixed on the ALSA cvs version.

ok.

> ciao,
>
> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - www.alsa-project.org

=2D --=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/prVDoxoigfggmSgRAm/zAJ9nwkcRvzM2/w2EgYpbSZL0sZxoegCfYDBu
Oq5ZWs+LPXRF0iw3MfyKySI=3D
=3DFg8x
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
