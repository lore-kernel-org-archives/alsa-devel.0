From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:24:31 +0000
Message-ID: <20131106102431.GM11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-22-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2022471020197889667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 055B7261A57
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:24:34 +0100 (CET)
In-Reply-To: <1383673218-18405-22-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2022471020197889667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Content-Disposition: inline


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:08PM +0100, Takashi Iwai wrote:

>  	list_for_each_entry(w, pending, power_list) {
> -		BUG_ON(reg != w->reg);
> +		if (WARN_ON(reg != w->reg))
> +			return;
>  		w->power = w->new_power;

This doesn't seem at all sensible - it's going to suddenly abort the
entire sequence run over the error which if we're actually trying to
continue is just going to make things worse.  I'd expect to at most skip
over the entry.

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehjcAAoJELSic+t+oim9o+oQAIEixISWJjtUXHx8dmRzPBoh
GK1ugxnlv1j6vivPOSxf1YRpIIAOP41PfVtA50yZ22hIpqXljiBEUadxgga2D5f3
HRSOvkjFJmxWwyXZQolG3yDb8qd9ZoPqb03rhyHnOYP8LEMPIL0rH9PvVwMMYQn8
R4CwYbDR7SBXYwbYIYss02Dxdt39wHXDQPjn88iEv6h71OEj5+bDq/blZPLZVToT
RqdSpAg1mCuhi33SU4/re7klbUkYeS+knboyJGgtHcrKnyjZH9tvflVeP6EOfzg8
xkuY8/zq7jgK9c/sOPbIOfSPjvKRts9g2n8VVtn80nCnYhjEL334/cwUqPXYOxwO
CcHYvIAeqfZujmjKfkzJok31WOCf38gFTS5G8P2Jnca+fSG6XOsihTz/oeOZhYM9
DEyVvT19lLxyz35nsRkc6Bl2sE+DBBYyO+xFlzUNYxbdjRYTMC04+25s9OrjFrRs
SeHckVEbSs+xOfgzSkFuCyNOroKDrScDVwa7faSfb5VUkz9AllPkMLix4Bx3e1ra
TYsYXU6Gtxf9qcZmd14KOxu6kv3rFr2N864YjVh3X+I/mUWyA/NmqhMdieybl0jY
TW0ClvREjnFJdbPLk6zTT4mZFE830qh5X8rCRF13uSIX/IxIBWhLydDvgGIQZVu9
WW7iL1pMZFW77PlyHaHQ
=TM/p
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--

--===============2022471020197889667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2022471020197889667==--
