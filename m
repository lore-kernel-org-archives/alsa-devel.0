From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Tue, 14 Feb 2012 18:04:24 -0800
Message-ID: <20120215020423.GA25384@opensource.wolfsonmicro.com>
References: <4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de> <4F3A0B52.2010708@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1253634320965604861=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D3FE1039A1
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 03:04:29 +0100 (CET)
In-Reply-To: <4F3A0B52.2010708@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1253634320965604861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2012 at 08:20:50AM +0100, David Henningsson wrote:

Please delete irrelevant context from mails, it makes it much easier
to find what you've added,

> On 02/13/2012 06:40 PM, Takashi Iwai wrote:
> >Mark Brown wrote:

> >C. kctls contain unique names ([location] base [direction] [channel])
> >    optionally with TLVs

> I would vote for "C2", although I would probably prefer "[location]
> base [channel]" over "[location] base [direction] [channel]", as
> direction is superfluous given "base". This is also what the current
> implementation offers, and what I've based my PulseAudio patches on.

If we're going to do stuff like this Takashi's suggestion of splitting
direction from the channel seems like a really good idea, it both makes
things read naturallly and means applications are more likely to be able
to cope usefully with base types they've never heard of before.

> Also; as this graph exposing thing is unlikely to be implemented in
> all layers of the audio stack any time soon, maybe C2 is also the
> one that gives the most obvious matching between mixer kcontrols and
> jack kcontrols? I'd like to move in this direction; not only because
> we currently do not have the graph, but also because that even if we
> have it, userspace apps choosing not to implement it will have a
> good option.

The naming stuff gets really painful for anything that isn't a basic PC
audio card - the whole model used for the standard ALSA controls is very
much fixed to an extremely basic model of what the hardware might look
like.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOxKgAAoJEBus8iNuMP3d1yIQAJS++4lBI9PKeu+kA1O/YcNp
PvvB+9kKNjDamTTcLkyWwZ6pOkPOkvlrkugSg/Q74Y2t2MW9XztIx20oL70YhtLj
RcmbKq/iCmacan3/cb+k6WXkMW0coGJBTOsGJvijRLxA4r9qIjAHbUkZZBabjgt0
tbcQNAVLkm5LebtndESkPRUXA5AH5KYjNQK69OqGzqRGJh1M+uR/3z36ektwonim
+2nx+WjOEOFAVkSEr83vZb6DaQ5fScUHHHTWqrG7Ucwh4UINF3D3u6GX8qZML+Tw
OL283LHCJz1m8ZFu4W1Re77YJ/PbDJw2m+0vBpPxOiSVSCK0QIuWqY7dQLCoijSS
rxEXAY9wM1xDf24eTpGi6Zrc+x6C5RvybNzKiR28lJmJb2ncLvkM39lfJLVVx9YE
0wrNmAK8Vg0e8nVmlUxm6XpcH0eHbALVznQj+31872C8xUWa3ZOSVxI+++dlggSx
8MYYC8i8pozNVRBucQTWer5nEGB/mwIvpZJtv2xbfyGZv+mEi0b2UjYFPIriFfQH
BlU/DG1J/ufhreM/mD29HaZna1SuPOfd+c92Q+hX46AlWL+ljXR0y8lGRGHRvl/y
je4/liOs3j+K0tHZNfPqM12NCIgpIvXqzrlk63MwirZjOb2ITXKbQlO0sNAINyNx
jtzfQPX1L/8JJEw8Hgy+
=wJez
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============1253634320965604861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1253634320965604861==--
