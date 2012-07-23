From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Help request - ASoC recursion issue
Date: Mon, 23 Jul 2012 15:39:56 +0100
Message-ID: <20120723143955.GA8071@opensource.wolfsonmicro.com>
References: <500D5A1F.9000808@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3254381868481660254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DBF0265D04
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 16:39:55 +0200 (CEST)
In-Reply-To: <500D5A1F.9000808@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3254381868481660254==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 03:05:19PM +0100, Lee Jones wrote:

> I was wondering if I may bother you for some help. I've been having
> serious issues with testing the new mop500 sound system you have in

You might want to CC some of the people who wrote that code...

> The problem seems to be that 'dapm_supply_check_power()' then calls
> back into 'dapm_widget_power_check()'. Then round and round we go!

Please describe what the problem you think you're seeing is, you've just
cut'n'pasted the code into your mail without describing any actual
problem in the system...

The tree walk is recursive so the fact that we call the same function
more than once isn't terribly surprising.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDWItAAoJEBus8iNuMP3dH+8P+wb8jxonN/7NxikoRjK7ltEN
G71lEjSVzTpv2KytIWyou8U3xmNi2ykcYuyDagzZJLGZaGXHc+C9dlSj5JH7VHl0
ocPnZTNNJD0YPAXsz9yuxpC0ubeepetz6Z9UwUPrOiY/0C1c4ntMOG7vqvjMSgX/
bP1xZQLtwEiOaTUj15hjv0lRePZ8o5JXeSIvTx+DzCTdSa6FE14mHysaYIyAhQdn
T1yP2i3hu/DYYvf8QfqA1TV9eQshS7UVKMRY2/UC/FRnmujZ4m2r0UaS4c/s4Vg+
/brFa+w6Oxu/AgIvTNFgLjEaHOslweCjG9P2ZvrOpVbpzcN9MkZFPM6X/Lk94hyT
Y11cqW40f52J1Wa135WhVEWyTLuHgtM0XqwbaastmwpIh9GijxXW7jMNSlQXTu1F
TMHEn7Y6I3CBahO2FzeF5J3w3lSY7v0fvUway+cU0QJJBbpy+AkNIBnVQEpLBiwX
cVmW2gS6aeplnlkkWdZpwe49VrUzpk4SiRlBWLg97D23bUeh6kv49LAlLfKnms3H
n0aMutQphHbvBKi6Fl3+5i72KNgj8gy+kFzaL/pulPJakwUmLdev0GaxGkrMk8aF
T/4llFIBQ32N5H9sY3pxTglHJZsXB6PDohJigU7gT+gsNahE8QPYLofflM3Ccmm5
6CHdchhaYhTdAG0L96Lt
=4Iga
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============3254381868481660254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3254381868481660254==--
