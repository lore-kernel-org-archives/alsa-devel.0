From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/4] ASoC: codecs: Add WSA881x Smart Speaker amplifier
 support
Date: Fri, 9 Aug 2019 10:26:30 +0530
Message-ID: <20190809045630.GH12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08-08-19, 15:45, Srinivas Kandagatla wrote:
> This patchset adds support to WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier which is SoundWire interfaced.
> This also adds support to some missing bits in SoundWire bus layer like
> Device Tree support and module_sdw_driver macro.
                                ^^^^^^^^^^^^^^^
That part we already applied :D

> This patchset along with DB845c machine driver and WCD934x codec driver
> has been tested on SDM845 SoC based DragonBoard DB845c with two
> WSA8810 speakers.
> 
> Most of the code in this driver is rework of Qualcomm downstream drivers
> used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.
> 
> TODO:
> 	Add thermal sensor support in WSA881x.
> 
> This patchset also depends on the soundwire Kconfig patch
> https://lkml.org/lkml/2019/7/18/834 from Pierre
> 
> Thanks,
> srini
> 
> Changes since v1 RFC:
> - bindings document renamed to slave.txt
> - fix error code from dt slave parsing
> 
> Srinivas Kandagatla (4):
>   dt-bindings: soundwire: add slave bindings
>   soundwire: core: add device tree support for slave devices
>   dt-bindings: ASoC: Add WSA881x bindings
>   ASoC: codecs: add wsa881x amplifier support
> 
>  .../bindings/sound/qcom,wsa881x.txt           |   27 +
>  .../devicetree/bindings/soundwire/slave.txt   |   46 +
>  drivers/soundwire/bus.c                       |    2 +
>  drivers/soundwire/bus.h                       |    1 +
>  drivers/soundwire/slave.c                     |   47 +
>  sound/soc/codecs/Kconfig                      |   10 +
>  sound/soc/codecs/Makefile                     |    2 +
>  sound/soc/codecs/wsa881x.c                    | 1160 +++++++++++++++++
>  8 files changed, 1295 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
>  create mode 100644 sound/soc/codecs/wsa881x.c
> 
> -- 
> 2.21.0

-- 
~Vinod
