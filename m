From: Alexander Stein <alexanders83@web.de>
Subject: Re: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device
	tree support
Date: Fri, 19 Dec 2014 22:05:31 +0100
Message-ID: <1575490.9FSQKhfrcc@kongar>
References: <1418241578-17049-1-git-send-email-alexanders83@web.de>
 <20141219204254.GV4885@piout.net> <20141219204724.GW4885@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A2226051F
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 22:05:35 +0100 (CET)
In-Reply-To: <20141219204724.GW4885@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Friday 19 December 2014, 21:47:24 wrote Alexandre Belloni:
> On 19/12/2014 at 21:42:54 +0100, Alexandre Belloni wrote :
> > Hi,
> > 
> > On 10/12/2014 at 20:59:36 +0100, Alexander Stein wrote :
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id atmel_ac97c_dt_ids[] = {
> > > +	{ .compatible = "atmel,atmel_ac97c", },
> > 
> > I would use atmel,at91sam9263-ac97c, we never now, maybe they will have
> > another ac97 IP at some point in time ;)
> > 
> 
> This applies for the other patches, else I'm fine with the series.
> 
> Maybe you could add CONFIG_SND_ATMEL_AC97C=y in at91_dt_defconfig as all
> the other defconfigs have disappeared.

BTW: Shouldn't this be rather CONFIG_SND_ATMEL_AC97C=m since it is only applicable on a single microcontroller (AT91SAM9263). There is no need to compile this driver into the kernel on all at91 variants.

Best regards,
Alexander
