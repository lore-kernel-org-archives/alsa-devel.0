From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is period_size, buffer_size and boundary size,
 i confuse them
Date: Sun, 09 Dec 2012 17:22:27 +0100
Message-ID: <50C4BAC3.4030300@ladisch.de>
References: <65bdafa4.4e24.13b8019be47.Coremail.l9jj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 931D2264F15
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 17:22:53 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B1C952085B
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 11:22:52 -0500 (EST)
Received: from [192.168.42.150] (unknown [46.115.75.160])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2339C8E0115
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 11:22:51 -0500 (EST)
In-Reply-To: <65bdafa4.4e24.13b8019be47.Coremail.l9jj@163.com>
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

l9jj wrote:
> can anyone help me to figure out  the concepts between period_size ,buffer_size and boundary size?
> n * period_size = buffer_size?

Yes.  On many devices, n is not required to be an integer.

> m * buffer_size = boundary_size?

Yes, where m is very big.  In applications, the actual value of the boundary
size does not matter (except as a special value for some sw params).

> and how the dma buffer mapped to the alsa buffer?

The DMA buffer _is_ the ALSA buffer.


Regards,
Clemens
