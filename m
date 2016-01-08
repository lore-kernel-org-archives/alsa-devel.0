From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 03/14] ASoC: hdac_hdmi: Use list to add
 pins and converters
Date: Fri, 8 Jan 2016 13:32:51 +0000
Message-ID: <20160108133251.GP6588@sirena.org.uk>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3721364498999384949=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76FD426040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:33:00 +0100 (CET)
In-Reply-To: <1449677781-7997-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3721364498999384949==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BfIB/hDtUWEgpOfz"
Content-Disposition: inline


--BfIB/hDtUWEgpOfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 09:46:10PM +0530, Subhransu S. Prusty wrote:

> Future platforms may have a different set of pins/converters.
> So use lists to add pins and converters based on enumeration.

> Also it may be required to connect any converter to any pin
> dynamically as per different use cases (for example DP is
> connected to pin 6 on skylake board). So this will help in
> dynamically select and route.

This sounds like it's supposed to be supporting multiple outputs but...

> +	/*
> +	 * Currently on board only 1 pin and 1 converter is enabled for
> +	 * simplification, more will be added eventually
> +	 * So using fixed map for dai_id:pin:cvt
> +	 */
> +	cvt = list_first_entry(&hdmi->cvt_list, struct hdac_hdmi_cvt, head);
> +	pin = list_first_entry(&hdmi->pin_list, struct hdac_hdmi_pin, head);

...it looks like we still only support one random pin and one random
convertor?  How do we know if we got the right ones?  I *think* this
mostly ends up doing the same thing as the previous version but if
that's the case why are we doing it?

As I've said before one of the reasons it sometimes takes a long time to
review these things is that there's a lot of big patch serieses getting
sent which aren't that well explained.

> -	snd_hdac_codec_write(&edev->hdac, pin_nid, 0,
> +	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,

Huge portions of this patch are a simple refactoring like this, it'd be
good to have split those out as a separate patch so the actual content
is more visible.

--BfIB/hDtUWEgpOfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj7qCAAoJECTWi3JdVIfQvg0H+wYuWnOgBzftzG14nIcKWGch
5h82Sw2NvWyhXb5ZqlZsSdGYBrf0UZRTDHrkWr/hzjIUMSkpLeLmUw+hL1YbyaJR
HzT9iJlDfKUtiTFR88rTH7oFM73QgwhMhwQBAH+lw/02Gu6mBt4fNMePAQrGO/zn
XLJcN18e+iNbQ/aUfIG6+a+pPAmtrkqJEu7rXz39i9Mf8ZZDSwTBZPPG5KmDkGTJ
HhwxzZHszKkwxU0G4QfHKKHHhX8RM9iF33yQN1nwOmEm8D1WTOsu2Nm0PSxtjYDS
eOY3XAURe3AZGlxvhBcMzTthRVnyy6+iLp7xQ7iFg2Ov5zcQ0J7N6VfcyImfM6w=
=Tb9N
-----END PGP SIGNATURE-----

--BfIB/hDtUWEgpOfz--

--===============3721364498999384949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3721364498999384949==--
