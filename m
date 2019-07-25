From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 15/22] docs: index.rst: don't use genindex for pdf output
Date: Thu, 25 Jul 2019 19:14:49 +0530
Message-ID: <20190725134449.GY12733@vkoul-mobl.Dlink>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
 <45d57666e5738a0b85e948b0e94151fe1b1f9274.1563792334.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45d57666e5738a0b85e948b0e94151fe1b1f9274.1563792334.git.mchehab+samsung@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-doc@vger.kernel.org, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, netdev@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22-07-19, 08:07, Mauro Carvalho Chehab wrote:
> The genindex logic is meant to be used only for html output, as
> pdf build has its own way to generate indexes.


>  Documentation/driver-api/dmaengine/index.rst      | 2 +-
>  Documentation/driver-api/soundwire/index.rst      | 2 +-

For dmaengine and soundwire:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
