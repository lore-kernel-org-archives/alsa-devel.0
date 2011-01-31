From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc: neo1973_wm8753 audio support does not require
	scoop
Date: Mon, 31 Jan 2011 13:36:49 +0000
Message-ID: <20110131133648.GG11937@sirena.org.uk>
References: <201101281200.18371.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201101281200.18371.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 12:00:18PM -0700, H Hartley Sweeten wrote:
> This driver does not use any of the functionality provided by the scoop
> hardware.  Remove the unneeded header.

Applied but please in future remember to:

- Send copies of your patches to the relevant maintainers as documented
  in Documentation/SubmittingPatches so maintainers actually see them.
- Make your commit messages match the style for the subsystem you're
  submitting to.

This stuff is especially important for minor cleanups like this, please
do try to bear it in mind.
