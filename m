From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 2/4] ASoC: Intel: Add merrifield machine
 driver
Date: Tue, 6 May 2014 22:19:45 +0530
Message-ID: <20140506164945.GD28638@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
 <1399389439.2814.30.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A27D26179C
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 19:02:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1399389439.2814.30.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 06, 2014 at 04:17:19PM +0100, Liam Girdwood wrote:
> On Mon, 2014-05-05 at 23:31 +0530, Vinod Koul wrote:

> > +/* TODO: find better way of doing this */
> > +static struct snd_soc_dai *find_codec_dai(struct snd_soc_card *card, const char *dai_name)
> > +{
> > +	int i;
> > +	for (i = 0; i < card->num_rtd; i++) {
> > +		if (!strcmp(card->rtd[i].codec_dai->name, dai_name))
> > +			return card->rtd[i].codec_dai;
> > +	}
> > +	pr_err("%s: unable to find codec dai\n", __func__);
> > +	/* this should never occur */
> > +	WARN_ON(1);
> > +	return NULL;
> > +}
> > +
> 
> It would be good if we could eventually make the above 2 calls generic
> in core. Seem to be quite useful functions.
Yes I didnt do that as I wanted to check if we have a better method or not. With
multi-codec systems we dont have single codec for the card so finding this would
need lookup or else... Somehow I think we should have simpler solution, Mark??


> > +static int mrfld_wm8958_compr_set_params(struct snd_compr_stream *cstream)
> > +{
> > +	return 0;
> > +}
> 
> Do we need to implement this if it's not used ?
My bad, this was supposed to be removed but... :)

-- 
~Vinod
