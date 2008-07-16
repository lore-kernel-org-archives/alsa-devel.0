From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Is params_format() valid in the _hw_params()
	function?
Date: Wed, 16 Jul 2008 10:40:50 +0200
Message-ID: <487DB412.2090105@ladisch.de>
References: <487D1FCA.9030605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 8B7882439C
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 10:40:54 +0200 (CEST)
In-Reply-To: <487D1FCA.9030605@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> My ASoC driver programs the sample size in the _prepare() callback function,
> because I was under the impression that the sample size cannot be known in the
> _hw_params() callback function.  However, I just ran a test, and it appears that
> the params_format() macro does return the right value.  Once I know the format,
> I can determine the same size.
>
> Is this always true, even in OSS emulation?

Yes.  The OSS emulation pretends to be an ALSA application.

> I know very little about ALSA and OSS application programming, so I
> don't know what causes _hw_params() to be called vs. _prepare().

*_hw_params() is called to set sample format/rate and buffer parameters.
In most cases, it is called once when the device is initialized, but it
can be called multiple times if an application wants to change some of
these parameters.  (The latter happens with OSS emulation because the
various OSS ioctl calls change only one of multiple parameters.)

*_prepare() is called before a device is started.  It can be called
multiple times without intervening _hw_params() calls when the device
is started/stopped multiple times.


HTH
Clemens
