From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Question on compress offload framework memory
 corruption
Date: Wed, 5 Mar 2014 13:21:04 +0530
Message-ID: <20140305075104.GI10628@intel.com>
References: <f7340ae1f345dc53c799ff8c02321ed1.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 835DD26500A
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 08:54:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f7340ae1f345dc53c799ff8c02321ed1.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Banajit Goswami <bgoswami@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam <lgirdwood@gmail.com>, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 04, 2014 at 10:19:20PM +0000, Banajit Goswami wrote:
> Hi Liam,
> 
> > On Thu, Dec 19, 2013 at 10:55:08AM +0000, Mark Brown wrote:
> > > On Wed, Dec 18, 2013 at 01:17:51PM -0000, gsantosh@codeaurora.org wrote:
> > > > Hi,
> > > >
> > > > I have following questions in the compressed offload framework API.
> > > >
> > > > static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
> > > > 					struct snd_compr_params *params) { ...
> > > > 	hw_params = kzalloc(sizeof(*hw_params), GFP_KERNEL);
> > > > 	if (hw_params == NULL)
> > > > 		return -ENOMEM;
> > > > /*1st question is, what is the use of above allocated memory I do
> > > > not see this being used in this function*/
> > >
> > > The code you're quoting there isn't in mainline.  I've also added
> > > Vinod to the CCs, you probably want to include him in any discussion
> > > of the compressed API.
> >
> > That's right, this is from DPCM compressed updated done by Liam, so he
> is > the best person to comment on this bit, and somehow his address in
> CC has > gone bad, i have added him in to list
> 
> > But yes looking at the source, i agree that two are interlinked.
> > I guess we need to poupulate the hw_params and then use that to copy, that
> > would be the right thing to do here and yes this is not correct and not
> > sure how this is working...
> 
> 
> Continuing the discussion on the "memcpy" function in Santosh's 2nd question-
> 
> > > >        memcpy(&fe->dpcm[fe_substream->stream].hw_params, params,
> > > >                       sizeof(struct snd_pcm_hw_params));
> > > >
> > > > /* 2nd question is
> > > > in above memcpy there is parameter mismatch
> > > > &fe->dpcm[fe_substream->stream].hw_params is of structure type struct
> > > > snd_pcm_hw_params
> > > >
> > > > params argument is of the structure type struct snd_compr_params
> > > > the definition of the two structures are different, how this is
> > > > working?
> > > > this will over right the destination with junk value which will return
> > > > in error when this memory is accessed, after memcpy this cpu_dai
> > > > hw_params
> > > > returing with EINVAL error, please explain why this is done this way.
> > > > */
> 
> I can see that a later version of the patch adds the function
> soc_compr_set_params_fe() at-
>     http://permalink.gmane.org/gmane.linux.alsa.devel/117716
> 
> with the below code replaces the "memcpy" function with a "memset"-
> +	/*
> +	 * Create an empty hw_params for the BE as the machine driver must
> +	 * fix this up to match DSP decoder and ASRC configuration.
> +	 * I.e. machine driver fixup for compressed BE is mandatory.
> +	 */
> +	memset(&fe->dpcm[fe_substream->stream].hw_params, 0,
> +		sizeof(struct snd_pcm_hw_params));
> 
> It's evident that the code relies on machine driver fixup function to
> populate the parameters of hw_params before propagating those to back-end.
> I think rather than that, like Vinod also mentioned, the hw_params should
> have been populated with individual parameters which are relevant.

Yes I did mention that hw_params should be populated and even gave it a shot.
But this is not so simple. It depends on how decoder is done. The file may tell
you few PCM format details (only for few lucky formats) not all. It wont tell
you PCM word length!  Also you may or may not have SRCs... 

Hence we thought it does not make sense and since we are talking about a DSP we
will end up having some fixed format to which you will process and render data.
So that format would be sensible to be put it fixup.

If you have an idea how to solve this, am all ears :)

-- 
~Vinod
