From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 12/15] soundwire: cdns: Add
 sdw_master_ops and IO transfer support
Date: Sun, 3 Dec 2017 22:40:14 +0530
Message-ID: <20171203171013.GP32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-13-git-send-email-vinod.koul@intel.com>
 <a3167578-df2b-e871-cd5e-94adcc549a4e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 30421266B0F
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 18:06:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a3167578-df2b-e871-cd5e-94adcc549a4e@linux.intel.com>
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

On Fri, Dec 01, 2017 at 06:02:24PM -0600, Pierre-Louis Bossart wrote:
> 
> >  struct sdw_cdns {
> >  	struct device *dev;
> >  	struct sdw_bus bus;
> >  	unsigned int instance;
> >+	u32 response_buf[0x80];
> 
> last nit-pick: use a #define for the size.

okay last one huh :) yeah will add.

> Also are you sure about the value? I vaguely recall that the FIFO was
> 32-deep, you are confusing bytes and words here?

I dont think this is related to FIFO depth, this is buffer to hold values.
Will check though..

-- 
~Vinod
