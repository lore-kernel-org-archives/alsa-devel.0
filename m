From: Vinod <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 2/5] ASoC: qcom: Add support to parse
 common audio device nodes
Date: Mon, 9 Jul 2018 13:13:15 +0530
Message-ID: <20180709074315.GA22377@vkoul-mobl>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
 <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06-07-18, 18:51, Srinivas Kandagatla wrote:
> 
> 
> On 06/07/18 10:43, Rohit kumar wrote:
> > This adds support to parse cpu, platform and codec
> > device nodes and add them in dai-links. Also, add
> > API to add slave components associated with machine
> > driver.
> > 
> > Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> > ---
> >   sound/soc/qcom/Kconfig  |   3 +
> >   sound/soc/qcom/Makefile |   1 +
> >   sound/soc/qcom/common.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   sound/soc/qcom/common.h |  14 +++++
> >   4 files changed, 168 insertions(+)
> >   create mode 100644 sound/soc/qcom/common.c
> 
> common.c seems to miss

Btw do you need a new Kconfig symbol for this?

Alternate option would be to just add common.o to wherever it is needed

-- 
~Vinod
