From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation files
Date: Sat, 29 Aug 2015 10:47:11 +0100
Message-ID: <20150829094711.GZ12027@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
 <20150826184323.GE28760@sirena.org.uk>
 <55DF1CDD.6040109@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vJwpkiw3F9XLBeML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55DF1CDD.6040109@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vJwpkiw3F9XLBeML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2015 at 03:21:17PM +0100, Qais Yousef wrote:
> On 08/26/2015 07:43 PM, Mark Brown wrote:
> >On Mon, Aug 24, 2015 at 01:39:14PM +0100, Qais Yousef wrote:

> >>+	/*
> >>+	 * must ensure we have one access at a time to the queue and rd_idx
> >>+	 * to be preemption and SMP safe
> >>+	 * Sempahores will ensure that we will only read after a complete write
> >>+	 * has finished, so we will never read and write from the same location.
> >>+	 */

> >In what way will sempahores ensure that we will only read after a
> >complete write?

> This comment needs fixing. What it is trying to say is that if we reached
> this point of the code then we're certainly allowed to modify the buffer
> queue and {rd, wr}_idx because the semaphore would have gone to sleep
> otherwise if the queue is full/empty.

> Should I just remove the reference to Semaphores from the comment or worth
> rephrasing it?

Any comments need to be comprehensible.

> Would it be better to rename {rd, wr}_{idx, sem} to {take, put}_{idx, sem}?

I'm not sure that helps to be honest, the main issue is that the scheme
is fairly complex and unexplained.

> >>+	buf = bufferq->queue[bufferq->rd_idx];

> >So buffers are always retired in the same order that they are acquired?

> I don't think I get you here. axd_bufferq_take() and axd_bufferq_put() could
> be called in any order.

Retiring buffers in the order they are acquired means that buffers are
always freed in the same order they are acquired, you can't free one
buffer before another that was acquired first.

> What this code is trying to do is make a contiguous memory area behave as a
> ring buffer. Then this ring buffer behave as a queue. We use semaphore
> counts to control how many are available to take/put. rd_idx and wr_idx
> should always point at the next location to take/put from/to.

> Does this help answering your question?

No.  Why are we doing this?  Essentially all ALSA buffers are ring
buffers handled in blocks, why does this one need this complex locking
scheme?

> >>+void axd_bufferq_abort_put(struct axd_bufferq *bufferq)
> >>+{
> >>+	if (axd_bufferq_is_full(bufferq)) {
> >>+		bufferq->abort_put = 1;
> >>+		up(&bufferq->wr_sem);
> >>+	}
> >>+}

> >These look *incredibly* racy.  Why are they here and why are they safe?

> If we want to restart the firmware we will need to abort any blocking reads
> or writes for the user space to react. I also needed that to implement

I'm not questioning what the functionns are doing, I'm questioning their
implementation - it doesn't look like they are safe or reliable.  They
just set a flag, relying on something else to notice that the flag has
been set and act appropriately before it goes on and corrupts data.
That just screams concurrency issues.

> nonblocking access in user space when this was a sysfs based driver. It was
> important then to implement omx IL component correctly.

Nobody cares about OMX ILs in mainline or sysfs based interfaces.

> Do I need to support nonblock reads and writes in ALSA? If I use SIGKILL as
> you suggested in the other email when restarting and nonblock is not
> important then I can remove this.

It would be better to support non blocking access.

--vJwpkiw3F9XLBeML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV4X+bAAoJECTWi3JdVIfQJ8kH/3DeVJoSmeA4mrLyNdrLhWG0
BxuN6ovtTiJTRqFhgL8BkJcbplET5KwX0B5ef0lASsUhWX5nKJJIlnqggOfkZ1gQ
Y10AQyRRnoPkQvhgimJ8+6bL5oxrWbXZD7DxfXGxk5kpGM4tMAoWvUmgWzbLJP1B
B8X3cqOmXcAgpJ4jpSk2kCZju0P+e0UsJghwLOHNfd1HikYPXrc6Znf9hdwkaG8+
609RoyuDZAvk9B3hRfoTtcpbkPtaHtM3Oj8uCZWLx06r3tcswGNd92OgemPW9M4A
EJspFjjmmULiy9BKxkxREpxNqfrqCnOxDktTnTqbeTPYIeuKDCrDiKywdqF+Yy4=
=9nJg
-----END PGP SIGNATURE-----

--vJwpkiw3F9XLBeML--
