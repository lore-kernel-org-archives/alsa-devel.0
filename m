From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Sat, 6 Jan 2018 11:41:17 +0530
Message-ID: <20180106061116.GO18649@localhost>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
 <20180105170421.GE9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6AF266E07
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 07:07:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180105170421.GE9076@sirena.org.uk>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 05:04:21PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:
> 
> > +	/* SoundWire register address are contiguous */
> > +	if (config->reg_stride != 0)
> > +		return -ENOTSUPP;
> 
> That doesn't mean the chip hasn't decided not to use half the addresses
> for some reason - this isn't something the bus should be enforcing.

Agreed, will drop this

-- 
~Vinod
