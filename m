From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: common way for hardware metering and monitoring
 between kernel/user land
Date: Tue, 05 Mar 2013 20:06:06 +0100
Message-ID: <5136421E.4090307@ladisch.de>
References: <513623A6.7070905@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F26772652C0
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 20:07:16 +0100 (CET)
In-Reply-To: <513623A6.7070905@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Now i'm working in kernel land to support Echo's Fireworks (TM) devices
> with better integration.
> [...]
> Well, now I need your advice about common ways for hardware metering and
> monitoring between kernel land and user land.

For almost all FireWire audio devices, it would not be possible to
create ALSA mixer controls that would allow to control the device in
a sensible way with a generic mixer application like alsamixer.  (Things
like matrix mixers, or meters integrated with corresponding volume
sliders.)  Therefore, custom mixer applications are required.

Because devices typically have most of their customizations in the way
in which they handle (mixer) controls, the FFADO guys and me have agreed
that the kernel driver handles only stuff required for audio streaming;
all other controls are accessed *only* from user space by going directly
through /dev/fw* (or through a hwdep device if the kernel driver and
userspace tools need to share a communication channel).

So for now, there's no integration needed in the kernel driver.


(I won't have time to test your driver before the next weekend.)


Regards,
Clemens
