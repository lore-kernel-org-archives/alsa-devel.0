From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Sat, 1 Aug 2015 18:20:58 +0530
Message-ID: <20150801125058.GK29916@localhost>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
 <20150729175631.GK11162@sirena.org.uk>
 <20150730031507.GI29916@localhost>
 <20150730190104.GA20873@sirena.org.uk>
 <20150731045350.GJ29916@localhost>
 <20150731180925.GL20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5913336323530403931=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B8F9261507
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 14:49:11 +0200 (CEST)
In-Reply-To: <20150731180925.GL20873@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5913336323530403931==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 07:09:25PM +0100, Mark Brown wrote:
> On Fri, Jul 31, 2015 at 10:23:50AM +0530, Vinod Koul wrote:
> > On Thu, Jul 30, 2015 at 08:01:04PM +0100, Mark Brown wrote:
> > > On Thu, Jul 30, 2015 at 08:45:07AM +0530, Vinod Koul wrote:
>=20
> > > | This series adds NHLT table support in the driver. This also adds s=
upport
> > > | for dsp init, modules configuration and messaging support
>=20
> One issue I should probably highlight is - what is a NHLT table and has
> is it documented (I guess it is part of some part of some ACPI spec
> given my understanding of the rules on publication of ACPI bindings).
So by default, SKL BIOS has a new ACPI Table called NHLT, Non
HDA-Link Table. This table contains the settings the driver has to pick up
for the non HDA links (SSP, PDM) and send them to firmware for applying.

The firmware expects it in the same format as stored in the BIOS so we just
query the 'endpoint' blob and send it to FW when that BE is enabled from
DPCM. These contain the hardware register settings that are required for
that 'board' and also the DMA gateway settings. All these are taken up by FW
and applied for that link. We are reusing infrastructure made for other OSes
here and will help us when someone installs Linux on SKL devices we always
get the link settings which have been already tested.

> > On your questions above, one thing I would like to point that typically=
 we
> > have alsa controls and dapm widgets to model the DSP, but now with topo=
logy
> > core, we have moved these into the usermode.
>=20
> I'm not sure how that's relevant?
>=20
> > In driver we have handlers for the topology events, so yes it becomes l=
ittle
> > difficult to visualize but we can do better by adding comments.
> > This series is mostly helper code for getting topology created in DSP a=
nd
> > next (last series in current SKL driver work) series will add topology
> > handlers which will use these helpers, so the big picture will be clear
> > easily and complete flow can be visualized when these helpers are invok=
ed.
>=20
> Right, but you're sending all this stuff piecemeal with no advance
> explanation of where we're going.  This is a recurring problem here -
> there's lots of Intel specific abstraction layers which aren't terribly
> clear and some of which seem to turn out to be redundant on review.
The piecemeal approach was required to manage and split the traffic. This
series adds the handlers on how send bind and unbind messages, pin
management routines, how driver compute PCM params when we have a 'converter
widget' like SRC, channel converter etc
Next series will add the topology handler which will use these. Okay need to
create a pipeline so call module init, bind, calculate pcm params, apply
them etc
I will try my best to add more clarity to updated patchset (holding that up
and rereading to see if I can add more comments to help) and pls do ask
where you feel where stuff is ambiguous

--=20
~Vinod


--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvMCyAAoJEHwUBw8lI4NHBooP+wUUOtnP9FbofQ9z+f5+477y
BzTzkZXaoddZYCkK+t+1fSoHjyXOGJ+7Wm4+HzJwXz2HHzixHjcueW+wr4CmxGNd
HxFfLkXFw+QOY5pK76uh8GD3cDwq9tWqprtWIMNoZk7M1/pNU4TVeZvYRkDlD/Yr
vGpuDADozpwZnjLVkEcogJbRt/ItWyRdW+Kz7ic+CaVNT/pEJiHHhpF4wUc9TxWQ
tCAUg3LroULNzjrFwdkgOBHqOLLLZj4Z52vFTwObKTJiyOwJiH9zbVPIQw9I/+KH
5osk7jLyMqGAM3jHqSEF4L1zGkqgsYbi8niaabwgU8hiRwrnC+8/c+Mpt+JWtr2B
jGQsosd/UEWO7WvrPy/+jD1NXIYzJKBZWYauLYzmR7VOeFHwT0rAi5IjrMEkqIUQ
pw6Kr2Ys2n8ngdioORmCpo5+KWecWr87Mu7AP+P5pxiJNwhZ5EwBt73VuyWylcYj
13fDAwo4pK0LNIdFsvHeatpuT57SrDH+x465ShocXlYcG7X+cQcH0jxrwcGzO9dY
OCPTutSZWOHqD7ZNnt48odVpbjrY3IzHMRTvQFXBAtLjl2GuP30xvDrVDNCugge6
rf5fhTGBHFNm2YIUltbkg39wHnxXZq4+SItgk7gdCFtxNIHY+d7ZWhcPkYmj2WXL
lZnBdft1KTqdQhFVmzuJ
=yRmj
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--

--===============5913336323530403931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913336323530403931==--
