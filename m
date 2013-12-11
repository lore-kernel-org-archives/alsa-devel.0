From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb driver
Date: Wed, 11 Dec 2013 22:17:51 +0100
Message-ID: <52A8D67F.40108@ladisch.de>
References: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id ECAC8260202
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 22:18:48 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 233E0211D0
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 16:18:45 -0500 (EST)
In-Reply-To: <CAJUVNopomSJU_+WE8U8kjOP5Bh_670H2w=DTRLBF37fDsQfg4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Takejame <lucas@takejame.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lucas Takejame wrote:
> I was hoping that, since we only use one specific sound card and we won't
> need a generic driver, I could change something in the code to optimize it
> latency wise.

USB packets are transferred in frames (or microframes).  The driver already
allows to use a buffer with only two frames; you cannot go below this
hardware limit.


Regards,
Clemens
