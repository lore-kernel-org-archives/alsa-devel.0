From: Matthijs ten Berge <tenbergemh@yahoo.com>
Subject: support for RME HDSPe RayDAT
Date: Wed, 25 Jun 2008 20:35:25 +0200
Message-ID: <48628FED.7090305@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep32-int.chello.at (viefep32-int.chello.at [62.179.121.50])
	by alsa0.perex.cz (Postfix) with ESMTP id E598124422
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 20:35:45 +0200 (CEST)
Received: from dhcp-077-251-207-003.chello.nl ([77.251.207.3])
	by viefep32-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP id
	<20080625183526.YGNK3605.viefep32-int.chello.at@dhcp-077-251-207-003.chello.nl>
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 20:35:26 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

<intro:>
As you might already know, RME has released a successor for the HDSP
9652, the HDSPe RayDAT
(http://www.rme-audio.de/en_products_hdspe_raydat.php). It is based on
the 9652's design, with some new/changed features (e.g. more channels
and lower latencies), but the most important hardware change is that it
is now a PCI-express card.

I'm currently in the process of choosing which audio interface to buy,
the 'old' HDSP 9652 or the new RayDAT (I haven't found any other card
with 3 or more ADAT in/outs in the same price range or below, but
suggestions are welcome).
Of course I can stay on the safe side and opt for the HDSP 9652, which
has stable and complete driver support (right, eh?).
But on the other hand the RayDAT has better features and future, but
without the guarantee that it is or will be supported it can only serve
as a very costly paper weight (and not even a good one I suppose).

I wrote an e-mail to RME, but a bit too early, the card was not released
at that moment. See below for their reply.

<question:>
Are there any plans to add support for the RME RayDAT to the HDSP
driver/tools? Or perhaps somebody is already working on it right now? It
is not mentioned in the Wiki matrix atm.
I wish I could just do it myself, but (concerning kernel programming) I
never did more than a 'hello world' kernel module, so I don't think this
would be a good idea... (I do have coding experience, but not in-kernel).
>From the mailings on this list I can see that it can sometimes take
quite a while to get a driver fully debugged, how are the experiences
with RME cards?

I am aware that my e-mail might appear to be a crude 'I want to order a
pizza asap, at what time will the delivery boy arrive?'-like question.
Please see it more like a generic inquiry on the status and likelyness
of things.


Thanks and cheers,

Matthijs ten Berge


---
Original message, dated 15/04/2008 (answer from RME):
---

Hello,

> The RayDAT would be my preferred choice, because of the PCI-express
> interface, but is it supported by any of the ALSA drivers?
> I have seen that the HDSP9652 is supported by the hdsp alsa driver
> rather well, but how about the RayDAT?

The RayDAT is not yet released, and I'm afraid I can't say much about
the current status of ALSA development (if any).

> In case the RayDAT is not supported, are you then willing to provide
> information about the technical differences between the two cards, so
> the alsa hdsp driver can be updated/extended?

This will certainly be the case as soon as the card is released.


Regards,
Daniel Fuchs
RME
