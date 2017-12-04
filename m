From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 03/15] soundwire: Add Master registration
Date: Mon, 4 Dec 2017 08:29:13 +0530
Message-ID: <20171204025911.GT32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-4-git-send-email-vinod.koul@intel.com>
 <435d9db4-eb3c-f4b4-d978-e5d10b921f71@linux.intel.com>
 <20171203164119.GL32417@localhost>
 <8920a633-4635-afbb-18c4-2a826facd2eb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8920a633-4635-afbb-18c4-2a826facd2eb@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 03, 2017 at 08:44:58PM -0600, Pierre-Louis Bossart wrote:
> 
> >>>+/* SDW Enumeration Device Number */
> >>>+#define SDW_ENUM_DEV_NUM		0
> >>
> >>add
> >>SDW_GROUP12_DEV_NUM		12
> >>SDW_GROUP12_DEV_NUM		13
> >
> >you mean SDW_GROUP13_DEV_NUM :D
> >
> >>SDW_MASTER_DEV_NUM		14 /* not supported in these patches */
> >
> >These dont help now as we dont support, so kind of dead code.
> >Lets add them when we really support it
> 
> It was a way to explain why device 14 is never allocated.

Rethinking about it, i need these defines anyway for masking them
out now, so will add

-- 
~Vinod
