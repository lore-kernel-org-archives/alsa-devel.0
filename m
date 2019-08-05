From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 01/29] ASoC: Intel: skl-pcm: disable
 skl_get_time_info
Date: Mon, 5 Aug 2019 11:06:13 -0500
Message-ID: <6c3a00c9-fa0c-98ea-c4f1-34e995d80559@linux.intel.com>
References: <87pnlx5rq3.wl-kuninori.morimoto.gx@renesas.com>
 <87o91h5rp5.wl-kuninori.morimoto.gx@renesas.com>
 <20190805154512.GJ6432@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C2EAF8011B
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:14:07 +0200 (CEST)
In-Reply-To: <20190805154512.GJ6432@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/5/19 10:45 AM, Mark Brown wrote:
> On Fri, Jul 26, 2019 at 01:49:17PM +0900, Kuninori Morimoto wrote:
> 
>> Now, ALSA SoC doesn't setup rtd->ops.get_time_info.
>> This means it never used in ALSA SoC even if
>> sound driver had .get_time_info.
> 
>> This patch disable .get_time_info from skl-pcm.c.
>> Because we might be going to support it in the future,
>> it uses #if 0.
> 
> The #if 0 here isn't exactly nice...  it'd be better to just implement
> get_time_info().

IIRC Cezary's team had a patch reviewed internally at Intel to add the 
missing pieces, so this will be supported soonish (likely after the 
Summer break).
