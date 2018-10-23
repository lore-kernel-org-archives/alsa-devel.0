From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [RFC PATCH 0/4] Initial prototype of DAPM sample
 rate domains
Date: Tue, 23 Oct 2018 15:36:53 +0100
Message-ID: <20181023143653.GB16508@imbe.wolfsonmicro.main>
References: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
 <bd222042-50e3-4626-ef7f-5d5692cba650@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 559F22675C3
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 16:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd222042-50e3-4626-ef7f-5d5692cba650@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 22, 2018 at 09:27:13AM -0500, Pierre-Louis Bossart wrote:
> 
> On 10/11/18 11:28 AM, Charles Keepax wrote:
> My feedback would be: why limit the domains to sample rate
> definition? we can also have additional criteria such as number of
> channels, channel maps and bit depth - maybe also audio/non-audio
> for compressed stuff. It'd be interesting to start with a non-scalar
> descriptor from day1. To some extent we'd also want something
> similar to .info definitions, with domains defined with masks to
> allow for flexibility in the conversions and easier bridge
> implementations. e.g. it'd be interesting to have a domain
> definition supporting more than one sampling frequency (8, 16,
> 48kHz) with the bridge doing the relevant conversion to adapt to the
> connected domain (fixed 48kHz DAI for example)
> 
> Thanks for starting the discussion!

I don't think there really is anything about the way I am
approaching the code that will limit this to just sample rates,
it's more that is the part I need at the moment so is what
I am implementing. I have basically a "domain" structure,
that gets assigned as the groups power up, this is in no way
specific to rates. We can just extend that struct to have other
properties and add new ops on the domains as people discover
additional features they require. Currently at that point in
the code you will see a TODO which says to consider using a
hw_params struct instead of just an int for the rate. I think
based on your comments and others at the conference I will
definitely be switching to that in the next spin. Although
implementing the additional callbacks etc. is not something I
can find sensible use-cases for on our devices, so someone else
might need to pick up that part.

Thanks,
Charles
