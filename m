From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non
	circular
Date: Thu, 2 Aug 2018 10:56:17 +0100
Message-ID: <20180802095617.GC9117@sirena.org.uk>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8545287499487437743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 298162677C8
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 11:56:21 +0200 (CEST)
In-Reply-To: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--===============8545287499487437743==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 12:11:54PM +0530, Akshu Agrawal wrote:
> In capture case we don't want ACP to SYSMEM dma
> to be circular. This is because if an in place DSP
> filter is applied to captured output then circular DMA
> can overwrite the filter value with stale data.

Isn't that just a problem with userspace not giving itself enough buffer
to get the in place processing done before we loop round again.  This
will simply change the type of error, it won't actually fix anything
AFAICT but perhaps I'm missing something.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti1UAACgkQJNaLcl1U
h9D2ygf/ehYWjpfDi7yutUUdHpYQ9PM67mlWd/w7NnlZGvfY+fKwzKqv9hy1hqVR
zUqMxTLbqqsnMxwVusEfLYpF5Ckznh/EQhgFBxGbS6Ocz0e2kGN128VD2LyziboI
QWV8qp49MiBiVexgXDHpbyPw+SmnbvQyViCBqm3X8GZJkqWIUzBnCINr4fqqXAv0
Cc3DbDYs993W0Say2R95fec+DJb8jQ4MZD9nRAq0JV8kuoHW4A0Wiim8O21ELuH+
n+k9SNr/OboKeR8V/j9slWWLXGRioA31DSfatLTK3KTNRPjyIZ+x4Ce4X+D8nEm7
m4n2zRDoDbSkIYQh/uhMbmlxgGTUsg==
=PhBU
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

--===============8545287499487437743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8545287499487437743==--
