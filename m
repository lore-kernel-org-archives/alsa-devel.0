From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: soc-core: use
 snd_soc_dai_link_component for cpu
Date: Fri, 18 Jan 2019 00:23:04 -0600
Message-ID: <66169467-169a-e3c1-e690-6dd0d7aefbc1@linux.intel.com>
References: <87bm4hm30t.wl-kuninori.morimoto.gx@renesas.com>
 <3b1f5c02-65e1-b43e-3556-129d48c2375d@linux.intel.com>
 <87ef9c6qob.wl-kuninori.morimoto.gx@renesas.com>
 <20190117124806.GA7003@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1629E266A7C
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 07:23:03 +0100 (CET)
In-Reply-To: <20190117124806.GA7003@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 1/17/19 6:48 AM, Mark Brown wrote:
> On Thu, Jan 17, 2019 at 10:14:39AM +0900, Kuninori Morimoto wrote:
> 
>> 	Subject: [alsa-devel] [PATCH v6 0/3] ASoC: Add Multi CPU DAI support
>> 	Date: Wed, 20 Jun 2018 16:24:14 +0530
> 
>> If so, actually I'm very waiting this patch series.
>> But, it seems nothing happen on ALSA ML after that.
>> So, I thought it was rejected or something happen.
> 
> It's definitely not rejected, it's just huge and goes right across the
> core so it's extremely difficult to do a review of.

It's a fair assumption that the multi-cpu stuff will only be needed for 
modern platforms and most likely for SoundWire support where we can have 
independent but synchronized links. Between my extended break and the 
SOF work I haven't had time to look into this so far, but it's on my 
radar now.
What I don't quite get is that what is needed to get the "modern" 
representation supported for CPU dais as well? There is currently a 
wrapper for the codec_dais, couldn't we do the same for the cpu_dais and 
remove it when all drivers have moved?
My point is that if internally only the modern representation is used 
then the extensions to multi-cpus will be easier.
What am I missing?
