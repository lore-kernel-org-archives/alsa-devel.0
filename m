From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Date: Thu, 26 Apr 2018 16:17:40 -0500
Message-ID: <20180426211740.GC25699@hector.attlocal.net>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426113911.GA21755@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: srinivas.kandagatla@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 12:39:11PM +0100, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> > ARP driver is made as a bus driver so that the apr devices can added removed
> 
> What is the plan for getting this patch merged?  I think the only review
> I've seen from maintainers thus far has been from Rob on the DT binding.
> It's obviously going to be a dependency for everything else.
> 
> Also just saw ARP->APR there.

Mark,

I just acked this, so it'd be great if you took it along with the others.  If
you don't want to do that, I can just pull it in with my pull requests.

Up to you,

Andy
