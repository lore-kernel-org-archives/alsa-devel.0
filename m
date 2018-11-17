From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dmic: introduce mode switch delay
Date: Fri, 16 Nov 2018 19:11:36 -0800
Message-ID: <20181117031136.GY2089@sirena.org.uk>
References: <1542366609-18861-1-git-send-email-jenny.tc@intel.com>
 <1542366609-18861-2-git-send-email-jenny.tc@intel.com>
 <23d2b1d4-b8c8-9af0-4eb8-3f42a77929bb@perex.cz>
 <2be3f98b-dc65-4a46-44f6-5dbbf1cdb0a2@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8268257903941304909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3C32679C0
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 04:11:50 +0100 (CET)
In-Reply-To: <2be3f98b-dc65-4a46-44f6-5dbbf1cdb0a2@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8268257903941304909==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WUr/cuZz0HKWk6w/"
Content-Disposition: inline


--WUr/cuZz0HKWk6w/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2018 at 08:20:04AM -0600, Pierre-Louis Bossart wrote:

> Indeed. I'd go even further in the nitpicks department and only use the the
> -ms suffix in the property and use a modeswitch_delay field and parameter
> for naming consistency with the existing wake_delay.

> The patches look good otherwise, it's a useful patch to add. Jenny, can you
> do this cosmetic fix and resubmit?

Indeed.  Please also send a patch to update the DT binding (even if
you're using this with ACPI it's also a DT binding):

   Documentation/devicetree/bindings/sound/dmic.txt

--WUr/cuZz0HKWk6w/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvvhucACgkQJNaLcl1U
h9C1lwf/Z+LuiWPVWc+moVIbMlx5ViRFeZLthhE1h60HWX3axvCyOg2bh+NvaZSN
uRjMxsXj7jx1M1CKvWcNqTMfmWaTpaQdWMV7JkahE/l1JiLPK0UDBBXk6CjJJzBX
miQd3ob3mucCRW4/EHlfj8RcdcE7pyUWl/S0mELv+07A4twmE9I0fRKIQTriLAjk
48EOIi7u/cf3CZ31jUlYfrSuFRLztC0WO70SeoZKYr2MorWShxaN9NamWYQmeDqr
0z4odKJ5WjvCm1BOo9fGiC5uIpX4+Kp4xAwmvCPdnjcR8tobAt99Sx2jSWdK+Otx
Y8YkL8a7oIFD/Ofh7wrOAhYXP/EIxw==
=4ge3
-----END PGP SIGNATURE-----

--WUr/cuZz0HKWk6w/--

--===============8268257903941304909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8268257903941304909==--
