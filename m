From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 04/14] soundwire: Add MIPI DisCo property helpers
Date: Thu, 16 Nov 2017 16:05:34 +0000
Message-ID: <ce51acdd-7f56-e6bf-4067-393f7118c4c3@linaro.org>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Few Minor comments!!

On 10/11/17 11:49, Vinod Koul wrote:

> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   drivers/soundwire/Makefile     |   2 +-
>   drivers/soundwire/bus.c        |   8 +
>   drivers/soundwire/bus_type.c   |  18 ++
>   drivers/soundwire/mipi_disco.c | 422 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/soundwire/sdw.h  | 284 +++++++++++++++++++++++++++
>   5 files changed, 733 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soundwire/mipi_disco.c
> 

>
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 9070aec77576..741b29d974fe 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -84,6 +84,260 @@ enum sdw_slave_status {
>   };
>   

> +/**
> + * enum sdw_clk_stop_mode: Clock Stop modes
> + *
> + * @SDW_CLK_STOP_MODE_0: Slave can continue operation seamlessly on clock
> + * restart
> + * @SDW_CLK_STOP_MODE_1: Slave may have entered a deeper power-saving mode,
Should be MODE0 and MODE1.. here

> + * not capable of continuing operation seamlessly when the clock restarts
> + */
> +enum sdw_clk_stop_mode {
> +	SDW_CLK_STOP_MODE0 = 1,
> +	SDW_CLK_STOP_MODE1 = 2,
> +};
> +

> +/**
> + * struct sdw_dpn_audio_mode: Audio mode properties for DPn
> + *
> + * @bus_min_freq: Minimum bus frequency, in Hz
> + * @bus_max_freq: Maximum bus frequency, in Hz
> + * @bus_num_freq: Number of discrete frequencies supported
> + * @bus_freq: Discrete bus frequencies, in Hz
> + * @bus_min_freq: Minimum sampling frequency, in Hz
Should be min_freq
> + * @bus_max_freq: Maximum sampling bus frequency, in Hz
Should be max_freq
> + * @bus_num_freq: Number of discrete sampling frequency supported
Should be num_freq

> + * @bus_freq: Discrete sampling frequencies, in Hz
Should be freq
> + * @prep_ch_behave: Specifies the dependencies between Channel Prepare
> + * sequence and bus clock configuration
> + * If 0, Channel Prepare can happen at any Bus clock rate
> + * If 1, Channel Prepare sequence shall happen only after Bus clock is
> + * changed to a frequency supported by this mode or compatible modes
> + * described by the next field
> + * @glitchless: Bitmap describing possible glitchless transitions from this
> + * Audio Mode to other Audio Modes
> + */
> +struct sdw_dpn_audio_mode {
> +	u32 bus_min_freq;
> +	u32 bus_max_freq;
> +	u32 bus_num_freq;
> +	u32 *bus_freq;
> +	u32 max_freq;
> +	u32 min_freq;
> +	u32 num_freq;
> +	u32 *freq;
> +	u32 prep_ch_behave;
> +	u32 glitchless;
> +};
> +
>
> +/**
> + * struct sdw_slave_prop: SoundWire Slave properties
> + *
> + * @mipi_revision: Spec version of the implementation
> + * @wake_capable: Wake-up events are supported
> + * @test_mode_capable: If test mode is supported
> + * @clk_stop_mode1: Clock-Stop Mode 1 is supported
> + * @simple_clk_stop_capable: Simple clock mode is supported
> + * @clk_stop_timeout: Worst-case latency of the Clock Stop Prepare State
> + * Machine transitions, in milliseconds
> + * @ch_prep_timeout: Worst-case latency of the Channel Prepare State Machine
> + * transitions, in milliseconds
> + * @reset_behave: Slave keeps the status of the SlaveStopClockPrepare
> + * state machine (P=1 SCSP_SM) after exit from clock-stop mode1
> + * @high_PHY_capable: Slave is HighPHY capable
> + * @paging_support: Slave implements paging registers SCP_AddrPage1 and
> + * SCP_AddrPage2
> + * @bank_delay_support: Slave implements bank delay/bridge support registers
> + * SCP_BankDelay and SCP_NextFrame
> + * @p15_behave: Slave behavior when the Master attempts a read to the Port15
> + * alias
> + * @lane_control_support:

?? do description here..

> + * @master_count: Number of Masters present on this Slave
> + * @source_ports: Bitmap identifying source ports
> + * @sink_ports: Bitmap identifying sink ports
> + * @dp0_prop: Data Port 0 properties
> + * @src_dpn_prop: Source Data Port N properties
> + * @sink_dpn_prop: Sink Data Port N properties
> + */
> +struct sdw_slave_prop {
> +	u32 mipi_revision;
> +	bool wake_capable;
> +	bool test_mode_capable;
> +	bool clk_stop_mode1;
> +	bool simple_clk_stop_capable;
> +	u32 clk_stop_timeout;
> +	u32 ch_prep_timeout;
> +	enum sdw_clk_stop_reset_behave reset_behave;
> +	bool high_PHY_capable;
> +	bool paging_support;
> +	bool bank_delay_support;
> +	enum sdw_p15_behave p15_behave;
> +	bool lane_control_support;
> +	u32 master_count;
> +	u32 source_ports;
> +	u32 sink_ports;
> +	struct sdw_dp0_prop *dp0_prop;
> +	struct sdw_dpn_prop *src_dpn_prop;
> +	struct sdw_dpn_prop *sink_dpn_prop;
> +};
> +
