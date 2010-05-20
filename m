From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 20 May 2010 16:50:12 +0200
Message-ID: <4BF54C24.8080908@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>	
	<4BDABDDD.4050502@ladisch.de>	
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>	
	<s5hsk5uq4u4.wl%tiwai@suse.de>	
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 895802444C
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 16:50:39 +0200 (CEST)
In-Reply-To: <AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> Still some work to be done on the alsa-lib one, for some reason the
> hw_param->flags field I used gets overwritten if I don't use the
> hw_device.

In the plugins, the are separate hw_params structures for the slave and
the virtual device; the *_schange and *_cchange function are responsible
for copying parameters from one to the other.  These functions currently
do not copy the flags field.


Regards,
Clemens
