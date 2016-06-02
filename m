From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Thu, 2 Jun 2016 19:40:14 +0100
Message-ID: <20160602184014.GR2282@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia>
 <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
 <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
 <20160602171753.GQ2282@sirena.org.uk>
 <CAG5mAdwp2DEeFk6pwe6n65iQHHzzyiNPx1QTz3u2rUsQRUpNEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8411991214077973583=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AAE8726519F
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 20:40:27 +0200 (CEST)
In-Reply-To: <CAG5mAdwp2DEeFk6pwe6n65iQHHzzyiNPx1QTz3u2rUsQRUpNEA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============8411991214077973583==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fqIB0bRxfTYxTb/F"
Content-Disposition: inline


--fqIB0bRxfTYxTb/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 02, 2016 at 10:40:58AM -0700, Caleb Crome wrote:
> On Thu, Jun 2, 2016 at 10:17 AM, Mark Brown <broonie@kernel.org> wrote:

> > Well, if you specifically mean TDM as opposed to multi-channel our
> > general support for that isn't good (mainly due to lack of demand).  It
> > sounds like you're more interested in multi channel here though.

> I must be missing something.  To me, TDM is synonymous with
> multi-channel on a single wire. The datasheets of codecs and SoCs

TDM, at least in the sense Linux is using it, is multiple *unrelated*
audio streams on a single wire.  Any multi-channel audio stream is TDM
in some sense but the trivial extension to add two or more channels
isn't really a big deal.  This is for things more complex than just
stuffing more bytes of data onto a wire where there are going to be some
timeslots that the device should ignore as they're going to/from other
devices (or at least other streams even if the same chip is handling
them).

> (I recall there is also a specific TDM format with something like 384
> slots per frame, which is a well defined thing, but that's not what
> I'm talking about.  That's used just for telephony I beleive).

You're thinking of H.1x0 CTBus which is genuine TDM, used for routing
single channel audio streams between multiple PCI (H.100) or cPCI
(H.110) cards in a system.  It does way more than 384 slots, 4096
8kHz 8 bit timeslots IIRC.

> What's the linuxy name for what the datasheets call TDM format with
> slots > 2?  Do we just call that 'multi-channel', or specifically say,
> 'channels_max > 2'?  I was always under the assumption that's what TDM
> meant.

We don't particularly call it anything, it's such a trivial extension.

--fqIB0bRxfTYxTb/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUH2GAAoJECTWi3JdVIfQe5MIAIDREiQ3X0kvGPz++JcJpEqt
/Ng6JWwxBjaPW0nXIXoXWLxnP7TmHYkul6H1Terw14zYfiZjZIv60vi/kXqsdcU3
Yb8albZpi+Pj5wG4HJq2HHtSTYb1lFs28ZF6dun1bZRkEnq/moxhMp5slywudCX/
NeXSZe+IhhemlzZBusLlhueNzTwTTCdmUtfmKMsnb1YW0IJpYM+Q3jexc6NKRsET
cfUj/3HpYVY4kE64oehS31R973AnDPlJLTzpwI8PVf8G2+N6J5V7hnIewoA+4dWQ
5hRYdve2de9HMwJ6nkeQsu/crHWuzKc8Dw/tkC2/gtJwIKhrDRQH9HO8ESlfz5I=
=P24w
-----END PGP SIGNATURE-----

--fqIB0bRxfTYxTb/F--

--===============8411991214077973583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8411991214077973583==--
