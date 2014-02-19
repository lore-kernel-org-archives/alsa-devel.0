From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Wed, 19 Feb 2014 15:24:21 +0000
Message-ID: <1392823461.2351.61.camel@loki>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140219150040.GD2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C2BB0265919
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:24:26 +0100 (CET)
In-Reply-To: <20140219150040.GD2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-02-20 at 00:00 +0900, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 02:06:24PM +0000, Liam Girdwood wrote:
> > Disable build on non X86 architectures. This fixes the following build
> > errors on PPC :-
> 
> > sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_write':
> > sound/soc/intel/sst-dsp.c:218:2: error: implicit declaration of function 'memcpy_toio' [-Werror=implicit-function-declaration]
> >   memcpy_toio(sst->mailbox.out_base, message, bytes);
> >   ^
> 
> But lots of architectures do actually have these operations, I suspect
> looking at some of the existing users depending on PCI is enough if
> excessively strict (this will improve build coverage which tends to be
> useful even if the driver can't be run).

I know that the other architectures will implement their own ops, but no
other architecture other than X86 will have Intel SST. 

I can either send a new patch that additionally includes linux/io.h or
send a V2 ?

Liam 
