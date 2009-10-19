From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with newest alsa driver on 2.6.30 kernel
 -	unknown symbols
Date: Mon, 19 Oct 2009 08:14:48 +0200
Message-ID: <4ADC03D8.4050705@ladisch.de>
References: <000601ca5001$8f554540$adffcfc0$@de>
	<000b01ca500a$48ff0cd0$dafd2670$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F3391243AA
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 08:15:06 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8250AB16A9
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 02:14:49 -0400 (EDT)
Received: from [10.1.2.136] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 750544FFF2
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 02:14:47 -0400 (EDT)
In-Reply-To: <000b01ca500a$48ff0cd0$dafd2670$@de>
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

Christian Steffen wrote:
> while an older version of alsa drivers is working fine with my kernel
> 2.6.30, the newly compiled modules can't be inserted properly.
> I compiled snd-had-intel modules for my kernel 2.6.30 and tried to
> insert/start them.
> 
> [  106.209451] snd_hda_codec: Unknown symbol __snd_printk
> [  106.210340] snd_hda_codec: Unknown symbol snd_hwdep_new

You have to unload _all_ the old sound modules before loading the new
ones.


HTH
Clemens
