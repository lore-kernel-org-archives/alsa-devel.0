From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Wed, 29 Apr 2015 16:33:48 +0530
Message-ID: <20150429110348.GF3521@localhost>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
 <20150420214638.GX14892@sirena.org.uk>
 <20150422035014.GD2738@intel.com>
 <20150424173331.GY22845@sirena.org.uk>
 <20150426143452.GW2738@intel.com>
 <20150427210202.GP22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BE9242604CA
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:03:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150427210202.GP22845@sirena.org.uk>
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

On Mon, Apr 27, 2015 at 10:02:02PM +0100, Mark Brown wrote:
> On Sun, Apr 26, 2015 at 08:04:52PM +0530, Vinod Koul wrote:
> > On Fri, Apr 24, 2015 at 06:33:31PM +0100, Mark Brown wrote:
> 
> > > Seems like we could use the block I/O stuff in regmap for that?
> 
> > Yes we could, but not sure if we really benefit from using regmap here. 
> 
> I'd look at it the other way around - what would it cost you given that
> you're implementing regmap like wrappers already?  You do get all the
> debugging features if you use it...
it won't cost much :) If we had a register map I would not have questions.
Btw HDA codec will sue regmap as core does that

Most used here is a single IPC register for messaging and then 2K memory for
payload. Each message has different values. We dont have register interface
for DSP :(

Anyway discussed this with Liam as well, we might do something with our
common amilbox code which the SKL driver will also use in next series

Thanks
-- 
~Vinod
