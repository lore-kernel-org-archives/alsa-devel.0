From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Date: Tue, 30 Apr 2019 16:25:36 +0200
Message-ID: <20190430142536.GA22503@kroah.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190430085153.GS3845@vkoul-mobl.Dlink>
 <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
 <20190430140526.GB18986@kroah.com>
 <b036a602-704f-4286-001c-6d4b32e0391e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b036a602-704f-4286-001c-6d4b32e0391e@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 30, 2019 at 09:13:55AM -0500, Pierre-Louis Bossart wrote:
> 
> > My patch-bot would reject a patch that tried to do multiple types of
> > different cleanups on the same file(s).  Has done so for _years_, this
> > is not a new thing.
> 
> If there are tools let's use them (all the fixes in this series were
> reported by tools). Can you share pointers and location of this patch-bot?

I talked about my bot a long time ago in one of my presentations, the
source isn't around anywhere public, sorry.

But here's the template for what it can spit out, depending on the patch
input, feel free to cut/paste from it for your use when reviewing
patches.

thanks,

greg k-h
-----------------


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch was sent privately to Greg.  Kernel development is done in
  public, please always cc: a public mailing list with a patch
  submission.  Using the tool, scripts/get_maintainer.pl on the patch
  will tell you what mailing list to cc.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
