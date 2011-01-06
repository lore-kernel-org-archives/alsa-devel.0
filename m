From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Thu, 06 Jan 2011 16:53:26 +0000
Message-ID: <1294332806.19933.5.camel@dplaptop.localdomain>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D50CF244CC
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 17:53:34 +0100 (CET)
In-Reply-To: <AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-05 at 15:04 -0600, Timur Tabi wrote:
> Which is this line:
> 
> > @@ -3463,6 +3464,19 @@ int snd_soc_register_codec(struct device *dev,
> >
> >        /* allocate CODEC register cache */
> >        if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
> > +               reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
> > +               /* it is necessary to make a copy of the default register cache
> > +                * because in the case of using a compression type that requires
> > +                * the default register cache to be marked as __devinitconst the
> > +                * kernel might have freed the array by the time we initialize
> > +                * the cache.
> > +                */
> > +               codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
> > +                                             reg_size, GFP_KERNEL);

The semantics behind this code is that if the driver provides a
reg_cache_size and a reg_word_size it *should* provide a defaults
register cache as well.  If you want to manage your own register cache
in the driver which is not advised, you will have to add similar
functionality in your _priv struct.  If you require more flexible
functionality you need to consider implementing a sensible strategy and
submitting it as a patch.

Thanks,
Dimitris
