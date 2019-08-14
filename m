From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
Date: Wed, 14 Aug 2019 09:35:58 +0530
Message-ID: <20190814040558.GT12733@vkoul-mobl.Dlink>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
 <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
 <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
 <3fd3c98c-eb25-7040-3089-f5e5bc9d24ee@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3fd3c98c-eb25-7040-3089-f5e5bc9d24ee@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 13-08-19, 14:08, Pierre-Louis Bossart wrote:
> On 8/13/19 1:17 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 13/08/2019 15:34, Pierre-Louis Bossart wrote:
> > > On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
> > > > From: Vinod Koul <vkoul@kernel.org>
> > > > 
> > > > This callback allows masters to compute the bus parameters required.
> > > 
> > > This looks like a partial use of the patch ('soundwire: Add Intel
> > > resource management algorithm')? see comments below
> > > 
> > 
> > Yes it duplicate indeed!
> > 
> > I will use that patch!
> 
> Actually please don't...
> we found issues with the Intel allocation so I'd rather have the big Intel
> patch split into two parts, with callbacks+prepare/deprepare changes going
> in first. It'll be much faster/nicer for everyone.

I was about to say that as well. I think lets take this as is and Intel
algo can be on top of this. That seems easier for everyone to sort
dependencies

-- 
~Vinod
