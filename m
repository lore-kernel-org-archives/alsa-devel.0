From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#536896: linux-image-2.6.26-2-amd64: audio popping with gstreamer using apps when using amd64 kernel and i386 userspace
Date: Mon, 12 Apr 2010 21:18:49 +0100
Message-ID: <1271103529.6179.325.camel@localhost>
References: <20090714135754.4684.74223.reportbug@zarvora>
	 <20100225183435.GA8488@galadriel.inutil.org>
	 <alpine.DEB.1.10.1004120102110.24942@martello.ucc.gu.uwa.edu.au>
	 <1271017516.6179.126.camel@localhost>  <s5h633xb079.wl%tiwai@suse.de>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 536896@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1Fm7BBt/QIaMRq0Y2HpY"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.536896.B536896.12711035537658@bugs.debian.org>
In-Reply-To: <s5h633xb079.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Andrewartha <trs80@ucc.gu.uwa.edu.au>, Jaroslav Kysela <perex@perex.cz>, 536896@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-1Fm7BBt/QIaMRq0Y2HpY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-04-12 at 09:26 +0200, Takashi Iwai wrote:
> At Sun, 11 Apr 2010 21:25:16 +0100,
> Ben Hutchings wrote:
> >=20
> > [1  <text/plain; UTF-8 (quoted-printable)>]
> > [Earlier messages can be found at http://bugs.debian.org/536896 ]
> >=20
> > On Mon, 2010-04-12 at 01:08 +0800, James Andrewartha wrote:
[...]
> > > Author: Takashi Iwai <tiwai@suse.de>  2008-01-09 02:08:14
> > > Committer: Jaroslav Kysela <perex@perex.cz>  2008-02-01 01:29:47
> > > Parent: d948035a928400ae127c873fbf771389bee18949 ([ALSA] Remove PCM x=
fer_align sw params)
> > >=20
> > >     [ALSA] PCM - clean up snd_pcm_lib_read/write
> > >    =20
> > >     Introduce a common helper function for snd_pcm_lib_read and snd_p=
cm_lib_write
> > >     for cleaning up the code.
> > >    =20
> > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > >     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> > >=20
> > > I don't know anything about this code, but I'm happy to deal with ups=
tream=20
> > > if you'd prefer me to.
> >=20
> > The above commit is supposed to be cleanup, but it has at least one
> > semantic change: snd_pcm_mmap_control::avail_min no longer applies to
> > non-blocking file handles.  I don't know whether this is was an
> > intentional or unintentional change, but it wasn't commented.  I also
> > don't know whether this can explain the popping, but I expect that it
> > has changed the timing of audio I/O.
>=20
> The above change is essentially a fix of the buggy behavior for
> non-blocking access.  avail_min is the definition for wake-up
> behavior, and it doesn't define the blocking behavior.
> But, it's possible that this changes the timing, indeed.  If so, it
> implies that the app expects somehow wrongly.

Thanks for your quick response.  I will reassign this bug to the
applications that were mentioned.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-1Fm7BBt/QIaMRq0Y2HpY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS8OAJ+e/yOyVhhEJAQIBSA/7Boxj94x2GHBypkL5c9dNB9wQcil6GUnN
L5tQ7Nk2eaK8ZgvImYBzMgWx6MrqvcrW4Gz2wSP2h2ZFC/BGS8s3A/lDRQ+ScfdO
XwhBK2Aqkfpnu2t5qfoHnq3N774T1pKaclVJ6orOjQlqpF6lglEoTvoBErEdv2UQ
rAqjdFSHuk5dxLkKA28FkatS4vIHfzWa1LSMotFKjjaanxSp4z6SOzwO5qeA409S
s8oQz2XNPmQO/Z8KfwebkoXCO1IF+h2u9mgIcHP76mnw3xTRC571UuL5K78d6kva
m1zstyIjhciTA5UCY12hw2aeYfMVuFfbxUu61dwskpS/162Yq4qPGBXjtxAaVfIM
rgG/PMeU7B+No/EuhXrwWJo+kHFsY47Qtw0h9Sfdk74ddvmIhOtQ3YN0AkL4Ntgb
7Ez459A6Z1miciJOPyI95QeZ6eBTFkSkVRKaCUlHNAWgAHe0/ZYTt2vBSVqwELcC
70+ucIynen9R3msqzOD2pPyyEG8PsVuO2xtRM2BjDuuKv25EF3RPuqfRd+cmcC0R
wfHAZsTR/eqsb89k4qBqwecWABgCBu2PQ8prCoBzMIFW7+vrGNKwrJWXD0ZQDhou
Fa9tpFT4V5VHItlwk+6hcOYLy8CwnmnAnUk/ev81KZDpobaQfEwyBEMswyO9LPa4
Ii/P5hwu+wg=
=kDPY
-----END PGP SIGNATURE-----

--=-1Fm7BBt/QIaMRq0Y2HpY--
