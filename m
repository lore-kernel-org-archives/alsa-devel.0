From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Thu, 3 Oct 2013 17:19:29 +0100
Message-ID: <20131003161929.GA27287@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131003133729.GR27287@sirena.org.uk>
 <524D7DB5.1010608@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536941342422576941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C3502265594
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 18:19:34 +0200 (CEST)
In-Reply-To: <524D7DB5.1010608@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0536941342422576941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKkvi6mMqAM+MlBZ"
Content-Disposition: inline


--yKkvi6mMqAM+MlBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2013 at 05:22:45PM +0300, Jarkko Nikula wrote:
> On 10/03/2013 04:37 PM, Mark Brown wrote:

> >This is making me wonder if we shouldn't be taking the stable names we
> >get from ACPI as the dev_name() instead of our internal ones on ACPI
> >systems (and possibly something similar on DT) rather than adding custom
> >code like this.

> This is actually somewhat confusing issue. I think it's relatively
> easy to switch using ACPI names within ASoC core (by modifying
> fmt_single_name or something like that).

> Problem is that for ACPI enumerated client devices the dev_name(dev)
> still comes from those subsystems as before. So for instance dev_
> prints in codec driver or ASoC core keeps printing "rt5640 0-001c:"
> as before and I personally find it a bit more confusing if internal
> ASoC names don't match as easily with dev_ prints.

You're misreading my suggestion.  What I'm saying is that it seems like
it might be useful to have dev_name() return the ACPI name - this would
mean that everything, including all the dev_ prints, would use the same
name which would then become stable and tied to hardware.

--yKkvi6mMqAM+MlBZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTZkOAAoJELSic+t+oim9yz4P/jg/4xuPMEDdcZHFrwwix1Jp
ghzkIfDCMWTQ8exVlGwOB34dP2N3Pe84jG5WzrfZDL6r/BOBBJin2uPkUxB1BC7b
v5sGihaNH9vB7a7SYoMosooJOJYxbynN7je7MO3tkJ9ilPuiUVR8LK0FOs+ABqdA
wRsvS2Oj56oEVxFqeRBIG7KoTZSXXjQUYXbEIhlfvPHRYdBUSXRr7ZLCxtpR4JJ6
Gl8nytnorylMiWGtxmKXA742vhBKqFgqaMyEJbHJlqLVjRmJsK6+xqoR3EJPf0dm
dXCNckiDPd5Mp5CTIPCeZWrv++V4Z/j6xPMt2A8vbopkCD+L/XdE5aUswQuLwAKY
ettQmTistGI6ZMnLhhXWMlbtLxPTpaglLgD+uU5N9vZNzDeBm8+O4WR/dy1x6iag
QLnS0gxmZc1Q/UIaxIPGbGdZjSQvVdFOUVkMzkpD10HC7Flfs9gs8wBsbfZ+T87K
byBvCxJRqKs2UGY/iE3hpawVwrCi7OIyN17J8mb7JBnMXMxOxSN4tV+OkFP+fUsO
XvpK2JS27ob5mff3TCY5WRDvZAIJKlR01FMWGS8VUGU4BLhfS9COprCm+ySn2COJ
IId/yZDsFZbyMsS3WGW5sWkCCzSV2OO0unrO7iLm3RdwTpYLm1s26iDVa4fHAXtu
5B21u8ujvooz/I0UQEQJ
=sylp
-----END PGP SIGNATURE-----

--yKkvi6mMqAM+MlBZ--

--===============0536941342422576941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0536941342422576941==--
