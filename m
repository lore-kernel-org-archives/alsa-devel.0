From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/10] ALSA: add AXD Audio Processing IP
	alsa driver
Date: Thu, 3 Sep 2015 13:46:32 +0100
Message-ID: <20150903124632.GZ12027@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-4-git-send-email-qais.yousef@imgtec.com>
 <20150826183700.GD28760@sirena.org.uk>
 <55DEFF77.8070309@imgtec.com> <20150827153233.GD5313@sirena.org.uk>
 <55E02871.9050607@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7067731955785172806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D42122606B8
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 14:46:44 +0200 (CEST)
In-Reply-To: <55E02871.9050607@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7067731955785172806==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vBrReJOVREFtblek"
Content-Disposition: inline


--vBrReJOVREFtblek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 28, 2015 at 10:22:57AM +0100, Qais Yousef wrote:
> On 08/27/2015 04:32 PM, Mark Brown wrote:
> >On Thu, Aug 27, 2015 at 01:15:51PM +0100, Qais Yousef wrote:

> >>>>+#define AXD_BASE_VADDR		0xD0000000

> >>>This sounds like something that is going to be platform dependant,
> >>>should this be supplied from board configuration?

> >>I don't expect this to change. Can we add the configuration later if we hit
> >>the need to change it?

> >It should be trivial to make things configurable shouldn't it?

> Yes and I am all with configurability but I don't think it makes sense here.
> AXD will always have its own MMU and will not share virtual address space,
> so the possibility of us wanting to move this somewhere else is really very
> thin. Also I don't think this is the kind of detail we need to concern the
> user with. I'll see if I can make the binary header parsing more flexible so
> we can add more info like this and the one above in the future and be more
> future proof.

So this is a virtual address in the memory map of the DSP?  That's not
what I thought it was.

> >>>>+	memcpy_toio((void *)cached_fw_base, fw->data, fw->size);

> >>>Why the cast here?  I'm also not seeing where we handled the copying to
> >>>I/O in the decompression case?

> >>I couldn't avoid the cast. If cached_fw_base is 'void *' I'll get a warning
> >>when initialising cached_fw_base from CAC_ADDR().

> >Why do you get a warning from that?  Perhaps the warnings are trying to
> >tell us something...

> Because we try to assign an int to a pointer. So the error is 'makes pointer
> from integer without a cast'. To convert an address from uncached to cached
> we need to convert to an int as in MIPS it's a case of adding or subtracting
> a value then convert this value back to it's original form.
> I'll see if I can find a better way to fix the coherency issue when we copy
> through uncached.

Why can't you just use pointer arithmmetic?

> >>Good point. When decompressing crypto_comp_decompress() will write directly
> >>to the memory. It is safe but it doesn't go through the correct API. Not
> >>sure what I can do here.

> >Uncompress to a buffer then write that buffer to the final destination?

> Yes but the binary could be multi MiB so we can't get a temp buffer that
> large. If the crypto API allows decompressing in steps we can use a small
> buffer to move the data iteratively. I'll have a look.

A few megabytes doesn't seem like that big an ask (it's not *nice* but
it's doable with vmalloc()).  Iteratively copying is nicer though.

> >>>>+	/* wake up any task sleeping on command response */
> >>>>+	wake_up(&axd->cmd.wait);
> >>>>+	/* give chance to user land tasks to react to the crash */
> >>>>+	ssleep(2);
> >>>This looks horribly racy, I'd expect us to be trashing and/or killing
> >>>off any active work and resources here.
> >>OK. I was trying to play nicely by giving the chance to userland to repond
> >>to -ERESTART which would be sent from aborting any pending reads/writes.
> >>Are you suggesting to send SIGKILL using force_sig()?
> >No, I'm suggesting tearing down the kernel side of any work and kicking
> >errors back to userspace if it continues to interact with anything that
> >was ongoing.

> OK. This is what we do (see my other email about abort). I'll have a think
> for a way to get rid of the ssleep(). Any ideas are welcome.

Just delete it?

--vBrReJOVREFtblek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6EEnAAoJECTWi3JdVIfQi+8H/0oJnPQov8/g/uFZcRDSDhAH
ygEUWDxWikmTM/4VndZsh6F1dqATnDtojEQfrHm6yi3csD6EDqghQeWJD3OXoG6r
1HH1Sj0BxmjDSRzdwmRb212tgKFlwJNj0aBFGBZxBgZhAJAvsCwB5SNrD6pInjlR
IffsRiaQ+gXd/6Pl9A5YsrcbX9n38y+jTwuGVzO/AzKaVr+UZkmAuv4ntLN8ua64
aufRwWc7WmSGubxGJdMA+Cg142Qolb4PlnqBPEXkP5ogSxK2avK4vysIQNFroU4L
IxRnPVlhKllr2TQrZ/hrJQ6igDwf5asy9GCE8P2uGBCuL2faR/798StP4RAXCJo=
=ON8Y
-----END PGP SIGNATURE-----

--vBrReJOVREFtblek--

--===============7067731955785172806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7067731955785172806==--
