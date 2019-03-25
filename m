From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/3] dmaengine: omap-dma: make omap_dma_filter_fn private
Date: Mon, 25 Mar 2019 10:26:32 +0530
Message-ID: <20190325045632.GG5348@vkoul-mobl>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-2-arnd@arndb.de>
 <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08-03-19, 16:32, Peter Ujfalusi wrote:
> 
> 
> On 07/03/2019 17.16, Arnd Bergmann wrote:
> > With the audio driver no longer referring to this function, it
> > can be made private to the dmaengine driver itself, and the
> > header file removed.

Applied, thanks

-- 
~Vinod
