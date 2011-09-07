From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Wed, 7 Sep 2011 15:12:07 +0100
Message-ID: <20110907141207.GA21984@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
	<20110907135927.GA21280@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1777024344
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 16:12:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110907135927.GA21280@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 07, 2011 at 02:59:27PM +0100, Dimitris Papastamos wrote:
> On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> > This patch ads core.c, the file which implements the ioctls and
> > registers the devices
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  sound/compress_offload/core.c |  632 +++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 632 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/compress_offload/core.c
> > 
> > diff --git a/sound/compress_offload/core.c b/sound/compress_offload/core.c
> > new file mode 100644
> > index 0000000..1797dba
> > --- /dev/null
> 
> > +static int snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
> > +{
> > +	struct snd_compr_params *params;
> > +	int retval;
> > +
> > +	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> > +		/*
> > +		 * we should allow parameter change only when stream has been
> > +		 * opened not in other cases
> > +		 */
> > +		params = kmalloc(sizeof(*params), GFP_KERNEL);
> > +		if (!params)
> > +			return -ENOMEM;
> > +		if (copy_from_user(&params, (void __user *)arg, sizeof(params)))
> > +			return -EFAULT;
> 
> This should be copy_from_user(params, ...) and not &params.

Aw and it should be sizeof(*params).

Thanks,
Dimitris
