From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/3] soundwire: intel: constify snd_soc_dai_ops structures
Date: Mon, 12 Nov 2018 15:36:29 +0530
Message-ID: <20181112100629.GC2477@vkoul-mobl>
References: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540647284-26728-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540647284-26728-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 27-10-18, 15:34, Julia Lawall wrote:
> The snd_soc_dai_ops structures are only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
> const as well.

Applied, thanks

-- 
~Vinod
