From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 000/145] ASoC: modern dai_link style support
Date: Tue, 28 May 2019 10:34:56 -0500
Message-ID: <63a87d66-1058-8c36-6d7d-52cceb895b6c@linux.intel.com>
References: <87sgt7p3zo.wl-kuninori.morimoto.gx@renesas.com>
 <03cf0a3b-3464-57fd-c313-cfe8db01d2cd@linux.intel.com>
 <8736l0u1dc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B75F8F896B8
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:34:58 +0200 (CEST)
In-Reply-To: <8736l0u1dc.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


> Ahh, yes, it is using 1 tag only and not aligned to open parenthesis.
> But, if it aligned to open parenthesis, then, it will be 80 char over
> warning instead.
> # ?? or does your "functional code changes" means "fixup checkpatch.pl" ?
> 
> But, yes, can you send me the changes ?

I'll send you suggested changes, I saw other cases where we want to use 
dmic_codec instead of dmic01_codec.
Small potatoes really, this is a really nice work you've been doing!
