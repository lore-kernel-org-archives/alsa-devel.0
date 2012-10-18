From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Interleaved or Non-interleaved?
Date: Thu, 18 Oct 2012 11:11:47 +0200
Message-ID: <507FC7D3.4050200@ladisch.de>
References: <CAA2DH4sexxhLRRZzA6_-nFbY2P+VBLXX_aqcb6u5=13NJAKTaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 4410B2625FC
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 11:13:05 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BFA7D208B0
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 05:13:04 -0400 (EDT)
Received: from [192.168.42.195] (unknown [46.115.34.159])
 by mail.messagingengine.com (Postfix) with ESMTPA id 249F6482539
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 05:13:02 -0400 (EDT)
In-Reply-To: <CAA2DH4sexxhLRRZzA6_-nFbY2P+VBLXX_aqcb6u5=13NJAKTaQ@mail.gmail.com>
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

Prasant J wrote:
> My sound hardware supports only interleaved audio.
>
> I'm writing an alsa application. Which access method will be more
> performing : interleaved or non-interleaved?

With interleaved, samples can be copied from/to your application's
buffer in one big block.  With non-interleaved, samples must be
copied individually.


Regards,
Clemens
