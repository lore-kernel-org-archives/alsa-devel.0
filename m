From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] dma: Add a jz4740 dmaengine driver
Date: Fri, 24 May 2013 13:24:03 +0530
Message-ID: <20130524075403.GS30200@intel.com>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
 <1369341387-19147-4-git-send-email-lars@metafoo.de>
 <20130524045935.GM30200@intel.com> <519F016C.4040901@metafoo.de>
 <20130524055453.GR30200@intel.com> <519F0B81.1090009@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 35035261A48
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 10:30:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <519F0B81.1090009@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 24, 2013 at 08:41:05AM +0200, Lars-Peter Clausen wrote:
> On 05/24/2013 07:54 AM, Vinod Koul wrote:
> > On Fri, May 24, 2013 at 07:58:04AM +0200, Lars-Peter Clausen wrote:
> >> This one needs both.
> >>
> >>>> +	jzcfg.mode = JZ4740_DMA_MODE_SINGLE;
> >>>> +	jzcfg.request_type = config->slave_id;
> >>>> +
> >>>> +	chan->config = *config;
> >>>> +
> >>>> +	jz4740_dma_configure(chan->jz_chan, &jzcfg);
> >>>> +
> >>>> +	return 0;
> >>> You are NOT use src_addr/dstn_addr? How else are you passing the periphral
> >>> address?
> >> I'm saving the whole config, which will later be used to retrieve the source or
> >> dest address.
> > well I missed that and it is a bad idea. You dont know when client has
> > freed/thrown the pointer so copy this instead..
> 
> I do copy the full config, not just the pointer to the config. Although
> src_addr and dest_addr are the only two fields which are used later on at this
> point. So I could change it to just copy src_addr and dest_addr, or well just
> one of them depending on the direction.
One of them based on direction would be right

> 
> > 
> >>
> >>>> +}
> >> [...]
> >>>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
> >>>> +{
> >>>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
> >>>> +
> >>>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
> >>>> +	if (!chan->jz_chan)
> >>>> +		return -EBUSY;
> >>>> +
> >>>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
> >>>> +
> >>>> +	return 0;
> >>> Zero is not expected value, you need to return the descriptors allocated
> >>> sucessfully.
> >>
> >> Well, zero descriptors have been allocated. As far as I can see only a negative
> >> return value is treated as an error. Also the core doesn't seem to use the
> >> return value for anything else but checking if it is an error.
> > This is the API defination
> > * @device_alloc_chan_resources: allocate resources and return the
> > *      number of allocated descriptors
> > 
> 
> But 0 is still the number of descriptors that have been pre-allocated.
and that should change, typically the driver will preallocate a pool of
descriptors. These are to be used later for .device_prep_xxx calls.

--
~Vinod
