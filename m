From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [RFC PATCH 5/7] soundwire: add debugfs support
Date: Tue, 7 May 2019 07:56:08 +0200
Message-ID: <20190507055608.GC17986@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
 <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
 <20190506163810.GK3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190506163810.GK3845@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 06, 2019 at 10:08:10PM +0530, Vinod Koul wrote:
> Yes, but then device exit routine is supposed to do debugfs cleanup as
> well, so that would ensure these references are dropped at that point of
> time. Greg should that not take care of it or we *should* always do
> refcounting.

Always do refcounting.  How else can you "guarantee" that it is safe?
