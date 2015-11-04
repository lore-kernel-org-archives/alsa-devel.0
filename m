From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Unregister a card from userspace?
Date: Wed, 4 Nov 2015 10:36:14 +0100
Message-ID: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D4F265347
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 44ED3181A7
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:15 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id EzJvPK7Vg3Xb for <alsa-devel@alsa-project.org>;
 Wed,  4 Nov 2015 10:36:14 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id C91CC181AD
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:14 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id A2306146C
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:14 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 9702F146B
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:14 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 9217C3E592
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 10:36:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


A sound card driver would normally call snd_soc_register_card() to =

register its sound card with ALSA.

Is there some way to unregister the card from userspace?

My use case is that I have a card driver I'm working on as a module, and =

while insmodding it works fine, I can't rmmod it because once =

snd_soc_register_card() has been called, it has a usage count of 2 and =

thus cannot be rmmod:ed.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
