From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] dmaengine: Add transfer termination synchronization
 support
Date: Thu, 29 Oct 2015 10:26:50 +0900
Message-ID: <20151029012649.GB18368@vkoul-mobl.iind.intel.com>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.com>, Dan Williams <dan.j.williams@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Laurent Pinchart <renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Qiao Zhou <zhouqiao@marvell.com>, Shengjiu Wang <shengjiu.wang@freescale.com>, Matt Campbell <mcampbell@izotope.com>, Jonah Petri <jpetri@izotope.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2015 at 11:46:27AM +0200, Lars-Peter Clausen wrote:
> The DMAengine API has a long standing issue that is inherent to the API
> itself. For a client that calls dmaengine_terminate_all() it is not
> possible to properly synchronize the completion of any currently running
> complete callbacks to the current context. This means it is possible to end
> up with a use-after-free race condition if client frees resources that are
> accessed in a complete callback before the complete callback has finished
> running.
> 
> This patch series introduces a new explicit synchronization primitive to
> the DMAengine API which allows clients to ensure that all complete
> callbacks have finished running. This allows them to safely free any
> resources that might be accessed in a complete callback.
> 
> The series for now only implements synchronization support for a single
> driver and only updates single client to make use of the new API. If there
> is agreement on the general approach more will follow.

Thanks Lars for getting this done.

I have merged this to topic/test/async branch and this will be in next
kernel revision. We are too close to merge window right now

-- 
~Vinod
