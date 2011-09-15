From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Thu, 15 Sep 2011 11:28:03 +0000
Message-ID: <4E71E142.1090301@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1316003710.3229.14.camel@odin> <4E7121DC.908@freescale.com>
	<20110915102643.GE7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) by alsa0.perex.cz (Postfix) with ESMTP id 7026F2450A
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 13:30:35 +0200 (CEST)
In-Reply-To: <20110915102643.GE7988@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <0AB87A227E196C45946FFB9CA598E88F@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tabi Timur-B04825 <B04825@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> >  	dev_err(codec->dev, "Unsupported sample size: %i\n", i);

> There's no meaningful cost in calling the function twice

Perhaps.

 > and it'd be
> much more legible to do so.

Well, I just don't agree with that.  It's pretty obvious what 'i' is.

-- 
Timur Tabi
Linux kernel developer at Freescale
