From: Rick Mann <rmann@latencyzero.com>
Subject: Driver for audio power amplifier ICs?
Date: Thu, 1 Oct 2015 01:49:51 -0700
Message-ID: <999B71E1-5FDB-4EFD-8E69-975C8A09A0C7@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0398626042B
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 10:49:53 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 8A1D2204B9
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 04:49:52 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3681DC0001D
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 04:49:52 -0400 (EDT)
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

I've been working on this Beaglebone Black custom audio cape. It has a tlv320aic3104 codec (that I'm still trying to get working properly), and connected to its line outs is a tpa3140d2 analog 2x10W power amplifier. This chip has very little in the way of CPU interface, but it does have /shutdown and /fault lines.

I'm wondering how ALSA becomes aware of that chip, in order to enable it when it enables certain routes in the tlv320aic3104, and to inform application software if the /fault line asserts.

I don't mind writing a driver, if necessary, I just don't know where such a thing would fit. I also wonder what the device tree entries for the amp might look like.

Thanks!

-- 
Rick Mann
rmann@latencyzero.com
