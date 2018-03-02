From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Fri, 2 Mar 2018 17:41:11 +0000
Message-ID: <20180302174111.GA3482@sirena.org.uk>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
 <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
 <2ac828b2-04e1-4b5f-f4db-a543ad5e3535@redhat.com>
 <20180302121801.GE6255@sirena.org.uk>
 <bbe1b540-201a-bf6e-9008-0f8d5d4a2a9d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7978703334853146564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B0917267408
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 18:41:21 +0100 (CET)
In-Reply-To: <bbe1b540-201a-bf6e-9008-0f8d5d4a2a9d@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7978703334853146564==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2018 at 01:58:53PM +0100, Hans de Goede wrote:
> On 02-03-18 13:18, Mark Brown wrote:

> > What makes you claim that?  Any board with jack detection wired up will
> > call that function.  Not all boards have that configured of course but
> > there's absolutely nothing Intel specific about that interface.

> Right I'm not claiming the interface is Intel specific, what I'm trying
> to say is that the need for some code outside of the codec driver
> to create the jack means that adding jack-support to DT platforms
> cannot be done through just adding DT properties (once this patch
> is merged), it will still require platform code changes.

On DT the situation with generic drivers is much better than it is on
ACPI so we're actually able to create jacks purely from DT with both the
simple and graph cards.  This was what drove the creation of the generic
jack operation rather than device specific function calls, Bard realized
that the device specific calls were all very similar and adding the call
allowed the generic cards to work with jacks.

> > No, that's really not a good idea.  Any jacks in the system are part of
> > the system specific wiring, they're not something that's intrinsic to
> > the CODEC.  Even with fairly basic setups you've got options like having
> > a headset jack or separate microphone and headphone jacks.

> OK, so if doing the jack creation in the machine-driver / platform
> code is by design and you want to keep things that way, then I
> assume that what needs changing for v3 of this patch is:

> 1) Split the patch in separate codec + machine-drv patches
> 2) Add comments to make the ordering requirements clear to
> both the codec- and machine-driver.

> Correct?

Yes, I think so.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZjLcACgkQJNaLcl1U
h9Cgdgf/SXcy7/OgfxIfUJi3slNV1Atfw7uOgkrH3nIS8T2Uu1QwE+NI3O4Cdcdj
5JSEf3bMpuwYxmizN8y/8vPegZhW5FE4iwmhGjDQKzcIDqN7YCN1sPQst31Lqn74
QbJQvQvbC4vOnSranBpFHsb6eMG30RciJVpdqTqr/sQkYyFLrkJfa5rBhfmmO7Cu
RpjaTFHGlV+UDRlaV2cFeav4W8PrIMuZ1ADF8fBwnjylBtWnVtkxxp1wAuql94Aq
VQjDaABXJl4usiQvAXMqwrrMfY3A5Zs9jLx0VrdRSBe3fQ8Hh9tmWlzgdySP91oi
YHDf4BAw33vEnccTk/2UOWngYgrivQ==
=rWX0
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============7978703334853146564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7978703334853146564==--
