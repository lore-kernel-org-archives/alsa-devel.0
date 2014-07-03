From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
 multicodec
Date: Thu, 03 Jul 2014 14:09:11 -0500
Message-ID: <53B5AA57.5060804@linux.intel.com>
References: <53B400DE.3040205@baylibre.com> <20140703064147.GK2296@intel.com>
 <53B539E8.1000301@baylibre.com> <53B53C6B.8020707@metafoo.de>
 <53B540EE.30009@baylibre.com> <53B541F0.1040105@metafoo.de>
 <53B5428F.9050100@baylibre.com> <20140703120613.GP2296@intel.com>
 <20140703121846.GB410@sirena.org.uk> <20140703161517.GQ2296@intel.com>
 <20140703183804.GO410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7598A26590C
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 21:09:17 +0200 (CEST)
In-Reply-To: <20140703183804.GO410@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, misael.lopez@ti.com, Benoit Cousson <bcousson@baylibre.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


>>> The use case tends to be for applications that have one device per
>>> physical output.  This isn't normally mobile, it's normally high
>>> performance audio applications where people are doing things to try to
>>> electrically isolate the analogue outputs or dealing with high power so
>>> need to keep speaker outputs physically separate.  I can imagine set top
>>> box type applications (which do use offloaded media decode) doing this.
>
>> Not sure if I follow you, I have no idea of how these systems work.
>
> They're having the SoC play stereo (or whatever) data and then having
> multiple CODECs on the bus, each parsing some subset of the channels
> (typically one channel per CODEC).

This sort of stream aggregation/split is a very valid use case that's 
coming to mobiles in the very near future with new interfaces being 
standardized.

>
>> So how can we have a situation where we have compressed device linked to
>> multiple codecs?
>
> If it's intended to be DPCM only (which it iss now I think about it) it
> sounds like you can't have it linked to *any* real CODECS, at least not
> directly!

there are very few references to codec_dais in soc-compress and some are 
in sections copy/pasted from soc-pcm, which makes me wonder as well if 
they needed to be there in the first place.
-Pierre
