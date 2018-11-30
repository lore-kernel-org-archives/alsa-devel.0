From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 0/5] ASoC: qdsp6: add compress offload support
Date: Fri, 30 Nov 2018 17:52:20 +0530
Message-ID: <20181130122220.GO3175@vkoul-mobl.Dlink>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

On 15-11-18, 18:13, Srinivas Kandagatla wrote:
> This patchset adds support to very basic MP3 playback compress offload
> support via QDSP ASM module.
> 
> Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
> tinycompress library.
> 
> Adding other codec support should be trivial w.r.t qdsp6 side, however
> there are other dependencies like compress UAPI header changes and
> FastRPC which are being worked in parallel. Once ready will post them!

Thanks Srini, with this we will have compress support upstream for a
public board.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
