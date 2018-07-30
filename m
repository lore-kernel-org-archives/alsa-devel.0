From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 00/10] ASoC: Add support to WCD9335
	Audio Codec
Date: Mon, 30 Jul 2018 10:19:50 +0530
Message-ID: <20180730044950.GE3661@vkoul-mobl>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id B1F692676DD
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 06:50:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On 27-07-18, 13:17, Srinivas Kandagatla wrote:
> Thankyou for reviewing v1 patchset, here is v2 addressing comments from v1.
> 
> Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
> It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
> and MSM8956 chipsets.
> 
> WCD9335 had multiple functional blocks, like: Soundwire controller,
> interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
> Ultrasonic proximity and pen detection, Battery-voltage monitoring and
> Codec processing engine.
> 
> Currently this patchset has been only tested with SLIMbus interface due
> to hardware avaiablity, but it can be easily made to work with both SLIMbus
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
> so credits to various authors.
> 
> WCD9335 can be interfaced via I2S/I2C or SLIMbus. 
> 
> Here is my test branch incase someone want to try this out:
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Apart from the few nitpicks I noticed, this looks good to me, so:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
