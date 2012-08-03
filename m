From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Fri, 03 Aug 2012 15:50:22 +0530
Message-ID: <1343989222.1726.14445.camel@vkoul-udesk3>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
 <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
 <20120802180926.GL4537@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 600AC26607C
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2012 12:19:12 +0200 (CEST)
In-Reply-To: <20120802180926.GL4537@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, namartax.kohli@intel.com, lrg@ti.com, ramesh.babu@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-08-02 at 19:09 +0100, Mark Brown wrote:
> > +int soc_compr_set_params(struct snd_compr_stream *cstream,
> > +					struct snd_compr_params *params)
> > +{
> 
> > +	snd_soc_dai_digital_mute(codec_dai, 0);
> 
> This looks wrong - the unmute should be associated with the start of the
> data transfer rather than the configuration.  But we don't have any
> other ops...  can we have one, or a non-atomic trigger?
Sure we discussed this, but wasnt too sure. Will change to trigger, it
seem the correct way.

> 
> > +	/* check client and interface hw capabilities */
> > +	snprintf(new_name, sizeof(new_name), "%s %s-%d",
> > +			rtd->dai_link->stream_name, codec_dai->name, num);
> > +	/* TODO add support for cature */
> 
> Meow :)
:D, some trvial ocde was still misisng, rest of the code should work for
both although havent been able to test that part.
> 
> > +	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
> > +		cpu_dai->name);
> 
> Say it's a compressed mapping?
> 
> > +	if (cpu_dai->driver->compress_dai) {
> > +		/*create compress device*/
> > +		ret = soc_new_compress(rtd, num);
> > +		if (ret < 0 ) {
> > +			printk(KERN_ERR "asoc: can't create offload %s\n",
> > +					 dai_link->stream_name);
> > +			return ret;
> > +		}
> 
> Should we be complaining here if there's PCM operations too?
I think so. A device should be either PCM or compress.

> Alternatively, should we support mixed PCM and compressed DAIs (possibly
> be creating two pcms from a single dai_link)?
I can't perceive why that should be done :)

-- 
~Vinod
