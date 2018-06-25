From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Mon, 25 Jun 2018 11:03:30 +0100
Message-ID: <20180625100330.GI18740@imbe.wolfsonmicro.main>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-2-git-send-email-shreyas.nc@intel.com>
 <d6b2b5a1-a714-e72c-8012-52a40e4e9447@linux.intel.com>
 <20180622041437.GP3116@snc-desk>
 <dffba216-f4ff-4ec6-24f0-f9c7bbdf4b68@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BA522670D7
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 12:03:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dffba216-f4ff-4ec6-24f0-f9c7bbdf4b68@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 22, 2018 at 10:13:28AM -0500, Pierre-Louis Bossart wrote:
> >>>  	/* the component which has non_legacy_dai_naming is Codec */
> >>>-	if (cpu_dai->component->driver->non_legacy_dai_naming) {
> >>Not sure if the code refactoring below makes sense in a codec-codec link,
> >>you probably wouldn't have multiple cpu_dais then, would you?
> >
> >Yes, a valid point. You suggest to leave this piece of code as is ?
> 
> Not necessarily. I don't understand how the codec-codec and multi
> cpu_dais intersect, all I am asking for is a check if this change is
> needed or not.
> 

Seems plausible to me you could have multiple cpu_dais on CODEC
to CODEC links. Really for CODEC to CODEC links the whole
CPU/CODEC distinction doesn't really exist. It doesn't really
matter which end you make which, so I guess it makes sense to
support multiple CPU DAIs on such a link.

Thanks,
Charles
