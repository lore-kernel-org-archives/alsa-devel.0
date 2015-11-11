From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Wed, 11 Nov 2015 13:59:49 +0100
Message-ID: <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
 <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
 <564319CD.3070305@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A91EF26043A
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 13:59:51 +0100 (CET)
In-Reply-To: <564319CD.3070305@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 11 Nov 2015, Felipe Ferreri Tonello wrote:

> > But that is precisely the problem. The framework that manages the =

> > insertion and deletion of modules notes that my module has a usage coun=
t =

> > that is > 0 (in my case it is 2, which I'm convinced is because the car=
d =

> > has been registered with ALSA), and refuses to free the module. So ther=
e =

> > is now way any unregister_card call can be made when my module is freed=
, =

> > as due to the usage count it would never even be attempted.
> =

> Do you mean that unbind is never called? Well, the framework should call
> bind/unbind for each user of your module.

Ok, I didn't know that. It's the first time I've been writing an ALSA =

driver as a loadable module.

> How is your architecture? If you use one card for each probe of module
> then each bind should create one device, right?

In this case, it is a device which is located on the SoC. There is only =

one instance of it. When the module is loaded, it loads a codec driver =

with its associated DAI driver, a PCM driver, snd-soc-dummy-dai, and then =

a machine driver to tie it all together, finally registering the card with =

ALSA.

Looking in /sys/bus/platform/devices, there seems to be one device created =

for the codec itself, and one for the machine driver. I don't know if =

that's right or wrong, the ALSA driver hierarchy works in the sense that I =

can capture audio from it anyway.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
