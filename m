From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: ASoC: Device tree binding to dummy codec
Date: Sat, 26 Jul 2014 11:18:27 -0400
Message-ID: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 37A73261685
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 17:18:28 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id gl10so3945656lab.40
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 08:18:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Allwinner CPUs have an on-chip codec that supports line out. This is a
monolithic block that does not implement anything like standard I2S.
We have implemented this by internally making a soc_card and then
binding the DAI to a dummy NOP codec to make ASoC happy.

But now someone wants to add a MAX9768 amplifier which needs a codec
driver to implement volume control.

So how should this be implemented? You want to use simple-audio-card
when the MAX9768 is present.

But what about the dummy-codec case? Using simple-audio-card to bind
to a dummy-codec clutters things up a lot. Plus the dummy-codec is not
currently exposed to device trees.

And then there is the ordering problem, how do I know for sure MAX9768
is not going to be bound so that it is safe to bind to dummy-codec.
Or should binding to MAX9768 simply override a binding to the
dummy-codec?

If my dummy-codec is exposed into the device trees then this generates
a bunch of NOP clutter in the tree using simple-audio-card to bind it.

Another idea, maybe one of those NOP SDPIF codecs could get an alias
name like NOP or Dummy.

-- 
Jon Smirl
jonsmirl@gmail.com
