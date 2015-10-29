From: Rick Mann <rmann@latencyzero.com>
Subject: Noise in tlv320aic3104-based audio system
Date: Thu, 29 Oct 2015 00:59:48 -0700
Message-ID: <2C04C84B-D0DC-40F6-9E5C-0BE659ABD7CA@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 93D63261AD0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 08:59:50 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id D1F08205FD
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 03:59:49 -0400 (EDT)
Received: from [192.168.15.51] (c-50-168-55-93.hsd1.ca.comcast.net
 [50.168.55.93])
 by mail.messagingengine.com (Postfix) with ESMTPA id 768146800D5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 03:59:49 -0400 (EDT)
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

I have a custom cape on a Beaglebone Black that uses a tlv320aic3104, connected to a tpa3140d2 audio power amp. I currently manually control the /shudown pins on the two ICs, and just turn them on before doing anything else.

The system works. But I notice that when I open the output device for writing (via libao), I immediately hear hiss, even before I send any samples to the device. After I close the libao audio device, a few seconds later Linux sends some i2c commands to the tlv320 and it's once again silent.

The perceived amplitude of this hiss does not seem to be affected by "amixer set PCM <0 - 127>" calls.

Does anyone have any idea where this noise might be coming from? Is it just thermal or other noise in the routing of audio within the tlv320? Is there some configuration or routing I might be able to change to avoid it? Did I screw up somewhere in my circuit design or layout that only manifests when linux configures the chip for operation?

Any ideas are appreciated. Thanks.

-- 
Rick Mann
rmann@latencyzero.com
