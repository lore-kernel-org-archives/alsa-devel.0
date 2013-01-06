From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sun, 06 Jan 2013 18:42:03 +0100
Message-ID: <50E9B76B.5030107@ladisch.de>
References: <p06240802ccdd6fe50ce5@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EC90F262634
 for <alsa-devel@alsa-project.org>; Sun,  6 Jan 2013 18:42:47 +0100 (CET)
In-Reply-To: <p06240802ccdd6fe50ce5@[192.168.1.8]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sorry for the delay.

Daniel Griscom wrote:
> I'd like to conclude this thread if I could. It seems clear that
> configuring our USB audio card's descriptor with a bInterval value of
> 1 (a packet every microframe) was too aggressive, and was part of what
> caused the packet stuttering issue. (Right?)

Yes.

> We almost certainly should increase bInterval; I'll try 2, and if that
> seems stable will probably go to 3 (4 microframes) for some margin.
> However, I'm still concerned that the symptoms don't sound like
> a simple starvation issue, where I'd expect to have a missing frame
> every once in a while. Instead, we were seeing reliable operation
> interspersed with periods where lots of packets were being consistently
> omitted. To me, this suggests that there's some other issue going on,
> either in the USB stack or in the USB hardware itself.

The starvation seems to be in either the memory controller or in the
coherence traffic between the MC and the CPU cache.  I'd guess that
something else does enough I/O to affect this.

As I've already said, the pattern could be explained by some memory
read packet arriving too late at the USB controller, thus not only
making it impossible to send the current packet, but also delaying the
memory accesses of the next packet.

> Given that, I'm worried that increasing bInterval will just move the
> symptoms around, making it harder to duplicate but not truly becoming
> robust.

You could try to trigger the problem by doing many memory access (more
than fit into the cache), or by doing I/O through other PCI devices.

But if increasing bInterval works, you can be sure that some effect of
the increased USB transaction management is responsible for the problem.


Regards,
Clemens
