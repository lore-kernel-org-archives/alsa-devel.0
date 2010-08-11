From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: VIA VT1708S
Date: Wed, 11 Aug 2010 08:14:26 +0200
Message-ID: <4C623FC2.8070701@ladisch.de>
References: <19374822.165450.1281361435671.JavaMail.www@wwinf8214>
	<AANLkTikP65ASMC4ChTcPH564EsK44wpZ1EndN83nvNGs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C34EE1037EC
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 08:14:53 +0200 (CEST)
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A255174D
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 02:14:51 -0400 (EDT)
Received: from [10.1.2.56] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3DEE0401518
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 02:14:51 -0400 (EDT)
In-Reply-To: <AANLkTikP65ASMC4ChTcPH564EsK44wpZ1EndN83nvNGs@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Niels Mayer wrote:
> The vt1708 "just works" with recent versions of linux kernels. On my
> system it calls itself "SB" (soundblaster?)

south bridge

> Also, some setups (like my ASUS_M4A78T-E mobo ) the vt1708S gives you
> a additional HDMI device you may never use, yet it uses an interrupt
> and an ALSA audio device.
> 
> ##  1 [SB             ]: HDA-Intel - HDA ATI SB
> ##                       HDA ATI SB at 0xfb7f4000 irq 16
> ##  2 [HDMI           ]: HDA-Intel - HDA ATI HDMI
> ##                       HDA ATI HDMI at 0xfb9fc000 irq 19

This is the audio-over-HDMI function of the ATI graphics card or the
integrated GPU.


Regards,
Clemens
