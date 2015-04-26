From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 2/7] ASoC: hda: add helper to configure
	module params
Date: Sun, 26 Apr 2015 19:36:59 +0530
Message-ID: <20150426140658.GQ2738@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-3-git-send-email-vinod.koul@intel.com>
 <20150424173830.GB22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8421365126142129828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1D302606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:09:48 +0200 (CEST)
In-Reply-To: <20150424173830.GB22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8421365126142129828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:38:30PM +0100, Mark Brown wrote:
> On Sun, Apr 19, 2015 at 02:27:28AM +0530, Vinod Koul wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > This add helper functions to create module
> > parameter for module IPC msg
>=20
> This feels like it's abstracting between two different driver internal
> formats but it's not entirely clear to me.  I'm lacking some big picture
> stuff here.
Okay, let me try :)

So before this we had posted SKL base PCM driver which was doing HDA stuff
only. Earlier this week you reviewed the SST-IPC driver series, that was
sending IPCs to DSP.
The other series you reviewed with this invokes those IPCs from SKL platform
driver. This series is about DAPM widget handlers and driver changes for
handling DSP.

The SKL supports HDA + DSP and HDA/I2S codecs.

We have one more series which will be missing link. Since we use the
topology/DFW for defining the widgets and map, they are not coded in driver.
That will be sent once topology patches are accepted

Thanks for reviewing the RFCs, I will rework the series and post them in
sequence which would be:
- SKL PCM driver first
- ASoC bus handling wrapper code
- IPC driver
- SKL dapm widget handling and aDSP support
- lastly support for topology to load the DAIs/widgets/map

One more would be ASoC HDA codecs but that can merged independent of these

The core HDA changes are mostly done so that dependency is no longer issue.
Though that code is targeted for next merge window, I think we need to
merge topic/hda from Takashi's tree to yours as well or whatever way you
both feel comfortable..

Do let me know if you have more questions, yes that is a lot of code coming
you way

Thanks
--=20
~Vinod

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPECAAoJEHwUBw8lI4NHBSsQAI2y6lNXHOFSQHhs9DNWIV9h
q25Dev0ZLEqiyB3IZyqcbMUvlYpvox28fe2wuE6WDXTI4pR2mvD29a7szLKXf/GD
Ces56j3DWCdwditeowacDdZ1Mj2adPmP8jLmkEYJzGtaReQb6W/IEht8GdVUZqWe
IjSx6dU9t1ME2MD2UozQJLAu/uhPh2UTwGl42wv9nfKjL50QG7Pf9Ryz6agevdJA
hX/cWDFKwCi5AfL2EF5X3pmMawwKJMKfYXcfhAxn5lzJQcHHGgtnNvR9oKD2K6M9
Rf55kJRBMZ0DZ1qkxt2RysPBJFth47IOsh5HIFKqqJiwCOEDrSVnrMc29fSz/lPY
4lKiX0/TSK0K8qvo+cXkgdGnutqTnZdT578AWFMocqUYNOXHrM/zC01DQIAoQKl7
ESsfO0bCpb2Q9qcyu+G2qq/A8a76rY8qqJxoyBvCsLtaSoX3VlklLpx1ell5d9/8
XmWypPNlN2s4MX2a0aZQqcX8IYp63PDyfRymhJHRiTdT66cXjNCk62CX7kASFzjr
RnVC8MDfPTBuSmQ7oYvVeFDlOpWwHjZsi0MkoL9XJLRXL8gplw013TrMe9l7EqhA
FuLXl54Z02nbnSwiluyRwII/pJYQk3DMPKil5daHYO0EFHR42y7j/lIq99UGLHF+
DOnk5Y9cmnRcfgVaXxsr
=T+C2
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--

--===============8421365126142129828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8421365126142129828==--
