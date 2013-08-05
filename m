From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Mon, 5 Aug 2013 23:06:39 +0100
Message-ID: <20130805220639.GB26637@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4942481060806263138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E65A626526D
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 00:07:02 +0200 (CEST)
In-Reply-To: <20130805203202.GX23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4942481060806263138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 09:32:02PM +0100, Russell King - ARM Linux wrote:

> which is similar to what's in Liam's driver.  However, There is no
> .dpcm_playback member in mainline ASoC.

OK, that's interesting...  presumably there's some other framework
changes need upstreaming here, I've really not been paying attention to
any out of tree code here.

> So, let's summarise this.  You're saying that I'm doing it all wrong in
> my driver creating those widgets and paths.  Yet, the widgets and paths
> are exactly what Liam creates in his driver.

Including the CPU<->CODEC paths?  Huh, so it seems.  That wasn't
required in any of the previous out of tree DPCM systems I've worked on
in the past.  Something's changed somewhere along the line here...

If those are required they really should be created by the framework in
the same way as we do for CODEC<->CODEC links, it's not at all sensible
to have to supply them twice and like I say it's just asking for problems.

> Not only that, but we have even more duplicated widgets created with this
> method, even with the hack from this patch set.

> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
>   for dai d81247c0 dapm d8263f10 (playback_widget  was   (null), new c05a=
b080)
> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
>   for dai d81247c0 dapm d8263c70 (playback_widget was c05ab080, new d8fe2=
b40)

OK, that's not good. =20

> It seems Liam's commit needs to be reverted to fix that.  Whether that's
> correct or not, I've no idea.

Needs a closer look I think.

> Plus, when I try to set things up as Liam has, the result doesn't work,
> because of the widget naming scheme having no disambiguation.

That's easy enough to sidestep for now.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSACHsAAoJELSic+t+oim9wCwP/iEyriCdYVJwiEbafIh1bkhE
k4KTCu/Dc+8hJ4oqnctS4NWy+pfL1PZ/zNZqEVPvkLQcu3trNdHu7UJM7joFycvy
yl2XFrSv27xNi7myYGWwRbNEBoi2tvKO5xusJMw4TXvGbXRz5+cR+glbipAiZeyA
trjY8Qs1dBAvw+wNfRbZ8SZbvX+ThXDgslvpDMQLuNkVshW9oU4POQlxergAhro6
tYq1A6r+dw5GuiOnoAxK6AvoSbcA5Ue0A7MG2t/gXrq4jJ28lkzC0qX/OTwr9xaf
1cJzfdSidGRPBKwBzbzzhdleWyJ73m9D0W4uLe6urYzguv+uAmZfS8ScrQ6DqpV6
x9DqujTmZy5ik8WIEgE0x6Jn8JvSu4cos+tYzSGCMqhp6n8wc89wTunos+MeqnVl
PP8ItvWvo4EB63q34DKKsQNFh2Tws8Uz++/IJDf827Ai1fyT2iFd+VckWw0MG+oG
7hGxS01rxLxn/JJd0mzvTZu3wUHQdGWFP5G3jmNFMyUNhZ94vZqtaZlEU5cNO8ae
fIX8Pw+fim8PbESTa4C4DqU6aAySBuB8QAilDUUFpKmdui+qfeeUWHJyLpmxsNB2
75L8pdwDcuoTisbJxvOyYwlrOrMQqgTcY5oJ37PWqGR2x4ki15A11Ab4YiA2Uvmg
Do9JzhMEN7i7WODOx4Kz
=KF+7
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

--===============4942481060806263138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4942481060806263138==--
