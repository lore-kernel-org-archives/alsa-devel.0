From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/5] sound: soc: core: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 18:13:39 +0200
Message-ID: <20190614161339.GB22607@kroah.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-5-gregkh@linuxfoundation.org>
 <20190614153405.GD5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C766F80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 18:13:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190614153405.GD5316@sirena.org.uk>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2019 at 04:34:05PM +0100, Mark Brown wrote:
> On Fri, Jun 14, 2019 at 11:47:56AM +0200, Greg Kroah-Hartman wrote:
> 
> > Note, the soc-pcm "state" file has now moved to a subdirectory, as it is
> > only a good idea to save the dentries for debugfs directories, not
> > individual files, as the individual file debugfs functions are changing
> > to not return a dentry.
> 
> It'd be better to split this out into a separate change for ease of
> review.
> 
> > -	d = debugfs_create_file(w->name, 0444,
> > -				dapm->debugfs_dapm, w,
> > -				&dapm_widget_power_fops);
> > -	if (!d)
> > -		dev_warn(w->dapm->dev,
> > -			"ASoC: Failed to create %s debugfs file\n",
> > -			w->name);
> > +	debugfs_create_file(w->name, 0444, dapm->debugfs_dapm, w,
> > +			    &dapm_widget_power_fops);
> 
> The majority of this is removing error prints rather than code that
> actively does something different.  If this was like kmalloc() where the
> API is itself reported errors then this wouldn't be an issue but unless
> I'm missing something debugfs fails silently so this means that if
> something goes wrong it's going to be harder for the user to figure out
> where the debugfs files they wanted to check went to.  I'm guessing you
> don't want to add error prints in debugfs itself so I'd rather they
> stayed here.
> 
> Yes, the error check is looking for NULL not an error pointer - it was
> correct when written but I see that the debugfs API changed earlier this
> year to return error pointers so we ought to fix that up.

No, the long-term goal is for debugfs_create_file() to just return void.
I have already done enough cleanups in my local tree to do that already
for many of the helper functions.

No one should care one bit if a debugfs file succeeds or not, no logic
should ever change, nor should it matter.  debugfs is for debugging
kernel code, not for anything that anyone should ever rely on.

So yes, this patch does remove a bunch of error messages (that as you
point out can never be triggered), but the main goal here is to not
check the return value of the function at all, which is what this patch
does.

thanks,

greg k-h
