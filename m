From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Different codecs for playback and capture?
Date: Wed, 3 Jun 2015 13:06:36 +0200
Message-ID: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 30D3326058B
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 77AB92E0D0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:45 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id gCqwaqv490uB for <alsa-devel@alsa-project.org>;
 Wed,  3 Jun 2015 13:06:44 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id E20052E09D
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:39 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id C0BAE140A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:39 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id B084812DA
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:39 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id AE3B23E049
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:06:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

I'm developing a machine driver for a system where we have two different =

codecs for input and output, connected to the same I2S interface. Normally =

a machine driver specifies which codec the I2S interface is connected to, =

but in this case there should really be two different ones, one for record =

and one for playback. I'm working on how to put this together, and just =

thought I'd try and get some input before going too far down the wrong =

track. The options I see are:

1. Specify two different codecs in the machine driver. Since one can =

specify several dai_links this would seem to be doable, however, I'm not =

sure ALSA can handle two codecs sharing a single CPU DAI in this way?

2. Use two separate machine drivers, one for each codec? Again, sharing a =

single CPU DAI would seem to be an issue here?

3. Write a special codec driver that is a merge between the two codecs, =

one for input and one for output. Seems like a bit of a hack, but should =

be possible.

Any spontaneous thoughts?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
