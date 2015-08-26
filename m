From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation files
Date: Wed, 26 Aug 2015 19:43:23 +0100
Message-ID: <20150826184323.GE28760@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 01:39:14PM +0100, Qais Yousef wrote:

> +	/*
> +	 * must ensure we have one access at a time to the queue and rd_idx
> +	 * to be preemption and SMP safe
> +	 * Sempahores will ensure that we will only read after a complete write
> +	 * has finished, so we will never read and write from the same location.
> +	 */

In what way will sempahores ensure that we will only read after a
complete write?

> +	buf = bufferq->queue[bufferq->rd_idx];

So buffers are always retired in the same order that they are acquired?

> +int axd_bufferq_put(struct axd_bufferq *bufferq, char *buf, int buf_size)
> +{
> +	int ret;
> +
> +	if (!bufferq->queue)
> +		return 0;
> +
> +	if (buf_size < 0)
> +		buf_size = bufferq->stride;

We've got strides as well?  What is that?

> +void axd_bufferq_abort_take(struct axd_bufferq *bufferq)
> +{
> +	if (axd_bufferq_is_empty(bufferq)) {
> +		bufferq->abort_take = 1;
> +		up(&bufferq->rd_sem);
> +	}
> +}
> +
> +void axd_bufferq_abort_put(struct axd_bufferq *bufferq)
> +{
> +	if (axd_bufferq_is_full(bufferq)) {
> +		bufferq->abort_put = 1;
> +		up(&bufferq->wr_sem);
> +	}
> +}

These look *incredibly* racy.  Why are they here and why are they safe?

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3gjKAAoJECTWi3JdVIfQnKoH/AtcvuiB7W1ujxAejJqZKFLz
CfAuL2+kcQbWxeg23amyKo4YnVzIEmDpD6Rp/6F/zYvVywBnW4RfdmW8+PMUGaX1
cQETxvpsWxwfo17je7Rw2sKLjC4CUI4QDHHK2l3kRfQS43ElTHPhvWHsGuTPoRAi
VFiD9ktGteU8t6GCYa3Kdew0fLp0bQVUgRfx4tQGfh0cXA/obUSo72TZtzl3uRUW
YLTiB0vVplxPMs4Mknp3/czNQ4QybzngQH/Bg3/ZMpEXHYQc73WmR9MPalxa4IDo
L5JHz6Cv/5wGu1nCA6XeSJfD3KUQPkhm6c5h4zW/dacRv0matGFduVwTdqZ/e+Q=
=HgYV
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
