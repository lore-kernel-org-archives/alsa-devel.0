From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: soc-core: use
 snd_soc_dai_link_component for cpu
Date: Fri, 18 Jan 2019 08:34:27 -0600
Message-ID: <7522f133-0676-ea8c-a9d2-5d1ea4798ffa@linux.intel.com>
References: <87bm4hm30t.wl-kuninori.morimoto.gx@renesas.com>
 <3b1f5c02-65e1-b43e-3556-129d48c2375d@linux.intel.com>
 <87ef9c6qob.wl-kuninori.morimoto.gx@renesas.com>
 <20190117124806.GA7003@sirena.org.uk>
 <66169467-169a-e3c1-e690-6dd0d7aefbc1@linux.intel.com>
 <87lg3itn12.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D22F52667E7
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 15:34:29 +0100 (CET)
In-Reply-To: <87lg3itn12.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>> What I don't quite get is that what is needed to get the "modern"
>> representation supported for CPU dais as well? There is currently a
>> wrapper for the codec_dais, couldn't we do the same for the cpu_dais
>> and remove it when all drivers have moved?
> Sorry 50% English issue, but does this "wrapper for the codec_dais" means
> we are converting single codec to muliti codec style via snd_soc_init_multicodec() ?
> If so, yes, we can have same logic for CPU.
Yes exactly what I meant indeed.
>
>> My point is that if internally only the modern representation is used
>> then the extensions to multi-cpus will be easier.
> Yeah agree.
> How to do it seems need some agreement, I think...
Thank you for the clarification. I started working on updating all the 
Intel stuff to the modern representation, will look at cpu next.
