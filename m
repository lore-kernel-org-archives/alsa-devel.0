From: Rick Mann <rmann@latencyzero.com>
Subject: Enabling kernel debugging in sound before devices are
	loaded
Date: Thu, 1 Oct 2015 03:41:04 -0700
Message-ID: <F8E42AC6-44D9-4171-972F-AD39765728AE@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6A93326666D
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 12:41:06 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id C29FE204C5
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 06:41:05 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6F4C7C00014
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 06:41:05 -0400 (EDT)
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

I'm trying to enable kernel debug logging like this:

	# echo "file sound* +pflm" > /sys/kernel/debug/dynamic_debug/control

But it has no effect until after I load the Device Tree Overlay that creates my codec and sound card nodes. Unfortunately at this point, it's too late for the debugging to do any good.

This is with kernel 4.1.9 on a Beaglebone Black Debian Jessie distro.

I don't really know how the kernel dyndebug system works; I am able to enable other debugging locations, but none in sound/*

Appreciate any guidance. Thank you.

-- 
Rick Mann
rmann@latencyzero.com
