From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 3/9] ASoC: Intel: Skylake: add DSP
 platform widget event handlers
Date: Thu, 17 Sep 2015 13:25:07 +0100
Message-ID: <1442492707.2520.36.camel@loki>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
 <1442483278.2520.24.camel@loki> <20150917113856.GA19522@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7E2261A8C
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 14:25:14 +0200 (CEST)
In-Reply-To: <20150917113856.GA19522@localhost>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-17 at 17:08 +0530, Vinod Koul wrote:
> On Thu, Sep 17, 2015 at 10:47:58AM +0100, Liam Girdwood wrote:
> 
> Hi Liam,
> 
> > On Mon, 2015-08-17 at 22:56 +0530, Vinod Koul wrote:
> > > From: Jeeja KP <jeeja.kp@intel.com>
> > > 
> > > The Skylake driver topology model tries to model the firmware
> > > rule for pipeline and module creation.
> > > The creation rule is:
> > >  - Create Pipe
> > >  - Add modules to Pipe
> > >  - Connect the modules (bind)
> > >  - Start the pipes
> > > 
> > > Similarly destroy rule is:
> > >  - Stop the pipe
> > >  - Disconnect it (unbind)
> > >  - Delete the pipe
> > > 
> > > In driver we use Mixer, as there will always be ONE mixer in a
> > > pipeline to model a pipe. The modules in pipe are modelled as PGA
> > > widgets.  The DAPM sequencing rules (mixer and then PGA) are used
> > > to create the sequence DSP expects as depicted above, and then
> > > widget handlers for PMU and PMD events help in that.
> > > 
> > > This patch adds widget event handlers for PRE/POST PMU and
> > > PRE/POST PMD event for mixer and pga modules.  These event
> > > handlers invoke pipeline creation, destroy, module creation,
> > > module bind, unbind and pipeline bind unbind
> > > 
> > > Event handler sequencing is implement to target the DSP FW
> > > sequence expectations to enable path from source to sink pipe for
> > > Playback/Capture.
> > > 
> > > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > > Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > ---
> > >  sound/soc/intel/skylake/skl-topology.c | 416 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 416 insertions(+)
> > > 
> > 
> > snip...
> > 
> > > +
> > > +/*
> > > + * in the Pre-PMD event of mixer we need to do following:
> > > + *   - Stop the pipe
> > > + *   - find the source connections and remove that from dapm_path_list
> > > + *   - unbind with source pipelines if still connected
> > > + */
> > > +static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
> > > +								struct skl *skl)
> > > +{
> > > +	struct snd_soc_dapm_widget *source, *sink;
> > > +	struct skl_module_cfg *src_mconfig, *sink_mconfig;
> > > +	int ret = 0, path_found = 0;
> > > +	struct skl_dapm_path_list *path_list, *tmp_list;
> > > +	struct skl_sst *ctx = skl->skl_sst;
> > > +
> > > +	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
> > > +
> > > +	sink = w;
> > > +	sink_mconfig = sink->priv;
> > > +
> > > +	/* Stop the pipe */
> > > +	ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	list_for_each_entry_safe(path_list, tmp_list, &skl->dapm_path_list, node) {
> > > +		if (path_list->dapm_path->sink == sink) {
> > > +			dev_dbg(ctx->dev, "Path found = %s\n", path_list->dapm_path->name);
> > > +			source = path_list->dapm_path->source;
> > > +			src_mconfig = source->priv;
> > > +			path_found = 1;
> > > +
> > > +			list_del(&path_list->node);
> > > +			kfree(path_list);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > 
> > There is a lot of list walking and manipulation in this series and it's
> > not clear where any locks are being held to prevent list corruption.
> > I'm assuming list items are being added and removed as part of
> > loading/unloading the topology data but it looks like we are also
> > manipulating component lists during DAPM events ?
> 
> We have a driver list dapm_path_list where we store the widgets powered up.
> This gives us a very quick reference of the paths which are powered up in
> the graph and helps fast traversal to check if we should power up a path as
> path is connected to something else which is powered up already (mixng two
> paths) and similarly while disconnecting.
> 
> Please note all these are handled only in event handlers for widgets, so
> they will be invoked by dapm with mutex, dapm_mutex held, so we didn't think
> we would need another lock here
> 

Ok, I was thinking that may be the case. It may be worth while stating
this in comments where this applies.

Liam
