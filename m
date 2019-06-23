From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] sound: soc: skylake: no need to check
 return value of debugfs_create functions
Date: Sun, 23 Jun 2019 06:57:49 +0200
Message-ID: <20190623045749.GA4812@kroah.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-2-gregkh@linuxfoundation.org>
 <f85fe797-f843-bf71-549a-00a169d527dd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42DE2F8065D
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 06:57:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f85fe797-f843-bf71-549a-00a169d527dd@intel.com>
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

On Sat, Jun 22, 2019 at 09:57:07PM +0200, Cezary Rojewski wrote:
> 
> On 2019-06-14 11:47, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> 
> This change heavily impacts user space and development kits used by us
> internally, and our clients. That is, if anything goes wrong during debugfs
> initialization process.

As Takashi said, and as I said numerous times, how can anything go wrong
during debugfs file creation that does not also cause the rest of your
system to just crash.

userspace should NEVER care about a debugfs file being present or not.
If it does, then you should not be using debugfs as it is never
guaranteed to be present on a system (and is locked down and removed on
many shipping systems for good reason.)

For development, it's wonderful, but it truely is just a debugging aid.

> Currently, apps may safely assume entire debugfs tree is up and running once
> audio stack gets enumerated successfully. With your patch this is no longer
> the case and user space is forced to verify status of all debugfs files and/
> or directories manually.

What apps rely on debugfs for audio?  We need to fix those.

Again, my goal with these changes is two things:
  - no kernel operation should ever modify its behavior if debugfs is
    enabled, or working, at all.
  - no normal userspace code should ever care if debugfs is working

debugfs is for debugging things, that is all.  If you have system
functionality relying on files in debugfs, they need to be moved to a
system functionality that is always going to be present for your users
(i.e. sysfs, configfs, tracefs, etc.)

thanks,

greg k-h
