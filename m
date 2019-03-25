From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: edma: make edma_filter_fn private
Date: Mon, 25 Mar 2019 10:26:57 +0530
Message-ID: <20190325045657.GH5348@vkoul-mobl>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307151646.1016966-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07-03-19, 16:16, Arnd Bergmann wrote:
> With the audio driver no longer referring to this function, it
> can be made private to the dmaengine driver itself, and the
> header file removed.

Applied, thanks

-- 
~Vinod
