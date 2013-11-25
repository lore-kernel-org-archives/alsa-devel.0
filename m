From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ASOC: stream widget created two times
Date: Mon, 25 Nov 2013 18:48:02 +0000
Message-ID: <1385405282.2479.8.camel@loki>
References: <A4ED9057F6AB394EB1BF089A056089A853220EBBA8@SAFEX1MAIL5.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F381F261B11
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 19:48:06 +0100 (CET)
In-Reply-To: <A4ED9057F6AB394EB1BF089A056089A853220EBBA8@SAFEX1MAIL5.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@cassiel.sirena.org.uk" <broonie@cassiel.sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-11-22 at 15:19 +0100, Arnaud POULIQUEN wrote:
> Hello,
> I 'm newbie on asoc dev. I'm trying to develop a driver based on dynamic
> PCM implementation with backend and frontend. I'm working on 3.10
> 
> I have declared a FE  :
> {
>             .name = "MMDL0",
>             .stream_name = "MM DL0 Frontend",
>             .cpu_dai_name = "mm_dl0",
> 
>             .codec_name = "snd-soc-dummy",
>             .codec_dai_name = "snd-soc-dummy-dai",
> 
>             .dynamic=1,
>             .trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
>             .ignore_pmdown_time = 1, /* Power down without delay */
>             .init = sti_dummy_init,
> },
> 
> CPU DAI associated:
> static struct snd_soc_dai_driver sti_frontend_cpu_dais[] = {
>             {
>                         .name = "mm_dl0",
>                         .playback = {
>                                     .stream_name = "MM_DL0",
>                                     .channels_min = 1,
>                                     .channels_max = 8,
>                                     .rates = SNDRV_PCM_RATE_48000,
>                                     .formats = SNDRV_PCM_FMTBIT_S16_LE
>                         },
>                         .probe = sti_frontend_dai_probe,
>                         .probe_order = SND_SOC_COMP_ORDER_FIRST,
>             },
> }
> Platform is declared using platform_of_node using DTS.
> I have also declared a BE and the route that links the FE cpu dai widget with
> the BE codec dai widget.
> 
> My concern is that MM_DL0 widget is created 2 times. One time in soc_probe_link_dais
> and one time in soc_probe_platform.

This bug has been fixed in later kernel. Can you cherry pick commit
ae10e7e8f1c9d021c8daca750d743cc3baa12e6d from 3.12.

Thanks

Liam
