From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Multiple codecs on the same DAI
Date: Wed, 6 Dec 2017 13:54:38 +0100
Message-ID: <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 709E4266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:54:45 +0100 (CET)
In-Reply-To: <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Fri, 24 Nov 2017, Mark Brown wrote:

> On Fri, Nov 24, 2017 at 03:21:24PM +0100, Ricard Wanderlof wrote:
> =

> > In a sense, what I'd want would be to bring in the S/PDIF receiver as a =

> > codec driver, but separate from the ordinary chain of sound drivers =

> > (codec, platform, etc). I suppose one way would be to somehow (via =

> > platform data or DT) pass a reference to the S/PDIF receiver to the =

> > machine driver, which would then somehow convert this to a snd_soc_code=
c =

> > *, and then have it explicitly call the the snd_soc_codec_driver.probe =

> > function set up by the S/PDIF receiver driver to initialize it much the =

> > way ALSA would have done if it had been part of a dai_link for card. =

> =

> You can just register any CODEC device as an aux_dev, that seems to be
> exactly what you're looking for.

Ah, thanks. Yes, having tried it now it does indeed seem to be what I =

need.

How about non-sound devices, for instance if there is a chip solely for =

managing the microphone power but it's not actually part of the codec. Is =

it reasonable to bring it in as an aux device too, even though there's =

actually no sound going through it?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
