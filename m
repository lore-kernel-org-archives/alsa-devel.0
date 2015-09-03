From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/10] ALSA: axd: add basic files for sending/receiving
 axd cmds
Date: Thu, 3 Sep 2015 13:40:45 +0100
Message-ID: <20150903124045.GY12027@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-7-git-send-email-qais.yousef@imgtec.com>
 <20150826191642.GG28760@sirena.org.uk>
 <55DF2F59.408@imgtec.com>
 <20150829101814.GA12027@sirena.org.uk>
 <55E581FB.4000202@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0zTKgzRlFSa+w9QI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E581FB.4000202@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0zTKgzRlFSa+w9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 11:46:19AM +0100, Qais Yousef wrote:
> On 08/29/2015 11:18 AM, Mark Brown wrote:
> >On Thu, Aug 27, 2015 at 04:40:09PM +0100, Qais Yousef wrote:

Again, please delete unneeded contexts and leave blanks between
paragraphs (I notice you've even been removing the blank lines from
quoted material).

> >>>>+#define PIPE_STARTED	1
> >>>>+#define PIPE_RUNNING	2

> >>>Why is the case with in place buffers not a simple zero iteration loop?

> >>This is important when AXD is not consuming the data through I2S and
> >>returning them to Linux. What we're trying to deal with here is the firmware
> >>processed some data and expects Linux to consume whatever it has sent back
> >>to it. We want to ensure that if the user suddenly stopped consuming this
> >>data by closing the pipe to drop anything we receive back from AXD otherwise
> >>the workqueue would block indefinitely waiting for the user that disappeared
> >>to consume it causing a deadlock.

> >That doesn't seem to address the question...

> I'm sorry I don't understand your question then. Can you rephrase it please?

Why don't we just always try to consume any buffers that are in flight?

> >Why not just reuse the bufferq implementation if that's what you want to
> >use?  More generally most audio ring buffers just keep track of the last
> >place read or written and don't bother with semaphores (why do we even
> >need to block?).  It's not just the semaphore you're using here but also
> >some non-atomic variables accessed with memory barriers and mutexes all
> >scattered over a very large block of code.  It is far too much effort to
> >reason about what the locking scheme is supposed to be here to determine
> >if it is safe, and that's not going to get any easier when reviewing
> >future changes.

> We need to block because in the past at least the driver could work on
> blocking mode and it would return the buffers back to Linux and there was no
> guarantee that the reader and writer would be on the same rate. The worst
> case assumption was that the writer and the reader could be 2 different
> apps. For example an app getting data from network to AXD to be encoded and
> another app reading the encoded data to store it on disk. And AXD supports
> multi-pipeline, so more one of these operations could be happening at the
> same time.

I can't really connect the above with a need to block, sorry...  I'm
going to assume this was something to do with old non-standard external
interfaces.

--0zTKgzRlFSa+w9QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6D/MAAoJECTWi3JdVIfQCEYH/2vmgPgddrzRvCwyRC8F2566
+2mAn1a6x5dmAbcXamKg2qZXk/9Bwg2vZbiwt+uiuP0Na7gmlPjOFxVenblLLIBL
wdmFNw/O9rdBN3rFFL7TLyVP3hApxbF7B0jLwXmTCvwVB3CzK9D/K1S3uTXvdPZ/
Yd44TAiy3cGeV4+pNAE0F82S7d9zu663ZZ+in3531fczYGv/w+OtFszWlQ1gCc/v
NgPikll7nvAJVZ6InQTIOe2UNNsSe5W8jG9PYT7SubHRDpIyi7/JPO+Ku7sG2Wc6
KjsMy8VollMvcQ68EMmK3AGd8lUlsXps4D5NFJwVTIr9bYxJETVUi26Ny5SYP8A=
=oZte
-----END PGP SIGNATURE-----

--0zTKgzRlFSa+w9QI--
