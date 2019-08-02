From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple
 status reports per Slave
Date: Fri, 2 Aug 2019 21:31:15 +0530
Message-ID: <20190802160115.GS12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190802122003.GQ12733@vkoul-mobl.Dlink>
 <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02-08-19, 10:29, Pierre-Louis Bossart wrote:
> On 8/2/19 7:20 AM, Vinod Koul wrote:
> > On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

> > > +				status[i] = SDW_SLAVE_UNATTACHED;
> > > +				break;
> > > +			case 1:
> > > +				status[i] = SDW_SLAVE_ATTACHED;
> > > +				break;
> > > +			case 2:
> > > +				status[i] = SDW_SLAVE_ALERT;
> > > +				break;
> > > +			default:
> > > +				status[i] = SDW_SLAVE_RESERVED;
> > > +				break;
> > > +			}
> > 
> > we have same logic in the code block preceding this, maybe good idea to
> > write a helper and use for both
> 
> Yes, I am thinking about this. There are multiple cases where we want to
> re-check the status and clear some bits, so helpers would be good.
> 
> > 
> > Also IIRC we can have multiple status set right?
> 
> Yes, the status bits are sticky and mirror all values reported in PING
> frames. I am still working on how to clear those bits, there are cases where
> we clear bits and end-up never hearing from that device ever again. classic
> edge/level issue I suppose.

Then the case logic above doesn't work, it should be like the code block
preceding this..

Thanks
-- 
~Vinod
