From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 00/15] soundwire: Add a new SoundWire
 subsystem
Date: Sun, 3 Dec 2017 22:42:56 +0530
Message-ID: <20171203171255.GR32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <404dd97d-767d-1f93-949b-487dcca96256@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CEAF266B0F
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 18:09:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <404dd97d-767d-1f93-949b-487dcca96256@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 06:24:10PM -0600, Pierre-Louis Bossart wrote:
> On 12/1/17 3:56 AM, Vinod Koul wrote:
> >This patch series adds a new SoundWire subsystem which implements a
> >new MIPI bus protocol 'SoundWire'.
> 
> Sorry for the late feedback Vinod and team.
> 
> Overall the code looks very good to me and aligned with the MIPI specs,
> there are only a couple of points that were added (or some code not removed)
> during the code cleanups, e.g.
> - device12..14 should not be used
> - device_property handling (master/controller confusion?)
> - error cases on transfers
> - spec race condition on interrupt clear (not bad but to be discussed
> further)
> - some comments and code nit-picks
> 
> This is starting to get into second-order reviews really, which shows this
> is becoming quite mature. And for the record this work isn't just scratching
> the surface, it helped identify a couple of documentation issues in the MIPI
> specs which will lead to clarifications in future revisions.

Thanks for the good word, most the stuff you pointed needs a very detailed
review, so many thaks for spending time on this one.

> Looking forward to a v5 ;-)

Yeah should be there in next few days..

-- 
~Vinod
