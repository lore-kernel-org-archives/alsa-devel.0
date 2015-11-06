From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
 make sure the speaker volume adjust properly
Date: Fri, 6 Nov 2015 10:44:33 +0000
Message-ID: <20151106104433.GB18409@sirena.org.uk>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6274902627131654048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DF3C2602F1
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 11:44:43 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6274902627131654048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JoJCGVnM/36AiBh+"
Content-Disposition: inline


--JoJCGVnM/36AiBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 02:52:36AM +0000, Oder Chiou wrote:

> > > +	cancel_delayed_work_sync(&rt5645->rcclock_work);

> > > +	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
> > > +		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);

> > > +	ret = snd_soc_put_volsw(kcontrol, ucontrol);

> > > +	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
> > > +		msecs_to_jiffies(200));

> > A more idiomatic way of doing this is to just have the
> > queue_delayed_work() - there's no need to cancel a work item before
> > requeuing it, the workqueue code will do the right thing.  Can you
> > please submit a followup patch cleaning that up?

> Thank you for the kind advice. The "cancel_delayed_work_sync" is essential
> in case of the operation of kcontrol continuously. We want to make sure the
> RC clock can be powered up at least 200ms after the speaker volume is
> adjusted, so we add the "cancel_delayed_work_sync" on the top of the
> function and requeue it, thanks.

What makes you claim that this is "essential in case of the operation of
kcontrol continuously"?

--JoJCGVnM/36AiBh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPISQAAoJECTWi3JdVIfQc/sH/33hWGoN8HmxvGdSPqcmI/T0
au6mIQSmhehZVXYSot9rsXexx3mXtaWd42StzIghcoOoNSFuLh9KBtudCz6qhWwg
ko81LKps5bhh4Ot0HcaqxzhS+eMXy8VhDBIY9xlfjxjgVLQ682XKxnsqTHwu3TGX
OpxaQo0EHi6r424a5uWeg6prmtEHrdLYvKdJkONPWbNyJmbA1LnqcIo+nXTg5Wxv
rKYof+oz8OVEUVWWnWRgA05L/BbmtLCEo0LtmOHWHjkAZ1O+2xhwWkfDavIKU5fi
mwz1zqUlQcSOm0j3Q4SzKKXh8VhutuzhIZwS830+WruSrSL+vpeVTtLfAWqeo4Y=
=IxpE
-----END PGP SIGNATURE-----

--JoJCGVnM/36AiBh+--

--===============6274902627131654048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6274902627131654048==--
