From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Sat, 6 Jan 2018 11:42:23 +0530
Message-ID: <20180106061223.GP18649@localhost>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
 <20180105170421.GE9076@sirena.org.uk>
 <98480de5-cd6b-845f-df1d-c9593596055f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 362A1266E07
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 07:08:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98480de5-cd6b-845f-df1d-c9593596055f@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudheer Papothi <spapothi@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, patches.audio@intel.com, Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 11:22:15AM -0600, Pierre-Louis Bossart wrote:
> On 1/5/18 11:04 AM, Mark Brown wrote:
> >On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:
> >
> >>+	/* SoundWire register address are contiguous */
> >>+	if (config->reg_stride != 0)
> >>+		return -ENOTSUPP;
> >
> >That doesn't mean the chip hasn't decided not to use half the addresses
> >for some reason - this isn't something the bus should be enforcing.
> 
> Good point. The contiguous requirement is valid only for normative
> registers, where the device has no choice but to follow the standard. For
> the imp-def part where regmap would typically be used, then indeed there is
> no restriction, chip implementers can do whatever they want.
> I have a vague memory that regmap was only intended to be used for this
> latter case, but Vinod and team should clarify this.

Right now it is used by codec for imp-def area. We do plan to add for all
registers eventually

Thanks
-- 
~Vinod
