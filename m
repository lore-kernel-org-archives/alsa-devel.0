From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Additions to simple-audio-card
Date: Wed, 13 Jan 2016 16:32:50 +0100
Message-ID: <alpine.DEB.2.02.1601131608080.4189@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E945260421
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 939B32E16E
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:52 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id a+BnH+lg3yuB for <alsa-devel@alsa-project.org>;
 Wed, 13 Jan 2016 16:32:51 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 7372D2E18E
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:51 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 4879F144F
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:51 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 3D3AD13C6
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:51 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 3B40834266
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 16:32:51 +0100 (CET)
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


I'm trying to use simple-audio-card in a system with an ADAU1361, as it =

seems that the basic functionality is what I need without resort to =

writing a specialized machine driver, however there are a couple of =

shortcomings related to my particular patch which I want to discuss before =

venturing off on a tangent:

1.
The ADAU1361 needs its PLL set up using snd_soc_dai_ops.set_pll, however =

simple-audio-card has no support for this. Would it be a good idea to =

augment simple-audio-card with this? After all, it does set_sysclk.

2.
simple-audio-card unconditionally uses clk_prepare_enable to start the
CPU DAI and CODEC DAI clocks. In the particular system I have here =

however, the clock hierarchy is not modelled in DT. I would rather make =

these calls conditional on the corresponding clk variable, i.e. if no =

clock has been defined for the DAI in question, no attempt is done to do =

clk_prepare_enable either.

3.
It would be nice if simple-audio-card could support off-codec widgets, =

e.g. switches that are not built into the codec, via the gpio framework. =

That is, you could set up ALSA controls which control a feature via gpio. =


I'm prepared to do the actual work, but it warrants a bit of discussion =

whether or not these things are a good idea to start with. If too much =

features are added to simple-audio-card it might not be so simple any =

more, on the other hand, it would do very nicely as a more and more =

general device tree based machine driver which is simple to use.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
