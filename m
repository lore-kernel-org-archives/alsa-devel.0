From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Thu, 12 Nov 2015 14:07:41 +0100
Message-ID: <alpine.DEB.2.02.1511121402000.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <5639EAFA.9060008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 47693264F2F
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 14:07:43 +0100 (CET)
In-Reply-To: <5639EAFA.9060008@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 4 Nov 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > My use case is that I have a card driver I'm working on as a module, and
> > while insmodding it works fine, I can't rmmod it because once
> > snd_soc_register_card() has been called, it has a usage count of 2 and
> > thus cannot be rmmod:ed.
> =

> soc_probe_component() adds a reference to each component's driver's
> module.  Maybe putting each component into its own module would help.

I'd rather not as there's no real gain from it (the constituent drivers =

cannot be used separately or in any other combination), but perhaps that =

is the only way to go.

> Anyway, you should be able to unbind the driver:
> <https://lwn.net/Articles/143397/>

Yes, that works. After unbinding the driver, the usage count drops to 0, =

and I can successfully rmmod it. So at least that's a workable solution.

It just seems to me that there's something I must have missed, as there =

should be a mechanism to do this automatically when a module containing a =

driver is rmmod'ed.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
