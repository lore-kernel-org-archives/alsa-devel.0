From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device
	tree support
Date: Fri, 19 Dec 2014 22:10:34 +0100
Message-ID: <20141219211034.GE4885@piout.net>
References: <1418241578-17049-1-git-send-email-alexanders83@web.de>
 <20141219204254.GV4885@piout.net> <20141219204724.GW4885@piout.net>
 <2077365.97bOqiEeM9@kongar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id D5BE226051F
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 22:10:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2077365.97bOqiEeM9@kongar>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexanders83@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On 19/12/2014 at 21:51:01 +0100, Alexander Stein wrote :
> On Friday 19 December 2014, 21:47:24 wrote Alexandre Belloni:
> > On 19/12/2014 at 21:42:54 +0100, Alexandre Belloni wrote :
> > > Hi,
> > > 
> > > On 10/12/2014 at 20:59:36 +0100, Alexander Stein wrote :
> > > > +#ifdef CONFIG_OF
> > > > +static const struct of_device_id atmel_ac97c_dt_ids[] = {
> > > > +	{ .compatible = "atmel,atmel_ac97c", },
> > > 
> > > I would use atmel,at91sam9263-ac97c, we never now, maybe they will have
> > > another ac97 IP at some point in time ;)
> > > 
> > 
> > This applies for the other patches, else I'm fine with the series.
> 
> Is this an
> > Acked-By Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ?

Yes :)

> 
> > Maybe you could add CONFIG_SND_ATMEL_AC97C=y in at91_dt_defconfig as all
> > the other defconfigs have disappeared.
> 
> Sure, I'll add both suggestions and respin nother round next week.
> 
> Best regards,
> Alexander
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
