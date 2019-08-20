From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 09/25] ASoC: soc-core: tidyup for
 snd_soc_dapm_add_routes()
Date: Tue, 20 Aug 2019 12:39:55 -0500
Message-ID: <74038eed-a134-5c41-b402-dedf0ace8134@linux.intel.com>
References: <87pnlhahr6.wl-kuninori.morimoto.gx@renesas.com>
 <87d0hhahon.wl-kuninori.morimoto.gx@renesas.com>
 <928df91b-997f-c1eb-5ab5-bda1fc374c1a@intel.com>
 <27f25fb3-1d50-2b60-3e3b-da61eef1f6ad@linux.intel.com>
 <1bbf24d4-c6cb-00ee-ffbe-18da53d1f942@intel.com>
 <fc461e37-7363-af5a-63a4-9db7a2b8c1cd@linux.intel.com>
 <b3d7dc47-36e9-749f-94be-32854de624be@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46BFDF803F3
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 19:39:59 +0200 (CEST)
In-Reply-To: <b3d7dc47-36e9-749f-94be-32854de624be@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>>>>> Question is simple: are we staying with all-for-one/ one-for-all 
>>>>> approach or we reverting to permissive behavior?
>>>>
>>>> Can you elaborate in which test case this patch creates a problem? 
>>>> Just curious why the route addition fails in the first place.
>>>
>>> If snd_soc_instantiate_card fails so does any test, really. Red wall 
>>> was easy to spot even for a hungry developer : )
>>>
>>> Our cnl_rt274 board declares several routes, yet our topology does 
>>> not provide necessary info for all of them. And thus, addition of 
>>> some routes fails. This was fine till now. That's also why I'd 
>>> mentioned in the very first sentence: it might be simply a board 
>>> issue. Maybe we should have never abused permissive behavior in the 
>>> first place.
>>
>> Yep, and that driver is not upstream as well so Intel can't complain 
>> here...
> 
> ??
> 
> It's not about complaining, rather starting a discussion. If I were 
> using boards with topology not fully matching its board equivalent 
> (because if has never been required of me) then there may be others who 
> did the exact same trick. Your card won't be enumerated now == change of 
> behavior.
> 
> Board bxt_rt298 is upstreamed and the exact same failures could be 
> reproduced since topology has something to say here too..

That's different. For bxt_rt298 there is a topology that was released, 
and if it's incorrect it should be fixed.
I *hope* we are not going to see such regressions with SKL/KBL 
Chromebooks, that would be more of a problem since there are more users.
