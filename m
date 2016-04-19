From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Tue, 19 Apr 2016 17:52:25 +0100
Message-ID: <20160419165225.GB1581@localhost.localdomain>
References: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1460457129-23281-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160419062552.GI2274@localhost>
 <20160419083140.GA1581@localhost.localdomain>
 <20160419130403.GO2274@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 013AF26262A
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 18:52:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160419130403.GO2274@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 19, 2016 at 06:34:03PM +0530, Vinod Koul wrote:
> On Tue, Apr 19, 2016 at 09:31:40AM +0100, Charles Keepax wrote:
> > On Tue, Apr 19, 2016 at 11:55:52AM +0530, Vinod Koul wrote:
> > > On Tue, Apr 12, 2016 at 11:32:07AM +0100, Charles Keepax wrote:
> > > 
> > > > + * @state: state to transition the stream to
> > > > + *
> > > > + * Stop the stream and set its state.
> > > > + *
> > > > + * Should be called with compressed device lock held.
> > > > + */
> > > > +int snd_compr_stop_error(struct snd_compr_stream *stream,
> > > > +			 snd_pcm_state_t state)
> > > 
> > > Do we want the state as an agument here, since we are invoking stop, it
> > > should transistion to the stopped state
> > > 
> > 
> > This was my interpretation of this comment of yours:
> > 
> > "Also should this be made a generic stop rather than
> > xrun. Perhaps the reason can be specified as an argument."
> > 
> > If you clarify what you are looking for I am happy to respin. We
> > should set the state to something that indicates there has
> > been an error, such that things are distinct from a normal
> > stop operation. Personally I liked simply calling the function
> > snd_compr_stop_xrun and always setting it to xrun and it matches
> > what the PCM framework does. So I am happy to go back to that if
> > you prefer?
> 
> Your interpretation was right, but there is no point in setting xrun as this
> will be essentially overwritten when you invoke the snd_compr_stop()
> 
> It does set it back to setup state..

Ah oops thanks missed that one, I will have a look at fixing that
and doing another spin.

Thanks,
Charles
