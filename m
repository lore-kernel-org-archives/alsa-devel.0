From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 23 Nov 2011 21:46:32 +0530
Message-ID: <1322064992.1516.311.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<20111123160253.GD30049@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CFDD103B06
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 17:20:04 +0100 (CET)
In-Reply-To: <20111123160253.GD30049@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-23 at 16:02 +0000, Mark Brown wrote:
> > +static int snd_compress_add_device(struct snd_compr *device)
> > +{
> > +     int ret;
> > +     struct snd_card *card;
> > +
> > +     ret = snd_card_create(SNDRV_DEFAULT_IDX1, device->name,
> > +                     THIS_MODULE, 0, &card);
> > +     if (ret < 0)
> > +             goto out;
> 
> It's a bit surprising that this is doing snd_card_create() - I'd
> expect
> a compressed device to be added as a subdevice on a card being passed
> in.  At least in the embedded case you'd normally get a card with a
> mix
> of PCM and compressed streams in one unified card.
ATM I am viewing the compressed card as a different one, but yes
logically speaking for embedded audio we can think of this as a single
card and use the same card here as well.
> 
> > +     mutex_init(&device->lock);
> > +     /* todo integrate with asoc */
> 
> The core code shouldn't know anything about ASoC, ASoC should be able
> to
> use the core API like any other card driver.
I was thinking that during the compress stream open, the core will
trigger the asoc to turn on the codec. For that purpose it needs to call
asoc, hence the comment.

Well this changes if we think asoc should use core API.
That way my lower level driver model changes:
	think of a cpu driver which registers cpu side with asoc and compressed
path with core here as compared to my initial thoughts on a compressed
driver outside asoc which registers the compressed ops with core and
acts as wrapper over dsp

-- 
~Vinod
