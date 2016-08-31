From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Wed, 31 Aug 2016 15:34:11 -0700
Message-ID: <20160831223407.GJ12510@codeaurora.org>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160831003722.GH12510@codeaurora.org>
 <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

On 08/30, Pierre-Louis Bossart wrote:
> On 8/30/16 7:37 PM, Stephen Boyd wrote:
> >On 08/17, Pierre-Louis Bossart wrote:
> >>@@ -414,6 +456,13 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
> >> 	if (ret)
> >> 		dev_warn(&pdev->dev, "debugfs register failed\n");
> >>
> >>+	/* Register platform clocks - PMC_PLT_CLK [5:0] */
> >>+	clkdev = platform_device_register_data(NULL, "clk-byt-plt", -1,
> >>+					       &clks, sizeof(clks));
> >
> >Shouldn't we register the clk device as a child of the
> >registering device? Otherwise it's just floating in the device
> >hierarchy?
> 
> from a hardware perspective these clocks are pretty much stand-alone
> and independent, there is no real parent/child dependency I can
> think of and having this as 'floating' isn't very far from reality.

Hmm... what about things like suspend/resume? Presumably we would
want the clk device that's touching the pmc register space to be
suspended before we suspend pmc itself? Not having a parent would
mean it's a virtual device which doesn't seem correct. It's a
logical device that is related to the pmc device.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
