From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Thu, 12 Nov 2015 16:38:27 +0100
Message-ID: <alpine.DEB.2.02.1511121631560.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <5639EAFA.9060008@ladisch.de>
 <alpine.DEB.2.02.1511121402000.11990@lnxricardw1.se.axis.com>
 <56449377.2050409@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F59E265914
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 16:38:29 +0100 (CET)
In-Reply-To: <56449377.2050409@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On Thu, 12 Nov 2015, Lars-Peter Clausen wrote:

> The way it works is that the reference count for the modules of the
> individual components is incremented when they are bound to the card to
> ensure that they are not removed when still in use. This usually does not
> affect the reference count on the module of the card and you can still rm=
mod
> the module of the card which will unregister the card. This again drops t=
he
> reference count on the components and you can remove those modules as wel=
l.
> =

> In your case the components and the card are in the same module and you e=
nd
> up with a cyclic dependency. The card ensures that the reference count of
> the module for the components is incremented, which in this case is also =
the
> cards module, so the cards module reference count is non 0 and you can't
> rmmod the card module, which means the card won't be unregistered which
> means the references to the module wont be dropped.

Thanks Lars-Peter for that description. It seems that the solution (which =

is what Clemens and Felipe were actually suggesting) would then be to have =

two separate modules, one for the low level parts (codec, dai and PCM =

drivers) and one for the machine driver (containing the card =

registration).

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
