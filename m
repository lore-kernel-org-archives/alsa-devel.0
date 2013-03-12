From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Tue, 12 Mar 2013 08:55:55 +0100
Message-ID: <513EDF8B.6000504@ladisch.de>
References: <20130305220303.GD20417@pvv.ntnu.no>
 <20130311213908.GP20417@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B5E2E265CFD
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 08:55:59 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 510CC20C44
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 03:55:57 -0400 (EDT)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id DBBCDC80E8A
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 03:55:56 -0400 (EDT)
In-Reply-To: <20130311213908.GP20417@pvv.ntnu.no>
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

Torstein Hegge wrote:
> There are still some issues with the Schiit Bifrost as described by
> Chris Hermansen in "Status of CM6631 USB" on alsa-user [1]. While the
> workaround fixes the sample rate change issue in some cases, he still
> sometimes get mangled audio on sample rate change.
>
> Any ideas on what could be causing this difference between seemingly
> similar hardware would be appreciated.

Different firmware.

> One difference is that 'lsusb -v' from the Schiit Bifrost [2] lists
> interface 2-5, 7 and 8. My Corda [3] and the Asus card only lists
> 0, Audio, Control Device
> 1, Audio, Streaming
> 2, Human Interface Device (this is number 6 in the Schiit)
>
> The extra interfaces listed by the Schiit is probably not backed by any
> hardware in the CM6631.

Does the Schiit have all those Line/Mic/SPDIF/MIDI ports?


Regards,
Clemens
