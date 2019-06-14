From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/5] sound: SoC: sof: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 17:27:04 +0200
Message-ID: <20190614152704.GB18049@kroah.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614151410.GC5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E504F80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 17:27:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190614151410.GC5316@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2019 at 04:14:10PM +0100, Mark Brown wrote:
> On Fri, Jun 14, 2019 at 11:47:52AM +0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> > +++ b/sound/soc/sof/debug.c
> > @@ -77,8 +77,7 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
> >  		if (!pm_runtime_active(sdev->dev) &&
> >  		    dfse->access_type == SOF_DEBUGFS_ACCESS_D0_ONLY) {
> >  			dev_err(sdev->dev,
> > -				"error: debugfs entry %s cannot be read in DSP D3\n",
> > -				dfse->dfsentry->d_name.name);
> > +				"error: debugfs entry cannot be read in DSP D3\n");
> >  			kfree(buf);
> >  			return -EINVAL;
> >  		}
> 
> This appears to be an unrelated change with no description in the
> changelog, please split it out into a separate change with a description
> of the change.

The whole "dfsentry" variable is now gone, so it is very related.  Why
split this out?

> > @@ -119,13 +119,8 @@ static int trace_debugfs_create(struct snd_sof_dev *sdev)
> >  	dfse->size = sdev->dmatb.bytes;
> >  	dfse->sdev = sdev;
> >  
> > -	dfse->dfsentry = debugfs_create_file("trace", 0444, sdev->debugfs_root,
> > -					     dfse, &sof_dfs_trace_fops);
> > -	if (!dfse->dfsentry) {
> > -		/* can't rely on debugfs, only log error and keep going */
> > -		dev_err(sdev->dev,
> > -			"error: cannot create debugfs entry for trace\n");
> > -	}
> > +	debugfs_create_file("trace", 0444, sdev->debugfs_root, dfse,
> > +			    &sof_dfs_trace_fops);
> 
> I might be missing something but I can't see any error logging in
> debugfs_create_file() so this isn't equivalent (though the current code
> is broken, it should be using IS_ERR()).  Logging creation failures is
> helpful to developers trying to figure out what happened to the trace
> files they're trying to use.

There is no need to log anything in in-kernel, working code.  If a
developer wants to do this on their own when writing the code the first
time and debugging it, great, but for stuff we know works, there's no
need for being noisy.

Also, the check is incorrect, there's no way for this function to return
NULL, so that code today, will never trigger.  So obviously no one
counted on this message anyway :)

Just call the function and move on, like the rest of the kernel is being
converted over to do.

thanks,

greg k-h
