From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ALSA: oxygen: Updating jack
 implementation according new ALSA Jacks
Date: Fri, 26 Jul 2013 23:45:26 +0100
Message-ID: <20130726224526.GA9858@sirena.org.uk>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-5-git-send-email-eu@felipetonello.com>
 <20130726185609.GY9858@sirena.org.uk>
 <CAGrhNMzaBcUb4GHLXr5uR2g4YNSD60vcDpDKQO=S9H2jAx6pgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2236866708658368237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B132658CC
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 00:45:35 +0200 (CEST)
In-Reply-To: <CAGrhNMzaBcUb4GHLXr5uR2g4YNSD60vcDpDKQO=S9H2jAx6pgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============2236866708658368237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wOvCr4+o2vlfoINC"
Content-Disposition: inline


--wOvCr4+o2vlfoINC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2013 at 12:02:51PM -0700, Felipe Tonello wrote:
> On Fri, Jul 26, 2013 at 11:56 AM, Mark Brown <broonie@kernel.org> wrote:

> >>       snd_jack_new(chip->card, "Headphone",
> >> -                  SND_JACK_HEADPHONE, &data->hp_jack);
> >> +                  SND_JACK_HEADPHONE, 0, &data->hp_jack);
> >>       xonar_ds_handle_hp_jack(chip);

> > ...this really ought to be done as part of the commit that adds the
> > parameter since it breaks the build until this patch is applied.

> But that's why is a patch series. But as you say, are you suggesting
> me to propose this changes in one patch only?

This one should be squashed in, as should the part of the ASoC change
that adjusts for the call into the core API.  The general idea with a
patch series is to split things into smaller chunks so they're easier to
understand and review but still keep things working with each change so
that things like git bisect continue to be usable.

So I guess something like one patch that changes the core jack API to
add the index and support jack creation, one to remove the HDA custom
implementation and one to add support for specifying the index to the
ASoC API and adjust all its users.

--wOvCr4+o2vlfoINC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8vwCAAoJELSic+t+oim9UqQP/2L5U1lmSidHrDfBy9VeIqZ5
uiI5rWXHCZBi6gHCLEDHaRl6k62NS0ggYTWOrC9L4LTLY27mzrDjFWPPLm9SjDQW
+ZoGS1bh7PcOPAVClicLDiaraldc81iAVlXdP7sHLOkqOlRMstlJzUVi2oUHHeXI
Cfepp617Ca3N3PchwomCu2kLFKf0fjyQ3DY1nhUW7ishtXwaoKvtoGnc3TwGcLwF
9FXmCGV3U1zumhedU2b2yjgTn7xyXF5qdWwDbohAnC6b92owjwVdPkSsLC0cEfsz
T+gjSs0CnclWHH5FWn16Zhzng8+5TfWjkyWhUTcRvhtFjeZSpZMSDOePnbCn9auz
zqVzkdSo6AQB105ZG5W5e2ry4Ab7zOOfeJKH5FS7Amjbzpkc9xF+WIW/9PCHfEVw
Co+KsTtACrnsYu30s7dHRy3YfiX5r7x1jXkop0FXNG+6GP9nI+yPhn+XSW/+Ht1R
R3rHWz1gP024uH1JTgNowFaAPYl6cjaNcp536xHmSY3tB/IANzX0vQ0CYYBOn4zp
RTIbMAuOGTFynbDpaw7rYK5nA+P5SjVVEyCZAN+TfspMRvUH0lmxVn30L5gHFSlC
QQ/xsWu6FcxHDEMt7p6rMwmlZxBk9PscHCjv7tgJz8XbI9lQ4po0+HsfajAVExmt
F1gioOHIWsxIqz3V4Hbq
=Xx1q
-----END PGP SIGNATURE-----

--wOvCr4+o2vlfoINC--

--===============2236866708658368237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2236866708658368237==--
