From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Wed, 16 Mar 2011 17:47:51 +0530
Message-ID: <1300277871.9428.17.camel@vkoul-udesk3>
References: <4D7FB076.30300@codeaurora.org>
	 <20110316103814.GA8369@sirena.org.uk>
	 <1300273162.9428.10.camel@vkoul-udesk3>
	 <20110316115627.GC14125@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110316115627.GC14125@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-16 at 17:26 +0530, Mark Brown wrote:
> It would be nice to have a standard userspace API for this but I'm not
> aware of anyone who's looked at it in detail and you start having to
> also take into account other algorithms that are running on the device
> so there's nothing to point people at right now and no real prospect of
> there being.  I don't know if it's something we can resolve entirely in
> the kernel as I'm aware that some of the DSP implementations have
> non-trivial management code in userspace that they talk to which may
> mean that the standard API has to be a userspace one.  There's also the
> difference between memory to memory implementations (which fit into a
> userspace chain much more readily) and tunneled implementations (which
> do need new infrastructure).
Yes, I was also thinking this needs to have both the user land component
for applications to use and kernel land for DSP implementations.
Agreed, this should also comprehend algorithms.

-- 
~Vinod

