From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation files
Date: Thu, 3 Sep 2015 13:32:32 +0100
Message-ID: <20150903123232.GX12027@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
 <20150826184323.GE28760@sirena.org.uk>
 <55DF1CDD.6040109@imgtec.com>
 <20150829094711.GZ12027@sirena.org.uk>
 <55E5774A.8070808@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i1PcW0DRC/TAMeXk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E5774A.8070808@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--i1PcW0DRC/TAMeXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 11:00:42AM +0100, Qais Yousef wrote:
> On 08/29/2015 10:47 AM, Mark Brown wrote:

Please delete unneeded context from replies, it makes it easier to find
the new content you have added.  Please also leave blank lines between
paragraphs, it makes it much easier to read messages.

> >>What this code is trying to do is make a contiguous memory area behave as a
> >>ring buffer. Then this ring buffer behave as a queue. We use semaphore
> >>counts to control how many are available to take/put. rd_idx and wr_idx
> >>should always point at the next location to take/put from/to.
> >>Does this help answering your question?

> >No.  Why are we doing this?  Essentially all ALSA buffers are ring
> >buffers handled in blocks, why does this one need this complex locking
> >scheme?

> There are 2 sides to this. The ALSA/driver iface and the driver/firmware
> one. The ALSA/driver iface is called from ALSA ops but the driver/firmware
> is handled by the interrupt and workqueues. The code is trying to deal with
> this concurrency. Also once AXD consumed a buffer it sends back an interrupt

This is just the same as any other ALSA device...

> to the driver that it can reuse it, there's no guarantee that this returned
> buffer is in the same order it was sent.

If that's the case I'm not sure the code is correct - it seemed to have
assumptions that the buffers were going to be retired in the order.

--i1PcW0DRC/TAMeXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6D3fAAoJECTWi3JdVIfQcJgH/1M2hcXOE09HXZhvM7xZm8Ad
MYyiboCLuHE6duts1aKv5JLbTKKqhELHD+tiDSxAOi04wOW04KseR15XRtN5AS1b
/qMBDXBBpq07VZ8bwZxwASQynH7mbgem4m9Y3U7CO+7FMeLHdr9LxMGpiwTab9/n
8SJ0hOVQxzqR46nSsQW1A8tKeE/1RropQbW3dVYbvB335q1bdzrMeFf+5u1TXMOa
UahSpqY8G/nNsG96IOALBfjxr3szSOcYaHF/QV+QWOXTAgFBWEQ9egMu+gSA5nfp
t5t4ful41EpyGtuWGh9G6/QrSyDb2IUtqnoqWNnG/ccy+hB5B6GpMQVB04iy/c8=
=nVKo
-----END PGP SIGNATURE-----

--i1PcW0DRC/TAMeXk--
