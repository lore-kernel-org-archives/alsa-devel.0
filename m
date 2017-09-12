From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: arizona: Add audio device tree bindings
Date: Tue, 12 Sep 2017 16:14:57 -0500
Message-ID: <20170912211457.uenpih5b7bfdzv6j@rob-hp-laptop>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
 <20170904154154.4395-4-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170904154154.4395-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 04, 2017 at 04:41:50PM +0100, Charles Keepax wrote:
> In keeping with the style of the rest of this drivers device tree
> bindings split the audio device tree bindings into their own document.
> It should be noted this patch makes no change to the binding itself
> just moves the documentation into a specific file for the audio
> binding. For easy of merging a separate patch removes the current
> documentation from the MFD binding documentation.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/sound/wlf,arizona.txt      | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt

Acked-by: Rob Herring <robh@kernel.org>
