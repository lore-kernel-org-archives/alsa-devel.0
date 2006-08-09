From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [Alsa-devel] ALSA problems with 2.6.18-rc3
Date: Wed, 09 Aug 2006 17:51:09 +0100
Message-ID: <1155142269.18821.45.camel@localhost.localdomain>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <1155073853.26338.112.camel@mindpipe> <44DA0D93.2080307@ukonline.co.uk>
	 <1155141333.26338.186.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750996AbWHIQvN@vger.kernel.org>
In-Reply-To: <1155141333.26338.186.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-09 at 12:35 -0400, Lee Revell wrote:
> On Wed, 2006-08-09 at 17:30 +0100, Andrew Benton wrote:
> > Lee Revell wrote:
> > > Please try to identify the change that introduced the regression.  What
> > > was the last kernel/ALSA version that worked correctly?
> > 
> > The change happened between 2.6.17 and 2.6.18-rc1. Specifically, 
> > 2.6.17-git4 works and 2.6.17-git5 doesn't.
> 
> Takashi-san,
> 
> Does this help at all?  Many users are reporting that sound broke with
> 2.6.18-rc*.

Fwiw, 2.6.18-rc1 works on arm (pxa2xx). Maybe this is related to another
subsystem not found on arm.

Liam
