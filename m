From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 09/15] soundwire: Add slave status
 handling
Date: Sun, 3 Dec 2017 22:41:39 +0530
Message-ID: <20171203171139.GQ32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-10-git-send-email-vinod.koul@intel.com>
 <693f15b3-3751-2416-5d81-abd362464309@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E0F266B0F
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 18:08:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <693f15b3-3751-2416-5d81-abd362464309@linux.intel.com>
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

On Fri, Dec 01, 2017 at 05:52:03PM -0600, Pierre-Louis Bossart wrote:

> >+		status = sdw_read(slave, SDW_DP0_INT);
> >+		if (status < 0) {
> >+			dev_err(slave->bus->dev,
> >+				"SDW_DP0_INT read failed:%d", status);
> >+			return status;
> >+		}
> >+
> >+		count++;
> >+
> >+		/* we can get alerts while processing so keep retrying */
> 
> This is not incorrect, but this goes beyond what the spec requires.
> 
> The additional read is to make sure some interrupts are not lost due to a
> known race condition. It would be enough to mask the status read the second
> time to only check if the interrupts sources which were cleared are still
> signaling something.
> 
> With the code as it is, you may catch *new* interrupt sources, which could
> impact the arbitration/priority/policy in handling interrupts. It's not
> necessarily bad, but you'd need to document whether you want to deal with
> the race condition described in the MIPI spec or try to be smarter.

This was based on your last comment, lets discuss more offline on this to
see what else is required here.
-- 
~Vinod
