From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 12/13] slimbus: qcom: Add runtime-pm
 support using clock-pause
Date: Thu, 23 Nov 2017 10:17:49 +0000
Message-ID: <20171123101749.ojiv6l52jjq6b55b@localhost.localdomain>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-13-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 10720266B67
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 11:17:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-13-srinivas.kandagatla@linaro.org>
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

On Wed, Nov 15, 2017 at 02:10:42PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> Slimbus HW mandates that clock-pause sequence has to be executed
> before disabling relevant interface and core clocks.
> Runtime-PM's autosuspend feature is used here to enter/exit low
> power mode for Qualcomm's Slimbus controller. Autosuspend feature
> enables driver to avoid changing power-modes too frequently since
> entering clock-pause is an expensive sequence
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int qcom_slim_suspend(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	if (!pm_runtime_enabled(dev) ||
> +		(!pm_runtime_suspended(dev))) {
> +		dev_dbg(dev, "system suspend");
> +		ret = qcom_slim_runtime_suspend(dev);
> +	}
> +
> +	/*
> +	 * If the clock pause failed due to active channels, there is
> +	 * a possibility that some audio stream is active during suspend.
> +	 * (e.g. modem usecase during suspend)
> +	 * We dont want to return suspend failure in that case so that
> +	 * display and relevant components can still go to suspend.
> +	 * If there is some other error, then it should prevent
> +	 * system level suspend
> +	 */
> +	if (ret == -EISCONN)
> +		ret = 0;

Who actually returns the EISCONN for this to catch? Or will that
be added to slim_ctrl_clk_pause once support for the audio
channels is added?

Thanks,
Charles

> +
> +	return ret;
> +}
