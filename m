From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [Test Request v2] Component level pcm_new/pcm_free
 v2
Date: Mon, 24 Jul 2017 18:31:57 +0200
Message-ID: <3d74148b-0535-2353-6284-1ad5b5ee3a72@st.com>
References: <87o9seqw21.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 17143266BBC
 for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2017 18:31:59 +0200 (CEST)
In-Reply-To: <87o9seqw21.wl%kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>, Brian Norris <briannorris@chromium.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Kuninori

On 07/21/2017 06:05 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, Johan, Brian
> 
> These are v2 of Component level pcm_new/free patches v2.
> Previous patch-set still had issue if 2 platform were registered.
> I think this version solved this issue.
> But, I'm not sure if you are using unexpected usage which I don't use.
> So, can you please test these patches ?
> replacing platform to component is based on this patch-set

I came across the issue last week on V4.12 (without your V1 patches).
I reproduced issue with my driver:
https://patchwork.kernel.org/patch/9630821/
I declared 2 DAIs with associated platform. pcm_new ops was call twice
times.

Applying your patches solves my issue.

Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks.

Arnaud

> 
> Kuninori Morimoto (3):
>       ASoC: soc-core: add snd_soc_rtdcom_xxx()
>       ASoC: use snd_soc_rtdcom_add() and convert to consistent operation
>       ASoC: add Component level pcm_new/pcm_free v2
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
