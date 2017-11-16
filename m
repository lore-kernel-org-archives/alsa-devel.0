From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 04/14] soundwire: Add MIPI DisCo
	property helpers
Date: Thu, 16 Nov 2017 22:34:43 +0530
Message-ID: <20171116170443.GE3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
 <ce51acdd-7f56-e6bf-4067-393f7118c4c3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9B8266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:01:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ce51acdd-7f56-e6bf-4067-393f7118c4c3@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Sudheer Papothi <spapothi@codeaurora.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 04:05:34PM +0000, Srinivas Kandagatla wrote:
> Few Minor comments!!

All are helpful :)

> >+/**
> >+ * enum sdw_clk_stop_mode: Clock Stop modes
> >+ *
> >+ * @SDW_CLK_STOP_MODE_0: Slave can continue operation seamlessly on clock
> >+ * restart
> >+ * @SDW_CLK_STOP_MODE_1: Slave may have entered a deeper power-saving mode,
> Should be MODE0 and MODE1.. here

yes thanks for spotting

> >+/**
> >+ * struct sdw_dpn_audio_mode: Audio mode properties for DPn
> >+ *
> >+ * @bus_min_freq: Minimum bus frequency, in Hz
> >+ * @bus_max_freq: Maximum bus frequency, in Hz
> >+ * @bus_num_freq: Number of discrete frequencies supported
> >+ * @bus_freq: Discrete bus frequencies, in Hz
> >+ * @bus_min_freq: Minimum sampling frequency, in Hz
> Should be min_freq
> >+ * @bus_max_freq: Maximum sampling bus frequency, in Hz
> Should be max_freq
> >+ * @bus_num_freq: Number of discrete sampling frequency supported
> Should be num_freq
> 
> >+ * @bus_freq: Discrete sampling frequencies, in Hz
> Should be freq

yes, will fix

> >+ * @p15_behave: Slave behavior when the Master attempts a read to the Port15
> >+ * alias
> >+ * @lane_control_support:
> 
> ?? do description here..

will add

-- 
~Vinod
