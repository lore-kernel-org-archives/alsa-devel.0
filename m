From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2] soundwire: stream: fix bad unlock balance
Date: Thu, 6 Jun 2019 22:48:07 +0530
Message-ID: <20190606171807.GB9160@vkoul-mobl.Dlink>
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06-06-19, 12:22, Srinivas Kandagatla wrote:
> multi bank switching code takes lock on condition but releases without
> any check resulting in below warning.
> This patch fixes this.
> 
>  =====================================
>  WARNING: bad unlock balance detected!
>  5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>  -------------------------------------
>  aplay/2954 is trying to release lock (&bus->msg_lock) at:
>  do_bank_switch+0x21c/0x480
>  but there are no more locks to release!

Applied after changing the log suggested by Pierre, thanks
-- 
~Vinod
