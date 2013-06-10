From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem using alsa to implement an Android dock
Date: Mon, 10 Jun 2013 14:02:34 +0200
Message-ID: <51B5C05A.9010804@ladisch.de>
References: <312118621.168631.1370854985139.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 883A32615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 14:02:41 +0200 (CEST)
In-Reply-To: <312118621.168631.1370854985139.JavaMail.root@openwide.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jeremy Rosen wrote:
> my problems arrive when both the dock mode and the accessory mode are
> enabled. in that case Alsa will not recognise the usb sound device exposed
> by android.

>       bInterfaceNumber        1
>       bInterfaceSubClass      Control Device
>       AudioControl Interface Descriptor:
>         baInterfaceNr           0
>         baInterfaceNr           1
>       bInterfaceNumber        2
>       bInterfaceSubClass      Streaming

This is a bug in the Android firmware: it says that the audio driver
should look at interfaces 0 and 1, but the actual audio interfaces are
1 and 2.

I'll look into this ...


Regards,
Clemens
