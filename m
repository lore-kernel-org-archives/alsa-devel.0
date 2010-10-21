From: Valdis.Kletnieks@vt.edu
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 16:29:17 -0400
Message-ID: <5220.1287692957@localhost>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
	<4CBFEE94.7020103@gmail.com> <s5hlj5sc7do.wl%tiwai@suse.de>
	<4CBFF25C.2080908@gmail.com> <s5hfww0c6oj.wl%tiwai@suse.de>
	<4CC085F5.9070905@gmail.com> <s5heibjxsi4.wl%tiwai@suse.de>
	<4CC092BC.9060504@gmail.com> <s5h8w1rxrl3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8687446720731647954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 135971038D3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 22:29:18 +0200 (CEST)
In-Reply-To: Your message of "Thu, 21 Oct 2010 21:40:08 +0200."
	<s5h8w1rxrl3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, clemens@ladisch.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

--===============8687446720731647954==
Content-Type: multipart/signed; boundary="==_Exmh_1287692957_4908P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1287692957_4908P
Content-Type: text/plain; charset=us-ascii

On Thu, 21 Oct 2010 21:40:08 +0200, Takashi Iwai said:
> > >>>   commit de8c85f7840e5e29629de95f5af24297fb325e0b
> > >>>     ALSA: HDA: Sigmatel: work around incorrect master muting
> > >>
> > >> Reverting this one helps.
> > > 
> > > The latter one?
> > 
> > Yeah. Otherwise I would write it to the former :).

Confirming - reverting that one commit fixes sound on my Dell laptop as
well.

> This might be a user-space issue, then.

That would be icky, if we have to lockstep a 2.6.37 kernel upgrade to
an alsa-lib upgrade.  Stuff like udev and perf having to lockstep is
bad enough...

> Could you try once the latest alsa-lib?  If you are using SUSE packages,
> the snapshot rpms are available on OBS multimedia:audio:snapshot/alsa
> repo.  (The version number of the package is still 1.0.22, but don't
> care; I just forgot to change the spec file.

Hmm... on my laptop, Fedora Rawhide is showing:

% rpm -qi alsa-lib
Name        : alsa-lib                     Relocations: (not relocatable)
Version     : 1.0.23                            Vendor: Fedora Project
Release     : 1.fc14                        Build Date: Fri 16 Apr 2010 07:48:17 AM EDT
Install Date: Sun 18 Apr 2010 03:22:04 PM EDT      Build Host: x86-02.phx2.fedoraproject.org
Group       : System Environment/Libraries   Source RPM: alsa-lib-1.0.23-1.fc14.src.rpm
Size        : 1188301                          License: LGPLv2+
Signature   : (none)
Packager    : Fedora Project
URL         : http://www.alsa-project.org/
Summary     : The Advanced Linux Sound Architecture (ALSA) library
Description :
The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI
functionality to the Linux operating system.

Is that "recent enough", or do I need to find something newer?



--==_Exmh_1287692957_4908P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMwKKdcC3lWbTT17ARAlF/AJ9Ds/YZVkn1C4CvRynOwoA24UyBNQCgsWhp
aEj2r+EBbW6pVz7K4Bzi7xo=
=X41X
-----END PGP SIGNATURE-----

--==_Exmh_1287692957_4908P--

--===============8687446720731647954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8687446720731647954==--
