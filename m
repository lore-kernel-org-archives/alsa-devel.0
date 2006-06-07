From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 4/8] snd-aoa: add i2sbus
Date: Wed, 07 Jun 2006 14:52:25 +0200
Message-ID: <1149684747.3999.24.camel@johannes>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115847.420788000@sipsolutions.net>
	<s5hr7274ox2.wl%tiwai@suse.de>
	<1149592647.5928.49.camel@johannes.berg> <s5h8xoamliv.wl%tiwai@suse.de>
	<1149680421.3999.4.camel@johannes> <s5hwtbt5ea8.wl%tiwai@suse.de>
	<1149684301.3999.21.camel@johannes>  <s5hslmh5dwl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0427419158=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6ED9B165
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 14:52:46 +0200 (MEST)
In-Reply-To: <s5hslmh5dwl.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0427419158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Z8UKM28oPnESf0mU8gV5"


--=-Z8UKM28oPnESf0mU8gV5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 14:49 +0200, Takashi Iwai wrote:

> Sorry, s/pci_to_dev/snd_dma_pci_data/

So then you're saying that indeed, snd_pcm_lib_preallocate_pages_for_all
has the side effect of setting a pointer somewhere else?

I just don't understand why it all blows up when I leave off the
preallocate call. From the function name that says 'preallocate pages'
it seemed to me that I should be allowed to just leave it off, risking
that later an open() or prepare() fails because no pages could be
allocated.

johannes

--=-Z8UKM28oPnESf0mU8gV5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIbMBqVg1VMiehFYAQIhbA//f2VyHrcy2O3X/p+cplO4YaKu7urMvAvo
nQ55dK8j07omEOqOkJarISd962h4moo5YSGMaCAVNOkr0GJ+ew/7snBK77gJ6Oye
72XPAd0VCj019GI/ur5ERMPvH5qIxJKNK0PdAR+KGlzZIs00Tfdg6zjS9bi5n5Lk
ku3rHdWTv3HUH/Ib7Sc93aAOjmHo4RtWycWRvevhuEFtfKZVE8NO8C2LpA70M+Ss
Gnw8HoBjDsyjFJr6Qe10U3N5tLqR12S25ny8gACmjPlW014jVdjPy36qAwRP4nhO
VS01jt+3hrvOI3vESzE5pRRMNtdCPuZPHfZYE1rTVutr35zxXTyNSVO1juIDkuen
pSbxOSIltpkk954lvS0Ko/eJNw9pp3BoRzZB5lVR1j0k7oSuqRIJx7BPfGIRHJWQ
fUMjeJ66iuXCCyt8bBrVr5zc4UQpFcKNfM3AqTb9lXSWpICVWXZT5ZT2bcVy7F+Z
zfjTzysiPlg64IzkOKf49czeTXehWd8nL2yElAWBDS2ap+JbAluwnH3wArZkLsKb
tzFSjZZwEc7x0GBrFkdfdVLZRVV2TfBmIzyOYZBhgBNrT/7MbjDZmdl0sVKwgURP
InKHu7huQxL50F038+6miWrJlOWZM9FE9RhrpXq+hPfTkNyuW9ekw8uampx6t7Xu
Cj9ry0AhYu8=
=GQox
-----END PGP SIGNATURE-----

--=-Z8UKM28oPnESf0mU8gV5--



--===============0427419158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0427419158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0427419158==--
