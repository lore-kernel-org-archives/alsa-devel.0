From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on arm64
Date: Mon, 27 May 2019 10:37:01 +0530
Message-ID: <20190527050701.GZ15118@vkoul-mobl>
References: <20190404081221.341-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kotas <jank@cadence.com>
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04-04-19, 09:12, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
> 
> readl and writel are undefined.
> This patch fixes that by including io.h.

Applied, thanks

-- 
~Vinod
