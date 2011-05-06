From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/12] ASoC: SSM2602: Do not power the
	codec up in probe
Date: Fri, 6 May 2011 11:00:32 +0100
Message-ID: <20110506100032.GE23729@opensource.wolfsonmicro.com>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
	<1304607560-15083-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB4F02436A
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 12:00:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304607560-15083-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 04:59:15PM +0200, Lars-Peter Clausen wrote:

>  static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
>  	0x0017, 0x0017, 0x0079, 0x0079,
> -	0x0000, 0x0000, 0x0000, 0x000a,
> +	0x0000, 0x0000, 0x009f, 0x000a,
>  	0x0000, 0x0000

This should reflect the power on reset defaults of the device.  If this
is not the case we should fix that, but it's a separate issue to
whatever the settings are.
