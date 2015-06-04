From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/topology 104/105] :undefined reference
 to `snd_soc_dapm_new_control'
Date: Thu, 4 Jun 2015 13:04:18 +0100
Message-ID: <20150604120418.GE14071@sirena.org.uk>
References: <201506041837.OFTVnhYj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6903727714655236478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B99B0266198
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:04:31 +0200 (CEST)
In-Reply-To: <201506041837.OFTVnhYj%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============6903727714655236478==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1NucUmLGa7VWJfBD"
Content-Disposition: inline


--1NucUmLGa7VWJfBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 06:58:38PM +0800, kbuild test robot wrote:

> All error/warnings (new ones prefixed by >>):
>=20
>    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'

The fix for the build bug in your patch exporting this was to add a
static prototype (you were in the CC for that fix) so now the topology
code still doesn't have the export.

Can you send a fixup please?

--1NucUmLGa7VWJfBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcD7BAAoJECTWi3JdVIfQg7wH/21LgTFfm4I1QsAYXHS5dJgq
rpCpiIh68AkKx7hFg/iZMMUsbzSK7Z911IFLsdlJS54Sri7Wzp7F3AZyELzD7pqc
wKRKygDHzOX4HMvBWx8LZD+rDOXHPp1KXZKss9+CsqqmBwdNGhuWJ8J4hOpw/O2q
t2rsVK1GfBR1GMGTnVonpwypYAp2crK6yJ9txM4DlFWQZsceC6YVqyJVnZim/TDW
/CpmUPSSSp2XXetTyrUAYL0+Xg+ZitymUGAhJrq44salz4lrW6B6nAuAKrbavr+n
Hqml8LzI7tSRWvsZ8UybLGCQEV06bFHXJn0wAzNO7d9xBMD/ZpL3tReZeeKRnaY=
=5BXL
-----END PGP SIGNATURE-----

--1NucUmLGa7VWJfBD--

--===============6903727714655236478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6903727714655236478==--
