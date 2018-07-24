From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 00/12] mfd: Add support to WCD9335 Audio Codec
Date: Tue, 24 Jul 2018 11:23:58 +0530
Message-ID: <20180724055358.GI3219@vkoul-mobl>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23-07-18, 16:53, Srinivas Kandagatla wrote:
> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
> It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
> and MSM8956 chipsets.
> 
> WCD9335 had multiple functional blocks, like: Soundwire controller,
> interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),

MBHC ??

> Ultrasonic proximity and pen detection, Battery-voltage monitoring and
> Codec processing engine.
> 
> Currently this patchset has been only tested with SLIMbus interface due
> to hardware avaiablity, but it can be easily made to work with both SLIMbus

typo avaiablity

> and I2C/I2S.    
> 
> This patchset adds very basic playback and capture support witout much
> fancy features. New features will be added once the basic support is in.
> This patchset is tested on top of linux-next on DB820c for both playback
> and capture paths.
> 
> This patchset also depends on the SLIMbus Stream apis which is already merged
> via char-misc tree for 4.19.
> 
> Some parts of the code has been inherited from Qualcomm andriod kernel,

typo andriod

-- 
~Vinod
