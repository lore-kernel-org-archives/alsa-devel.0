From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5670: add clock source
	selection controls
Date: Mon, 1 Sep 2014 16:34:33 +0100
Message-ID: <20140901153433.GD29327@sirena.org.uk>
References: <1409549878-27304-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7150470795380153768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB229265451
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 17:34:57 +0200 (CEST)
In-Reply-To: <1409549878-27304-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7150470795380153768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/mZ2nErRHiqrPHn"
Content-Disposition: inline


--0/mZ2nErRHiqrPHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 01:37:58PM +0800, bardliao@realtek.com wrote:

> I write the changelog at the beginning of rt5670.c. But I am not
> sure if it is a regular way to make a changelog.

No, please don't do this - in the kernel we just use git for the
changelog, there's no need for additional changelogs in files.

> +static const char * const rt5670_asrc_clk_source[] = {
> +	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
> +	"clk_i2s3_track", "clk_i2s4_track", "clk_sys2", "clk_sys3",
> +	"clk_sys4", "clk_sys5"
> +};

Every time I see this patch I raise the same concern about the clocking
usually being controlled in the kernel since other clocks are controlled
within the kernel.  I've not seen a response to this yet - it's possible
there is a good reason for putting this under userspace control but you
need to make the case for doing that.

--0/mZ2nErRHiqrPHn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBJIGAAoJELSic+t+oim9lNIP/REueEFIuAGFwmyTTyoBJMew
esEt3S5a84bUqOqMjRFSOzkdGucwjrQ0/SDjAeprXuqWL0fG9teBBNrxzvYMDzyg
90HbBjKxM9Lwsjz2vfLqT8SGvGjfEJ2hJBAdiQPGJYJXI0+tp3RykUFFZcN+Yoal
qbaTQ9QTOR/jSaMzqw10moAavV0MLeMn0DqTiypvndgxXjPgIuulwyh90Y/enNS8
4JkEzyfH0IZiGOwoUcvssgahOr09FZG8bNNA2TJLI3Tjc0W20dguiX93tqQBxdTU
jBltxI3rgsObOtcNzGrMjISd1ptHJEJnx1vgt9KShalzkbDKtmi2V/v9hMl7Tb08
HeH1f5OaEkYlPvY3wFTp1UbTEiLDU4p/Rn67w+j2mdL27PM83w8a2tOdA4nbndAT
o1B8lkGXtMYJ9249SdHoAO/j00kNmGtb6D1MkB1n4BkVB+6GhMC8TzGAQxIRQjCj
DcvhmA4tSMipjsPs1WZykQCwK4HMlmLURqv34JVJ7RYJgPur0h/5PtMZ9/85ggfp
3itPhYB8ssEMkk1eL8X9D33Bd8FKB4B5WzxSKVEpeJtKb34AuexcjHiUnkADR1+o
z3+HAZB7z/eiEZDe4L4AuXWOFo+WE4nQpUN7uS+SuLnyZU2T8lIBnzc78zgwO2zb
IoWWdF7P2wuMhIG9SN+M
=KskQ
-----END PGP SIGNATURE-----

--0/mZ2nErRHiqrPHn--

--===============7150470795380153768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7150470795380153768==--
