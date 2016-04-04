From: Rick Mann <rmann@latencyzero.com>
Subject: mcasp: stream has more channels (2) than are enabled
	in mcasp (0)
Date: Mon, 4 Apr 2016 01:59:45 -0700
Message-ID: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 4949F2608B3
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 10:59:47 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 5F7B2203AB
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 04:59:46 -0400 (EDT)
Received: from [192.168.15.26] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 060766801AE
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2016 04:59:45 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've got a Beaglebone Green with a custom cape (CODEC and amp and some other stuff).

Kernel 4.4.6-bone-rt-r6. When I load the overlay that should set up my CODEC in the device tree, I get the following in the log.

[  367.172337] davinci-mcasp 48038000.mcasp: stream has more channels (2) than are enabled in mcasp (0)
[  367.172374] davinci-mcasp 48038000.mcasp: ASoC: can't set 48038000.mcasp hw params: -22

You can see a little more log context, along with the DTS, here:

	http://pastebin.com/UPB1xjPF

Can anyone tell me what this means? Thanks!

-- 
Rick Mann
rmann@latencyzero.com
