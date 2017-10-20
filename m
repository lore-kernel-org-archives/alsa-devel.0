From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Fri, 20 Oct 2017 21:19:18 +0530
Message-ID: <20171020154917.GR30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
 <20171020103934.GA3210@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D86F92676ED
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 17:45:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171020103934.GA3210@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 12:39:34PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2017 at 08:33:17AM +0530, Vinod Koul wrote:
> > From: Sanyog Kale <sanyog.r.kale@intel.com>
> > 
> > SoundWire is a new Linux bus which implements a new MIPI bus protocol
> > 'SoundWire'. The summary of SoundWire bus and registration APIs is
> > documented in the 'summary' file.
> > 
> > Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> > Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  Documentation/soundwire/summary.txt | 192 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 192 insertions(+)
> >  create mode 100644 Documentation/soundwire/summary.txt
> 
> Any specific reason this is not in .rst format and tied to the rest of
> the kernel Documentation so it gets built automatically?

I was hoping to do rst conversion a bit later if that is not a deal
breaker :) That is certainly a todo in my list.

-- 
~Vinod
