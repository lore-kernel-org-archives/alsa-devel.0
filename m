From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: compress: Pass id string to
 snd_compress_new
Date: Wed, 25 Nov 2015 15:15:34 +0000
Message-ID: <1448464534.3536.64.camel@rf-debian.wolfsonmicro.main>
References: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1448444918-29760-3-git-send-email-rf@opensource.wolfsonmicro.com>
 <5655CAE8.80705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 307F4261A83
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 16:15:39 +0100 (CET)
In-Reply-To: <5655CAE8.80705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, tiwai@suse.com, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-11-25 at 08:51 -0600, Pierre-Louis Bossart wrote:
> > @@ -689,7 +689,13 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
> >   		compr->ops->copy = soc_compr_copy;
> >
> >   	mutex_init(&compr->lock);
> > -	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
> > +
> > +	snprintf(new_name, sizeof(new_name), "%s %s-%d",
> > +		 rtd->dai_link->stream_name,
> > +		 rtd->codec_dai->name, num);
> 
> Adding an ID with a human-readable name sounds good.
> Wondering though if the codec_dai name is relevant for compressed 
> streams?

I think it is, that was the original reason I wrote this patch. I'm
writing some automated tests where I have to know what each stream is
really connected to and the DAI name is important for that (in my case
anyway). Since the PCM core already provides that in the info file it
seemed reasonable to do the same for compressed.

>
>  In all the configurations we have with DPCM the name is 
> snd-soc-dummy-dai, there is no connection to the codec proper. 
> stream_name and id should be good enough, no?

There's going to be systems where the DAI name is something real and I
can't see a disadvantage in providing that extra piece of information,
just in case it's useful. I've kept the format the same as the
equivalent for PCM
