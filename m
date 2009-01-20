From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 09:32:57 +0100
Message-ID: <49758C39.2060607@ladisch.de>
References: <20090120025727.GA30499@tango.0pointer.de>
	<49758B71.8090605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 41E51103800
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 09:32:58 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B5DE222FB07
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:32:57 -0500 (EST)
Received: from [10.1.2.151] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 461DC1ADFB
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:32:57 -0500 (EST)
In-Reply-To: <49758B71.8090605@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I wrote:
> After choosing hardware parameters, you can call
> snd_pcm_hw_params_is_block_transfer() to determine if the device
> transfers samples in comparatively large blocks.  (The wavetable and
> USB drivers set this flag.)

A quick grep over the kernel source shows that this flag is also set by
many drivers that shouldn't, so it isn't very reliable.


Best regards,
Clemens
