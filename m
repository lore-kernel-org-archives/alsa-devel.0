From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: rt5645: Check if codec is
 initialized in workqueue handler
Date: Fri, 17 Jul 2015 14:00:35 +0100
Message-ID: <20150717130035.GO11162@sirena.org.uk>
References: <1437100617-37845-1-git-send-email-drinkcat@chromium.org>
 <20150717111208.GK11162@sirena.org.uk>
 <CANMq1KDCa3FsK2xkwYAx_Yx9tn4PCiDRU+SboqMAMb1doqFhtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5896114156873114834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2247F2612DF
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 15:00:47 +0200 (CEST)
In-Reply-To: <CANMq1KDCa3FsK2xkwYAx_Yx9tn4PCiDRU+SboqMAMb1doqFhtA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5896114156873114834==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J4B64LE3ZzGsLqoW"
Content-Disposition: inline


--J4B64LE3ZzGsLqoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2015 at 08:07:50PM +0800, Nicolas Boichat wrote:

> Note that, after you replace the commit in fix/rt5645, and merge
> topic/rt5645, we'll need to remove the return value, as the hunk above

That's already been done.

> will have moved from irq_jack_detection to rt5645_jack_detect_work,
> which returns void (this probably won't appear as an obvious merge
> conflict...).

> I'll provide a patch for that, if you are ok with replacing the commit
> above (otherwise we'll need 2 short patches: one in fix/rt5645, and
> revert it in topic/rt5645).

Yes, please send those patches.

--J4B64LE3ZzGsLqoW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqPxyAAoJECTWi3JdVIfQxsAH/jyeRiNHy80OBd6Cd/ZU0bKv
FDueB45zkDkr/LPHi2G0DewlDRDUnz8SdXUKy20IEzij6w7DrKpSI5VllForVmLG
sxGSXEP9Tg3d5fqm73CmykfbCsWdPBUa6/ICj00MBKJlpBC8v8iEXYU5QjPWdy2s
qVhaPxFvLQy9nMpiXKCjTh0O3XYvWoNEhORuaR+y+8XYpjAIV+/9OfO3BMdxs3r+
Ifwp7Dm2UfXuTQfn1iQT8WupAeNoIjk+vLVG+ECDcnieVw0cuZVlYpYhNcQ55Gmg
pCRmRG5ro3IZ/lyiM2jiL5Qmqkh4n4MoiD3hwZihjF4UFr7HRbeO/wWTn1KU2sU=
=mWA2
-----END PGP SIGNATURE-----

--J4B64LE3ZzGsLqoW--

--===============5896114156873114834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5896114156873114834==--
