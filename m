From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH (alsa-lib)] pcm: Modify check condition
 in snd_pcm_sw_params_set_avail_min
Date: Thu, 3 Sep 2015 10:38:10 +0100
Message-ID: <20150903093810.GE5313@sirena.org.uk>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de>
 <1441266346.32609.18.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9180223265360703298=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72E96260647
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 11:38:24 +0200 (CEST)
In-Reply-To: <1441266346.32609.18.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, lgirdwood@gmail.com, srv_heupstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============9180223265360703298==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JSVXQxoTSdH0Ya++"
Content-Disposition: inline


--JSVXQxoTSdH0Ya++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 03:45:46PM +0800, Koro Chen wrote:
> On Thu, 2015-09-03 at 09:08 +0200, Takashi Iwai wrote:

> > How this happens?  The period size is the size where irq (or wakeup)
> > wakes up for read/write.  Why the driver wakes up even if there is no
> > enough data?

> Yes it is odd to what we would normally expect. Due to our HW design,
> when irq comes, audio HW actually has collected a full period of data,
> but there is a buffer between the audio HW and memory, so at that moment
> some samples are still in the buffer, not on the memory. Add a small
> delay between triggering capture HW and enabling IRQ can also fix this,
> although I think changing the avail_min should be better.=20

This does sound like something that should be handled in the kernel -
one thing we should be doing is providing a uniform interface to
userspace.

--JSVXQxoTSdH0Ya++
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6BUBAAoJECTWi3JdVIfQ9zkH/0q5H5DSezFfF1ym7xiheckM
xQn7xhzQe6EUSmuZ1nlAduA+4zS4UADPuPa5YBT7RppKKzgGZIiHGN+lfWb46jDd
/vluDrWYBhqFNWgu/VASCwQMLa7zAAA08PDhGKrBtw48m5SWkirDnTJYqQ3mhlic
9xx8Gcm0nHUJQhFufspoj8M9ibZH30ZJIx2cKKJq1KDzMGhPBPGZnpRsAKW2QhAa
mgZxXIw8FvO5I6MlCsJwbL/d+/AOoAlMjEiHAxE8q4WGKdGfvmbtMg1nfzK5Vyqt
wzW2InMjLUIOdgmVzErRlQW2lcSjHHwmwXRjzWIi/oRXCAZYg6uFoDkWMJQR3Zs=
=OfFT
-----END PGP SIGNATURE-----

--JSVXQxoTSdH0Ya++--

--===============9180223265360703298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9180223265360703298==--
