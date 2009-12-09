From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to use soc API without codec driver
Date: Wed, 9 Dec 2009 10:45:02 +0000
Message-ID: <20091209104502.GC17832@opensource.wolfsonmicro.com>
References: <4B1E66DD.1000906@heig-vd.ch> <20091208145104.GC9018@sirena.org.uk>
	<4B1F4617.1020307@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BCEF2465F
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 11:45:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B1F4617.1020307@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Garnier <marc.garnier@heig-vd.ch>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 07:39:19AM +0100, Marc Garnier wrote:
> You mean I just have to use snd_soc_register_dai()? Things like  
> soc_init_card() and snd_soc_new_pcms() are not mandatory?

init_card() has been removed now, but new_pcms() is still required -
like I say, look at one of the existing drivers like the spdif
transciever driver for examples of drivers which do what you're trying
to do here.

> static int __init q2686_modinit(void)
> {
>    return snd_soc_register_dai(&q2686_dai);
> }
> module_init(q2686_modinit);

This should be done from a platform device, not from module init.
