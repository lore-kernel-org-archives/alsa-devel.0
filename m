From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Wed, 17 Jul 2013 10:47:18 +0100
Message-ID: <20130717094718.GE22506@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7908059799945101225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AF16A265119
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 11:47:21 +0200 (CEST)
In-Reply-To: <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============7908059799945101225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5PPnVwj6ulmYFu5t"
Content-Disposition: inline


--5PPnVwj6ulmYFu5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2013 at 09:40:39AM +0100, Mark Rutland wrote:
> On Wed, Jul 17, 2013 at 07:12:14AM +0100, Barry Song wrote:

> > this makes users be able to add a bt-sco node in dts instead of
> > hardcoding a platform device in mach.

> I'm slightly confused by this. The driver doesn't seem to pick up any
> information out of the dts, and the binding doesn't even describe any
> linkage to a piece of hardware. I'm not familiar with bluetooth or ASoC,
> could you give an explanation as to why this is needed?

> I don't think this should be in the dt as is. Could this not be
> registered based on the presence of a bluetooth controller that supports
> this?

Audio devices are linked together by a separate board binding which
specifies how all the different components in the audio subsystem on the
board are wired together.  Even where things have no meanignful software
control (as is the case here and for a lot of simple DACs or ADCs) the
rest of the system needs information on their capabilites and ideally
the ability to interchange them with more substantial devices.  If there
were meaningful control there'd be a control bus here.

There is likely to be a control interface for the BT device hanging off
a UART but it's not clear there's much more meaningful data for those
than there is here.

--5PPnVwj6ulmYFu5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5mgjAAoJELSic+t+oim9XaQQAJtZnsazaCT70y5F0pWcg1vH
LG30blvLgXyI895SB/fmR6YFzC2p2d8OletSerplU+GSkEe1WiWokU9w9VPDbBxg
mB9biG8qAx5yJ7+j+q0z9SEWsBYfs3KH/toloFQb67ew45wjUaHu6uLeuQHNrBPP
/jBHJdVZCRSRXpCnjz04JqWiK8EmA00cF7Hv6w8eXmthnfNfxFgd9Wr3+Og3ao6I
KbYRzArIi5+OIdwF9FtOxNapzxHX9j9J3+fjyLjt0fywcUVvnFUJhYiB4l9gtetN
zDEjMBIx7nau0Au9hI5uApGtx+TF1/Sq/n2Ssj2hpLUc6v369jZ5auAVmDQdYs70
GdDRu0gJT9r1BNQpYjlSxveRBV0N+5SEPE25AYQAOTaB59kst+uuBKG51GvQFQjK
LgnVi+J7eTSqu3ke/2I3wvrr6vdjNZ0dmlV7kOZ5XTdAqcqhLMz80CdIH+loCaim
qAOkUNlIlcty7QnBoIQYJ0atZEaS1XvDMaYyvEtjm1ABAq+dLiAI8VCBv0yF7C9r
NxNbCumjcTpvhceY+jOa3AH7sF2bgHkqix9nycF/RmYo7kUScA0oAyPxG++l3m1Y
c6YfA+0C1/wGC3xdfLRGbtOf6IhnNRB9TdZJJOGSuVa7NsJ7CW3zs00jGPy4jT8i
9Uvkpz5CokWu/XpJT4wh
=OV39
-----END PGP SIGNATURE-----

--5PPnVwj6ulmYFu5t--

--===============7908059799945101225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7908059799945101225==--
