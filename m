From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audinst HUD-mx2 covertly muting itself
Date: Thu, 31 Oct 2013 17:25:42 +0100
Message-ID: <52728486.2060506@ladisch.de>
References: <20131031101137.GA75354@skade.schwarzvogel.de>
 <52727D15.90907@ladisch.de> <20131031161517.GA53495@skade.schwarzvogel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E4B4D2656C8
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 17:26:09 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 64ED221C14
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 12:26:09 -0400 (EDT)
Received: from [192.168.42.174] (unknown [80.187.106.80])
 by mail.messagingengine.com (Postfix) with ESMTPA id BE17BC00E8D
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 12:26:08 -0400 (EDT)
In-Reply-To: <20131031161517.GA53495@skade.schwarzvogel.de>
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

Tobias Klausmann wrote:
> I have gotten a temporary workaround: use the secondary PCM
> device (hw:0,1) instead of the primary (hw:0,0)

Oops, I didn't notice that there are two devices.

The first PCM device is only for Dolby-encoded data, so muting the
analog output would be correct.

> Maybe something along the lines of PCI device "quirks" would be
> the right thing to do? I.e. swapping the two PCM devices from
> ALSA's point of view.

The driver should never make the non-PCM device the first one.


Regards,
Clemens
