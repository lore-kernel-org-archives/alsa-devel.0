From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL
	pcm_{new, free}
Date: Mon, 13 Mar 2017 12:50:04 +0000
Message-ID: <20170313125004.yrqranp3sxsfkmfx@sirena.org.uk>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
 <20170311002406.GA4586@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0546077860489695932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0379A266927
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 13:50:34 +0100 (CET)
In-Reply-To: <20170311002406.GA4586@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0546077860489695932==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v75fjwnmn3ib2ztx"
Content-Disposition: inline


--v75fjwnmn3ib2ztx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 10, 2017 at 04:24:07PM -0800, Brian Norris wrote:
> On Thu, Mar 09, 2017 at 12:09:18PM +0100, Mark Brown wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative then it's
> > usually better to pull out the relevant sections.

> I did think, and I did trim the trace significantly. I believe (or
> believed; maybe incorrectly) that much of the remaining context *was*
> useful, and that it could have answered some of Kuninori's questions, if
> he chose to dig himself. As admitted in the commit message, I don't
> really understand all of the relationships here, so it's hard to
> highlight "only the relevant sections".

Any editing you'd done is really not obvious looking at the trace (the
inclusion of the top of the trace with the pgd and so on which really
need the image to be useful is a bit of a flag here, as is the bit at
the end after the end of the trace).  It's certainly not mentioned or
referenced.  At the very least for probe errors it's generally safe to
cut down to just the driver probe function is being called rather than
showing the entire device model call stack, it's vanishingly rare for
that to be adding anything and it's generally several times deeper than
what the driver is doing.

> I'm sorry that my post did not meet your standards though. Next time
> I'll just post a revert with little context and no attempt to understand
> what actually went wrong.

Providing changes with little context and no conveyed understanding of
exactly what went wrong is a very big part of the reason for complaining
about people just splatting backtraces in and certainly not what I was
asking for, it's sadly common to see a backtrace provided in lieu of any
analysis and it does make the whole thing harder to read.  That would be
even more problematic than what you sent, I wouldn't have applied such a
change at all unless I somehow reverse engineered the analysis.

You do have a reasonable analysis of your change in the first couple of
lines ("Not all platform drivers have pcm_{new,free} callbacks...")
which is why I applied it, it's at least not going to do any harm to
check that there's a function being provided.

--v75fjwnmn3ib2ztx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljGlXgACgkQJNaLcl1U
h9BlzQf/UWlF15pNThXBPcBNmGkQIGRdSXYRBgmrWmCfyOybShsbmF0a/9vGaA0e
CntDoYssmsUHoueYunKcFtGHqzUQdZMmjNQT93ywmPVarvYghxbjH4QISrF5hU7D
eL+XjA1BBPYBntaqlG69lBQ8EVQdb6oiCbQmAIDhLciRvvtDhUmrPHPstO2bc8R9
DBWggpOrWbY77zwKEW1Btgd0JNRjI9Isvp7dSKrMsSWM7Llu0Umzx2CvzmyWk8bH
nOYG8O9tkLa/BKAS8M2aZPAZxDVIoVk2wOzy76UD6XQuMf597jZ1ce6Dy9hMJcK0
VL/bArW+oWcLhA6voXw+WjiuiZiexQ==
=gnsw
-----END PGP SIGNATURE-----

--v75fjwnmn3ib2ztx--

--===============0546077860489695932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0546077860489695932==--
