From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/4] ASoC: Enable dynamic DAIlink insertion &
	removal
Date: Tue, 16 Feb 2016 19:03:16 +0000
Message-ID: <20160216190316.GC7544@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-4-git-send-email-vaibhav.agarwal@linaro.org>
 <20160215170219.GO18988@sirena.org.uk>
 <CANQOkFEK3eF7omO_9m04Y9RhgmwDtO+MVReMSbcc66Hhq0r1ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0374864808933961850=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D348260563
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 20:03:25 +0100 (CET)
In-Reply-To: <CANQOkFEK3eF7omO_9m04Y9RhgmwDtO+MVReMSbcc66Hhq0r1ig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0374864808933961850==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 08:04:23PM +0530, Vaibhav Agarwal wrote:

As I said with regard to your changlogs please leave blank lines between
paragraphs, it makes things much easier to read.

> On 15 February 2016 at 22:32, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Feb 15, 2016 at 05:49:31PM +0530, Vaibhav Agarwal wrote:

> >> +int snd_soc_add_dailink(struct snd_soc_card *card,
> >> +                     struct snd_soc_dai_link *dai_link);
> >> +void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name);

> > Everywhere else we write dai_link.

> Another API snd_soc_add_dai_link() already exists (added by Mengdong).
> How about renaming it to snd_soc_create_dai_link() ?

No.  Think about what you are saying here.  You're having problems
because you're trying to create a new function where the obvious names
collide with existing functions.  This suggests that hacking around with
the naming isn't going to lead to a clear interface or implementation,
users will be confused about what to do and we will most likely have
code duplication in the implementation.  Instead this should be
addressed through looking at the structure of the code.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw3JzAAoJECTWi3JdVIfQsmYH+wRZE1PVti938WX8NRTIKpOZ
2C665VSo+cmLN2Vsxwf+hIvCXjMvGX2r9JizC5P9k4K5Ea/ohWAlv+k634bKr3pd
AblwAJIXKCtLftxz4ytraa4AZOwTLxtfnQcgYvow6YwPnddRPwxiTBQJn2tM1qWl
HbMdNb1jEpn+aaVBx/BVPLO5Hriiaw7npiWhGQ+UeRVIeNjfOLkBdMRqs+Wy7kIw
TuWjV4JpvME31PByFH+PLxIPdu0jnlESD+Pibgp1BGduIGVW7TO5tjZK67573Bpx
UKhYP6HzJril/m7tgxcRM3R7KZMnXmhhjZdoZmeIII79TRxGaGnrsPekPXlrLtE=
=7f2Z
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

--===============0374864808933961850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0374864808933961850==--
