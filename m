From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Thu, 25 Jul 2013 10:15:47 +0100
Message-ID: <20130725091547.GS9858@sirena.org.uk>
References: <1374562469-5190-1-git-send-email-bardliao@realtek.com>
 <20130723130016.GA9858@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB935C48A2B2@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2757692678943536376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 67BA22610A8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 11:15:53 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C48A2B2@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2757692678943536376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="42UPFa7uQ4wfpYoB"
Content-Disposition: inline


--42UPFa7uQ4wfpYoB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 11:36:42AM +0800, Bard Liao wrote:

> Usually, our customers use cpu's gpio as the interrupt pin of jack insert/remove.
> So we assume they will handle the interrupt event in machine driver.
> When machine driver get a jack insert/remove event, it will call this function to know the jack type(headset or headphone).
> Should I handle the interrupt event in codec driver?

Yes, of course.  Interrupts are just interrupts on Linux.

--42UPFa7uQ4wfpYoB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8OzAAAoJELSic+t+oim9Z6wP/23Z3MLzphQ/eW0XAb5o4Gyv
IzDLbmr2FjeDm++i4Sxl+G3ROK8i33tm3WawKaYTCwBiG/POxmcsVVsSR9NBpn9B
asud4O0PphixEVOcn7etP8ZebNw9edP/fYvPRjoctA/uNkSc2qJTVh8xn5HFDtad
NH8jlWrni/abUaQ8h3gyoD5D1wgc88vAJL6+AZnYoYUWZCmAYfxGh4hkum2AJkNK
QibgrSPHl2EkYHuLZ9qBMu7NmZj5/0dSQPOw/F1JR9JygaBpxe8nENt592bzArnx
5teiov6kVUAAx5LYazRoy8sWRdKxYLn2Lv75fWiBHj44d1cJu1cKxzgcEOpyJX9K
BPnH5Jqrmbb//9GosRXDIfkEygylhF/KzojhlE0pOr36wNGzXdiULRMMfALn42FG
qLPs6qb5NkS3cho+qc/j4PjgddRqlX8Erj9HaNq5HSwu+F+BoEPyd32HyslZN3fX
+AnJvwpx9A5BJ8hgkUHgU461qap+L6fWNcTBBvwp94I7b+stOT8KSP2ZKbzVbLD1
AWeDrjGgJr3zY+tZyxA5tEdInfMDlkD9UuPzleS0RThBzUC+8iSULMHKI2D17D+f
OZB1r8sYrJgKT/+wYkKheiN23cXJ64uMuZYAMAWRNsGSr4Mzxnve6m7QF5lGHp1w
sy2uqQJVS5x7Z/cqzdPr
=9l1/
-----END PGP SIGNATURE-----

--42UPFa7uQ4wfpYoB--

--===============2757692678943536376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2757692678943536376==--
