From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Thu, 25 Nov 2010 21:32:54 +0000
Message-ID: <20101125213145.GB25162@opensource.wolfsonmicro.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<1290712703.3302.41.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D8D4103988
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:32:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290712703.3302.41.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 07:18:23PM +0000, Liam Girdwood wrote:
> On Thu, 2010-11-25 at 17:47 +0200, Jarkko Nikula wrote:

> > +	struct snd_soc_aux_dev *aux_dev;
> > +	int num_aux_devs;
> > +	struct snd_soc_pcm_runtime *rtd_aux;
> > +	int num_aux_rtd;

> Could we not just make this a new component type and have a list of aux
> devices ?

I'd certainly rather we didn't have to deal with the PCM runtime data
since obviously the main feature of these things is that there's no PCM
involved.  Need to review this properly to remind myself why we're doing
this...

> > +	/* find CODEC from registered CODECs*/
> > +	list_for_each_entry(codec, &codec_list, list) {
> > +		if (!strcmp(codec->name, aux_dev->codec_name)) {
> > +			if (codec->probed) {
> > +				dev_err(codec->dev,
> > +					"asoc: codec already probed");
> > +				ret = -EBUSY;
> > +				goto out;
> > +			}
> > +			break;
> > +		}
> > +	}

> Why do aux devices need to be coupled with CODECs here ? 

The way we've got things set up currently the CODEC isn't really just a
CODEC, it's got a bunch of other random services which are more generic
chip services associated with it like the register cache and the bias
management.  There's so much overlap between the devices that I'm not
sure that it's really worth splitting the types up too much at the root
level (CODEC is pretty much a superclass that has everything on it but
DMA).

Given how widely used snd_soc_codec is I'm not sure it's worth fixing
the naming thing here, especially since 99% of the time the device is
actually a CODEC.
