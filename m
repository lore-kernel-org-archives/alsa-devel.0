From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Thu, 29 Nov 2012 15:35:54 -0500
Message-ID: <p06240802ccdd6fe50ce5@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway01.websitewelcome.com (gateway01.websitewelcome.com
 [67.18.36.19]) by alsa0.perex.cz (Postfix) with ESMTP id 7313C2616DB
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 21:41:13 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway01.websitewelcome.com (Postfix) with ESMTP id CE9BB96BF04AE
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 14:35:57 -0600 (CST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Daniel (M) and Clemens,

I'd like to conclude this thread if I could. It seems clear that 
configuring our USB audio card's descriptor with a bInterval value of 
1 (a packet every microframe) was too aggressive, and was part of 
what caused the packet stuttering issue. (Right?)

We almost certainly should increase bInterval; I'll try 2, and if 
that seems stable will probably go to 3 (4 microframes) for some 
margin. However, I'm still concerned that the symptoms don't sound 
like a simple starvation issue, where I'd expect to have a missing 
frame every once in a while. Instead, we were seeing reliable 
operation interspersed with periods where lots of packets were being 
consistently omitted. To me, this suggests that there's some other 
issue going on, either in the USB stack or in the USB hardware itself.

Given that, I'm worried that increasing bInterval will just move the 
symptoms around, making it harder to duplicate but not truly becoming 
robust.


Any thoughts on this? Should I try chasing the issue into the Linux 
USB development mailing list, or will they just say "set bInterval to 
a larger value!"?


Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
