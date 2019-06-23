From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] sound: soc: skylake: no need to check
 return value of debugfs_create functions
Date: Sun, 23 Jun 2019 17:55:35 +0200
Message-ID: <20190623155535.GB17284@kroah.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-2-gregkh@linuxfoundation.org>
 <f85fe797-f843-bf71-549a-00a169d527dd@intel.com>
 <20190623045749.GA4812@kroah.com>
 <398523ac-5ef8-2f13-ff2c-9837a7d6518c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1230F8065B
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 18:32:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <398523ac-5ef8-2f13-ff2c-9837a7d6518c@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 23, 2019 at 05:18:39PM +0200, Cezary Rojewski wrote:
> 
> On 2019-06-23 06:57, Greg Kroah-Hartman wrote:
> > On Sat, Jun 22, 2019 at 09:57:07PM +0200, Cezary Rojewski wrote:
> > > 
> > > On 2019-06-14 11:47, Greg Kroah-Hartman wrote:
> > > > When calling debugfs functions, there is no need to ever check the
> > > > return value.  The function can work or not, but the code logic should
> > > > never do something different based on this.
> > > > 
> > > 
> > > This change heavily impacts user space and development kits used by us
> > > internally, and our clients. That is, if anything goes wrong during debugfs
> > > initialization process.
> > 
> > As Takashi said, and as I said numerous times, how can anything go wrong
> > during debugfs file creation that does not also cause the rest of your
> > system to just crash. >
> > userspace should NEVER care about a debugfs file being present or not.
> > If it does, then you should not be using debugfs as it is never
> > guaranteed to be present on a system (and is locked down and removed on
> > many shipping systems for good reason.)
> > 
> > For development, it's wonderful, but it truely is just a debugging aid.
> > 
> > > Currently, apps may safely assume entire debugfs tree is up and running once
> > > audio stack gets enumerated successfully. With your patch this is no longer
> > > the case and user space is forced to verify status of all debugfs files and/
> > > or directories manually.
> > 
> > What apps rely on debugfs for audio?  We need to fix those.
> > 
> 
> Takashi,
> Thanks for reply. I hope you don't mind me replying here and not explicitly
> on your post. My message would be exactly the same as the one you see below.
> 
> 
> Greg,
> Forgive me for not clarifying: by userspace of course I meant any
> development/ debug related app which we use exhaustively.
> 
> Look at this from different perspective: I'm "just" a user of debugfs
> interface. I call a function and given its declaration I receive either 0 on
> success or != 0 on failure. Definition of said function may change in time
> and -ENOMEM might not be the only possible outcome, but that I leave to
> other developers and as long as behavior remains the same, changes are
> welcome.

Again, you should not even care if a debugfs call succeeds or not.

> Moreover, if we're compiling with CONFIG_DEBUGFS=1, driver may choose to
> collapse during probe if any of debugfs objects fail to initialize: in this
> case one can say CONFIG_DEBUGFS adds yet another condition for enumeration
> to be considered successful.

It should never matter to your code.

Debugfs was written to be much simpler and easier to use than procfs.
It goes against the "normal" defensive mode of kernel programming in
that you should not care if it works or not, your code should just keep
on working no matter what.

> > Again, my goal with these changes is two things:
> >    - no kernel operation should ever modify its behavior if debugfs is
> >      enabled, or working, at all.
> >    - no normal userspace code should ever care if debugfs is working
> > 
> > debugfs is for debugging things, that is all.  If you have system
> > functionality relying on files in debugfs, they need to be moved to a
> > system functionality that is always going to be present for your users
> > (i.e. sysfs, configfs, tracefs, etc.)
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> With mindset "may or may not succeed" one might as well resign from debugfs
> entirely and move to sysfs and other fs you'd mentioned.

That's fine, but do not put debugging stuff in sysfs please.  There are
strict rules on what you can and can not do in sysfs and other
filesystems.  Debugfs has no such rules except that no userspace code
should ever care about it.

> And why would he otherwise, when the only way to verify debugfs object
> state is either log parsing (filtering errors) or file-exists check.
> 
> My app should not be guessing, instead, it should know upfront with what its
> working with.

What app digs around in debugfs that any user should care about?  The
goal is to never have any functionality in there that the system
requires in order to work properly.

Again, we have found places where this is not the case, and it is being
fixed to remove that dependancy.

debugfs is "fire and forget" and used for debugging stuff only.  No
working system should care at all about it.

thanks,

greg k-h
