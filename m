From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 16:49:32 +0100
Message-ID: <20120821154931.GT7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <s5htxvw1eqz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0740402366428527983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D288265FFA
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 17:49:32 +0200 (CEST)
In-Reply-To: <s5htxvw1eqz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0740402366428527983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Content-Disposition: inline


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 04:49:56PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Or perhaps what we want to do here is define the channel mapping in
> > terms of saying "I'm connecting to this input/output" and then use the
> > jack interface to describe all inputs and outputs rather than just jacks
> > (making sure it's easy to see which ones can change state)?

> It's an interesting idea.  But, in the case of HDMI, there are no
> multiple jacks, so this won't fit.

Surely the jack should be able to change state, though?

> What I had in my mind originally is to provide the definition of
> values in TLV, and get/set points the value index.

> However, this doesn't help much for multiple output cases like
> ice1712.  So far, I ignored that case intentionally.  The primary goal
> of this API is to provide a way for apps to decide the channel map for
> multi-channel streams.  If multiple positions are given, what they
> should do?  It'd be just confusing.

This sort of stuff is why I was suggesting providing a mechanism for
saying "fall back to tracing the routing graph" - obviously there's an
implementation to do there but it should provide ultimate support for
whatever mappings people can dreamm up.

> At least, some fixed multiple outputs could be covered by the free
> definition of the chmap value like above (e.g. by allowing multiple
> assignments per channel in the definition block).  But whether to
> cover all flexible multiple outputs per channel, I hesitate to go
> forward...

I agree, I think it'd be too complex to cover every case purely in
channel mapping.

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM62cAAoJEFJkBDiqVpZ482AQAL0u6nI5OiGVGBq+G38EadR1
RPBGaUc+i/P5nl68pUv4fRLHeIw5D+9OSVuTjk+bqMPwTD1Fuxk1D1BEFRaTiMrH
G2DHnsSryAoJLBqYHdAg97slCvQW/XzMV5NLlpD0l0A90m0Yx7jNQyGT+EioIuCT
XDgKE2wZZgbBt0vAjOkUUWyVmWM02xzAfev3Gx09Wtx6ITFxd5l3Iu8PcbMSZY0f
6PCgXUXGFA4/m7eXHl4lW4x5fbjDcQ4hKcwb2bTL6OfLwrHg23wnj9YkkXRHqxQI
ijnQOY19g8NM4/SspHXV8JZT5K5lAj2WXQHDT/GyGl3dpszQUdeMSQbZdDT6/lef
3+cYsx7AMzn6ULk9b+S4PwwB/eHR2+K558Fx3tqd+HXMMD6lIFS51WvFUd1+8y64
ZsM1nNubIrZOqxwuAasFAjp8Tag4Boy41Pz7Ba2nIINa4gNaslwI17SUa4bk+XdS
priJxX40MO4RpxFXD64kEv7IvZnx4QSVe1Jzul7WufA/PRAQuFRiQUqqqquAKyCi
e7abhQ7L/yygATLDQAsLqKP0l/w3uuFb1cbWBhfj0c/hC5585MStBmioKQI/7Xw+
0QMJX4iDYqg9AzmhLOfkje644aq6Ca7fph664u38YkizbPrsc/PMsWC6boXPvKdM
GSPPz1AhV8kF9MJID6aG
=h+ou
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--

--===============0740402366428527983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0740402366428527983==--
