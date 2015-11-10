From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Tue, 10 Nov 2015 08:55:48 +0100
Message-ID: <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ACE2260591
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 08:55:51 +0100 (CET)
In-Reply-To: <56408259.2030604@felipetonello.com>
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


On Mon, 9 Nov 2015, Felipe Ferreri Tonello wrote:

> > while insmodding it works fine, I can't rmmod it because once
> > snd_soc_register_card() has been called, it has a usage count of 2 and
> > thus cannot be rmmod:ed.
> =

> You have to unregister that card upon freeing your module.

But that is precisely the problem. The framework that manages the =

insertion and deletion of modules notes that my module has a usage count =

that is > 0 (in my case it is 2, which I'm convinced is because the card =

has been registered with ALSA), and refuses to free the module. So there =

is now way any unregister_card call can be made when my module is freed, =

as due to the usage count it would never even be attempted.

I suppose one way would be to have a specific call into the module which =

unregisters the card, and the module could then be freed as usual =

afterwards, but it seems like a bit of a hack.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
