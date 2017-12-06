From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Multiple codecs on the same DAI
Date: Wed, 6 Dec 2017 15:26:47 +0100
Message-ID: <alpine.DEB.2.11.1712061521180.22247@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
 <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
 <alpine.DEB.2.11.1712061352160.22247@lnxricardw1.se.axis.com>
 <20171206130323.GG1827@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 34A7526698E
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 15:26:55 +0100 (CET)
In-Reply-To: <20171206130323.GG1827@finisterre>
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


On Wed, 6 Dec 2017, Mark Brown wrote:

> On Wed, Dec 06, 2017 at 01:54:38PM +0100, Ricard Wanderlof wrote:
> =

> > How about non-sound devices, for instance if there is a chip solely for =

> > managing the microphone power but it's not actually part of the codec. =
Is =

> > it reasonable to bring it in as an aux device too, even though there's =

> > actually no sound going through it?
> =

> That just sounds like a regulator?  I'd expect that just to be used as a
> supply as normal.

You mean as a DAPM widget?

>  What audio specific control would this device be provdiing?

What it does provide is current sensing if the connected device draws too =

much power, although it does not automatically shut off the connected =

device if that is the case, so a small driver is required to shut down the =

output in the case of overcurrent. There's also a requirement to be able =

to read the overcurrent status. One approach is to implementet the whole =

thing as an auxilliary device, with one ALSA control to control the power, =

and a read only control to read the overcurrent status.

So, no, it's not really audio specific, and furthermore it's not just =

providing a power output the way a regulator would.

It could of course be implemented as a completely separate device, but =

hardware wise it is still an integrated part of the audio solution.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
