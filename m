From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: building soc module drivers
Date: Wed, 25 Mar 2009 11:15:02 +0000
Message-ID: <20090325111502.GB20936@sirena.org.uk>
References: <49C9B27C.8040108@fmp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA0C6103853
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 12:15:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49C9B27C.8040108@fmp.fujitsu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geiger Ho <geiger.ho@fmp.fujitsu.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2009 at 12:26:36PM +0800, Geiger Ho wrote:

>   I would like to build the WM8510 SOC sound driver for my ARM platform. 
> After downloading alsa-driver-1.0.19, "./configure 
> --with-cross=arm-linux- --with-kernel=/home/source/linux-2.6.22.19 
> --with-build=/home/source/linux-2.6.22.19 --with-cards=all", and then 
> make. I get no wm8510.c compiled. What other stuff should I do to make 
> it compiled? Many thanks.

You need to either write a machine driver which uses the codec driver and
have the kernel configuration for that select the codec driver or select
SND_SOC_ALL_CODECS to build all the codec drivers if your module is not
part of your normal kernel sources.

See Documentation/sound/alsa/soc for an overview of the programming
model - there are many example machine drivers in the source.
