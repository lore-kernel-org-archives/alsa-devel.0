From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: stream: fix out of boundary access on port
 properties
Date: Mon, 27 May 2019 10:34:38 +0530
Message-ID: <20190527050438.GY15118@vkoul-mobl>
References: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22-05-19, 17:24, Srinivas Kandagatla wrote:
> Assigning local iterator to array element and using it again for
> indexing would cross the array boundary.
> Fix this by directly referring array element without using the local
> variable.

Applied, thanks

-- 
~Vinod
