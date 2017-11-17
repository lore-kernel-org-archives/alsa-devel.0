From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 03/14] soundwire: Add Master registration
Date: Fri, 17 Nov 2017 07:36:04 +0530
Message-ID: <20171117020604.GG3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-4-git-send-email-vinod.koul@intel.com>
 <2ba56597-2178-6389-bc4d-153a17505981@linaro.org>
 <20171116164944.GC3187@localhost>
 <20171116173024.owiotfwriclu2won@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DE2AE2677A2
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 03:02:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171116173024.owiotfwriclu2won@sirena.org.uk>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Sagar Dharia <sdharia@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 05:30:24PM +0000, Mark Brown wrote:
> On Thu, Nov 16, 2017 at 10:19:44PM +0530, Vinod Koul wrote:
> > On Thu, Nov 16, 2017 at 04:05:22PM +0000, Srinivas Kandagatla wrote:
> 
> > > >+	*bus->assigned = ~GENMASK(SDW_BROADCAST_DEV_NUM, SDW_ENUM_DEV_NUM);
> 
> > > Can't we use ida for this.
> > > This would also cut down code added for allocating dev_num.
> 
> > Device numbers in SoundWire are 0 thru 15 with 0 and 15 having special
> > meaning so can'r be allocated. Bitmaps give me a nice way to ensure we dont
> > use those by masking these and above 15... IDR uses bitmap with stuff on top
> > which maynot be helpful here as I need a number 1 to 14. For a generic, give
> > me a number IDRs are very useful.
> 
> Perhaps we need some comments or something explaining the constraints
> here to stop people doing misguided cleanups?

Sure, it is already explained at scattered places, will add this comment here
as well.

-- 
~Vinod
