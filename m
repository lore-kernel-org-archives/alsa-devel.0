From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is period_size, buffer_size and boundary size,
 i confuse them
Date: Mon, 10 Dec 2012 09:24:37 +0100
Message-ID: <50C59C45.7040109@ladisch.de>
References: <5ec59db3.354.13b83dc3158.Coremail.l9jj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 0600C265086
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 09:24:39 +0100 (CET)
In-Reply-To: <5ec59db3.354.13b83dc3158.Coremail.l9jj@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: l9jj@163.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

l9jj@163.com wrote:
> does  the variable buffer_size equal to  DMA size?

Yes.

> (2)how the pos>buffer_size will happen in the interface snd_pcm_update_hw_ptr0()?

It happens when your driver has a bug.  The .pointer callback always must
return value that is inside the DMA buffer.


Regards,
Clemens
