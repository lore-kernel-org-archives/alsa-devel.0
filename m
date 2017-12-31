From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] slimbus: qcom: fix incompatible pointer warning
Date: Sun, 31 Dec 2017 17:52:32 +0100
Message-ID: <20171231165232.GA6884@kroah.com>
References: <20171231142311.7952-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171231142311.7952-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 31, 2017 at 02:23:11PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> One of the pointer passed to dmam_alloc_coherent seems to be
> phys_addr_t * instead of dma_addr_t *. This address will be
> used by dma apis, so change this to proper type.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Also reported-by Arnd :(
