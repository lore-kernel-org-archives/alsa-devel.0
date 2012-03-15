From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
Date: Thu, 15 Mar 2012 22:21:18 +0800
Message-ID: <20120315142115.GB6065@S2101-09.ap.freescale.net>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4F61F080.4090800@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2012 at 01:37:06PM +0000, Tabi Timur-B04825 wrote:
...
> The PowerPC MPC8610 has two SSIs, and I have a hacked up board that has 
> both connected to two CS4270s.  This is how I tested multiple SSI support 
> in my driver.
> 
> Since my driver supports any number of SSIs, I expect any changes to it to 
> continue that support.
> 
I think it can still easily get supported with the binding like below.

sound {
      compatible = "fsl,imx51-babbage-sgtl5000",
                   "fsl,imx-audio-sgtl5000";
      model = "imx51-babbage-sgtl5000";
      ssi-controller = <&ssi1, &ssi2>;
      audio-codec = <&sgtl5000_1, &sgtl5000_2>;
      mux-int-port = <1>;
      mux-ext-port = <3>;
};

The only difference will be both ssi-controller and audio-codec become
an array of phandles.

...
> I admit I may have been too hasty in giving that ACK, because I did not 
> take the time to study the binding.  I figured that the new binding was 
> superior to what I came up with years ago.
> 
> Now that I've studied the binding, I no longer believe that.  I don't 
> understand what's so wonderful about the new binding that my driver has to 
> support it *and* the old binding.  I think it would be easier if i.MX uses 
> the original binding.
> 
I do not think it would be easier for imx.  Looking at the imx-sgtl5000
binding, you will find we have audmux port configuration encoded there.
How would you suggest to get that fit into the PowerPC binding?

...
> Even if the new binding is "better", I do not see how it's SOOOOO much 
> better that my driver has to support it.  The drawback in supporting both 
> is the added complexity.

If you insist on that the driver should only support single binding,
I would rather change mpc8610_hpcd and p1022_ds to use the new binding.

...
> But the driver already does this!  No one's asking you to add the code to 
> perform these tasks.  Just use the existing code.

Again, what's your suggestion to support audmux configuration with the
existing binding?

-- 
Regards,
Shawn
