From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: spi codec names in machine drivers
Date: Thu, 31 Mar 2011 06:20:17 +0900
Message-ID: <20110330212016.GC20496@opensource.wolfsonmicro.com>
References: <AANLkTi=Vtzxu5pzaActNXc0J1ssbS1djrTfbKnBd3Gq=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA4FD1039FD
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 23:20:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Vtzxu5pzaActNXc0J1ssbS1djrTfbKnBd3Gq=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2011 at 02:05:04AM -0400, Mike Frysinger wrote:
> after the recent multi-component patch, spi codec names were changed
> to "<name>.<spics>" in the machine drivers.  so if we have an ad193x
> codec on spi bus 0 cs 5, the name is now "ad193x.5".
> 
> this also seems to be how fmt_single_name in soc-core.c is doing
> things.  am i reading this right ?
> 
> what if i have two codecs on two different spi busses but happen to
> have the same cs ?  shouldnt the spi code do the same as i2c and
> include the bus in the id naming ?

I think we should just switch to using dev_name() everywhere.
