From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ad1980: fix the indentation
Date: Mon, 9 Sep 2013 16:02:26 +0100
Message-ID: <20130909150226.GG29403@sirena.org.uk>
References: <1378633683-16264-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4454928288461344065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 827B32650C0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:02:32 +0200 (CEST)
In-Reply-To: <1378633683-16264-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============4454928288461344065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0CboPPdgCg0mBjgS"
Content-Disposition: inline


--0CboPPdgCg0mBjgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 08, 2013 at 05:48:03PM +0800, Barry Song wrote:

>  static const struct snd_kcontrol_new ad1980_snd_ac97_controls[] = {
> -SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
> -SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),
> +	SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
> +	SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),

The existing indentation is actually idiomatic for ASoC tables - it
minimises the amount of wrapping within the tables which gets annoying
fast.

--0CboPPdgCg0mBjgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLeL/AAoJELSic+t+oim90AgP/2SSjlZ6AwdBBiRtWvxV+Mwa
+cOhmGqkqgxvEEzk8jaY45NYxzCoyY1YDirwnULv/WjOVRYQ4+ahxrl2QJQFh0Va
htYuPde530KJtMT1vtUJIQ61m25JzdqL90RsHpumY5sqOrGrEG55WHw4bOQ2lUzI
Q+/v2V2/zx3b8LUMWCSn8CfW0bFzXKu8NPMro69HocM9s2Wf89cFu2SgUyK43yqu
csJCButT5dJMoDqm63oJchfU2tSRP6R/zPix1W3BEmN7xxy76Odcpb63RBKyNTtj
nErK3DMATW2RL5Q+OXXCX77uGeWOqq6tpSavtXXlx5WKUTCeoofIrX4KtLXbeGMI
U0zi5dyCQERwe74xFOHVJ8vYjCpzUHv5BZV1wSm1nNnF6Q4JsmWvNecsEWuLVv2K
xgZYEjcQU9q8ydZbj/axRbaLGnvHpXqpXrfIa6ta9vgYNSrS78RaYGo9VHNX4OLC
KrIrD4No7ac1i+djxpNX3Y1sYR4qX1yAqG8v2SqRaGjFLq9Tk8KYin/7g9r2JDDD
xszFgh4yTvO4k/iAOwCzzVWe2OlLl2DlmWFIppXFfx2jmVLxKQ+HzEEkxop0c40O
Mfs1xYCmQK2WoOHXW0diXVw6XQSaT9Fkoi2MrJDUkUAeZB8PKVvL57BZRBhmqXXZ
mKY/YgMcf4d6vjHtKPva
=XsY2
-----END PGP SIGNATURE-----

--0CboPPdgCg0mBjgS--

--===============4454928288461344065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4454928288461344065==--
