From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/13] ASoC: topology: Able to create BE
	DAIs
Date: Mon, 5 Sep 2016 14:04:44 +0100
Message-ID: <20160905130444.GZ3950@sirena.org.uk>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
 <20160823173354.GZ22076@sirena.org.uk>
 <57BE92E2.7030807@linux.intel.com>
 <20160828141215.GA3950@sirena.org.uk>
 <57C50E9E.3080402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0182888312616104621=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A53FD26657F
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2016 15:05:02 +0200 (CEST)
In-Reply-To: <57C50E9E.3080402@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0182888312616104621==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dy3pjCZLf6+6NySR"
Content-Disposition: inline


--Dy3pjCZLf6+6NySR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 30, 2016 at 12:42:06PM +0800, Mengdong Lin wrote:

> Surely we can create worst case number of DAIs but that would be too much.

> Here is the example of SKL/BXT:
> 6 SSP Ports Rx and Tx, 2 DMIC Ports, 7 Playback DMA channels, 6 Capture DMA
> channels.We are creating topology diagram in text to explain different
> configuration for different use case,like Android, Linux, Chrome and
> Automotive.

That's just 14 back ends by my count (the SSP and DMIC ports) which
seems totally managable?  Even if you include the DMA it's still not an
absurdly large number especially if you compare it to something like the
number of widgets we actively manage in a running CODEC.

--Dy3pjCZLf6+6NySR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzW1sAAoJECTWi3JdVIfQa8IH/ApuKxQYyvp0k0/mj5hMwSuT
9bKwBM3N9Ik6xVrhptpSIwCrVHFPrhJt77D4jxdUqBQCdFStvakkByd4pgGZD//w
Dw94evgBQ70zyYcOEhpK/SKi1tdaI5pynegPLGsP1NvzNv2GBpOe52WZtKW2KJE5
c6lsHlP80KuzkhLgdCWM4oIvUCTz5wC98PusOFEZK0QmzWZ7lroCKBEYyYysEQlv
rkmgCC6LETddMbRXz49QulvISkoz+/aIH+tLsjMCqgyhNIWgg+cPvAdc2VOcU2Pq
ESQXfOvTpxz9nswQZshSfKa8myzYBHa8PiXGf6wZYz+AyRlek1Rc3vPt2dyhQxQ=
=wACf
-----END PGP SIGNATURE-----

--Dy3pjCZLf6+6NySR--

--===============0182888312616104621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0182888312616104621==--
