From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Multiple codecs on the same DAI
Date: Thu, 7 Dec 2017 12:31:12 +0100
Message-ID: <alpine.DEB.2.11.1712071230120.22247@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
 <20171206130323.GG1827@finisterre>
 <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
 <20171206154552.iqcdtyhuj7oyfwcg@sirena.org.uk>
 <alpine.DEB.2.11.1712070841040.22247@lnxricardw1.se.axis.com>
 <20171207112016.bkiw2gi4pcmvendr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A80742670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 12:31:19 +0100 (CET)
In-Reply-To: <20171207112016.bkiw2gi4pcmvendr@sirena.org.uk>
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


On Thu, 7 Dec 2017, Mark Brown wrote:

> On Thu, Dec 07, 2017 at 08:47:03AM +0100, Ricard Wanderlof wrote:
> > On Wed, 6 Dec 2017, Mark Brown wrote:
> =

> > > That does sound like an auxiliary device that's a regulator consumer.
> =

> > So essentially one would register this device as an auxiliary device, =

> > which would define a DAPM widget which in turn would be part of a DAPM =

> > route in the encompassing machine driver?
> =

> Or register a device that consumes the regulator and maps it into ASoC
> like that.

Do you offhand know of an example of such an external regulator =

implementation in the soc tree that I could look at to see how it all fits =

together?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
