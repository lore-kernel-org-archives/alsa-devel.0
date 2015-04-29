From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 6/9] ASoC: hda: Add Code Loader DMA support
Date: Wed, 29 Apr 2015 16:38:40 +0530
Message-ID: <20150429110840.GG3521@localhost>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
 <20150424171838.GV22845@sirena.org.uk>
 <20150426142822.GU2738@intel.com>
 <20150427141717.GT22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A83112604CA
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:08:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150427141717.GT22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2015 at 03:17:17PM +0100, Mark Brown wrote:
> On Sun, Apr 26, 2015 at 07:58:22PM +0530, Vinod Koul wrote:
> > On Fri, Apr 24, 2015 at 06:18:38PM +0100, Mark Brown wrote:
> 
> > > > +		goto cleanup;
> > > > +	}
> 
> > > What if the buffer is just too big?  Looks like this would loop for
> > > ever.
> 
> > DMA is started, so link_pos get updated and we keep reading it. Since its
> > DMA a big buffer will get done fairly soon.
> 
> No, two separate questions there - what if the buffer is bigger than the
> maximum size (it looked like there was one) and what about error
> handling (if some clock gets stopped and we don't transfer data for
> example)?
Okay got it. So for former, yes code doesn't handle it, we should split it up
in that case or error out, will add that.

On latter one, the error handling in general would be beefed up but
specifically since this is memory copy I am not expecting timeout. If clock is
gone then whole audio cluster is gone bonkers so even simple read registers
will fail.

Thanks
-- 
~Vinod
