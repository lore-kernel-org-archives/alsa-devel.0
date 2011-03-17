From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to create alsa nodes?
Date: Thu, 17 Mar 2011 15:26:32 +0100
Message-ID: <4D821A18.30407@ladisch.de>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 93059243B5
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 15:24:57 +0100 (CET)
In-Reply-To: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: loody <miloody@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

loody wrote:
> In destop x86 system, the udev will automatically create the nodes in
> snd directory, such as pcmC0D0c, pcmC0D1c, etc.
> I try to let the usb sound device work on mips platform, but I have no
> idea what is the proper way to create these nodes.
> Should I
> 1. create them one by one by hand  from copying the attributes in my PC
>     (if I have 2 or more usb sound devices, I have to first plug them
> in pc and monitor the nodes)

This will not work if the device nodes' minor numbers are allocated
dynamically.

> 2. smarter way to do so?

GregKH would tell you that the smart way would be to run udev.  ;-)

To use static device nodes,
1) make sure that CONFIG_SND_DYNAMIC_MINORS is disabled,
2) use the snddevices script in the alsa-driver package.


Regards,
Clemens
