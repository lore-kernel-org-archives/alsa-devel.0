From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 03/22] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Wed, 7 Mar 2018 14:28:30 +0000
Message-ID: <20180307142830.GE7290@sirena.org.uk>
References: <20180304143610.21125-1-hdegoede@redhat.com>
 <20180304143610.21125-4-hdegoede@redhat.com>
 <20180307123425.GC7290@sirena.org.uk>
 <42832c38-2c57-5083-e1fc-0911a8d88384@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169880805137228909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01E9426705A
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:28:35 +0100 (CET)
In-Reply-To: <42832c38-2c57-5083-e1fc-0911a8d88384@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1169880805137228909==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2018 at 02:49:05PM +0100, Hans de Goede wrote:

> Although I agree that ideally we would be able to get all this
> directly from the firmware, to me fixing the x86 specific problem
> of that info missing using quirks in the Intel machine driver seems
> like the right place to fix this, so that we are not "poluting"
> generic code with these Intel specific workarounds.

Yeah, my feeling here is that this is less pollution than you're seeing
it as - it's too much like endorsement of the Windows one driver per
machine way of doing things and splits the knowledge about how the
device gets used about more.  Purely a taste question.

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf9w0ACgkQJNaLcl1U
h9CiNgf/Tk+/lbGOVRhpQrQEzpr7MwCxhHZydMcbzc8CvfI9unFM+DynQ1kgbLkf
UOdVP83UtKepySJPOE+S+wXJ/6aXGJ4DjFo0QxEsd989HOjDlmXEoagf7K07NgSA
mzim+AFz5pcwhNLL1C0mDTd7871ZXzi/WVzGS+NaQGA215nL4m+7Q3RMZWyxr8tT
3nBsZhqVgRKr/8xmrX9Kyv+dxOT/ljwjzAwSDqnXdfA56+BBniYS8t90jZhbFDOh
qrZMNgLtExyuAtr6rm/qtjtnzvsEiLIhQ1ZRMabLzOB/KSh1IqeVE0OVsDqH9P5v
UPzSCVfA5j/WAWaipB9Ky/oN16jX3A==
=XfVC
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--

--===============1169880805137228909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1169880805137228909==--
