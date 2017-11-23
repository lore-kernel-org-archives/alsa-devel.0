From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 07/13] slimbus: Add support for
	'clock-pause' feature
Date: Thu, 23 Nov 2017 07:28:00 +0000
Message-ID: <20171123072800.z2pkmelom374zr63@localhost.localdomain>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C98266CFB
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 08:28:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-8-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:37PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> Per slimbus specification, a reconfiguration sequence known as
> 'clock pause' needs to be broadcast over the bus while entering low-
> power mode. Clock-pause is initiated by the controller driver.
> To exit clock-pause, controller typically wakes up the framer device.
> Since wakeup precedure is controller-specific, framework calls it via
> controller's function pointer to invoke it.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> +/**
> + * struct slim_sched: Framework uses this structure internally for scheduling.

Missing kernel doc for clkgear here.

> + * @clk_state: Controller's clock state from enum slim_clk_state
> + * @pause_comp: Signals completion of clock pause sequence. This is useful when
> + *	client tries to call slimbus transaction when controller is entering
> + *	clock pause.
> + * @m_reconf: This mutex is held until current reconfiguration (data channel
> + *	scheduling, message bandwidth reservation) is done. Message APIs can
> + *	use the bus concurrently when this mutex is held since elemental access
> + *	messages can be sent on the bus when reconfiguration is in progress.
> + */
> +struct slim_sched {
> +	int			clkgear;
> +	enum slim_clk_state	clk_state;
> +	struct completion	pause_comp;
> +	struct mutex		m_reconf;
> +};

Thanks,
Charles
