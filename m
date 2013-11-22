From: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: ASOC: stream widget created two times
Date: Fri, 22 Nov 2013 15:19:20 +0100
Message-ID: <A4ED9057F6AB394EB1BF089A056089A853220EBBA8@SAFEX1MAIL5.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
 [207.126.144.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 88454264F1E
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:20:10 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "lrg@host86-182-165-201.range86-182.btcentralplus.com" <lrg@host86-182-165-201.range86-182.btcentralplus.com>, "broonie@cassiel.sirena.org.uk" <broonie@cassiel.sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hello,
I 'm newbie on asoc dev. I'm trying to develop a driver based on dynamic
PCM implementation with backend and frontend. I'm working on 3.10

I have declared a FE  :
{
            .name = "MMDL0",
            .stream_name = "MM DL0 Frontend",
            .cpu_dai_name = "mm_dl0",

            .codec_name = "snd-soc-dummy",
            .codec_dai_name = "snd-soc-dummy-dai",

            .dynamic=1,
            .trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
            .ignore_pmdown_time = 1, /* Power down without delay */
            .init = sti_dummy_init,
},

CPU DAI associated:
static struct snd_soc_dai_driver sti_frontend_cpu_dais[] = {
            {
                        .name = "mm_dl0",
                        .playback = {
                                    .stream_name = "MM_DL0",
                                    .channels_min = 1,
                                    .channels_max = 8,
                                    .rates = SNDRV_PCM_RATE_48000,
                                    .formats = SNDRV_PCM_FMTBIT_S16_LE
                        },
                        .probe = sti_frontend_dai_probe,
                        .probe_order = SND_SOC_COMP_ORDER_FIRST,
            },
}
Platform is declared using platform_of_node using DTS.
I have also declared a BE and the route that links the FE cpu dai widget with
the BE codec dai widget.

My concern is that MM_DL0 widget is created 2 times. One time in soc_probe_link_dais
and one time in soc_probe_platform.
After analysis it seems that this occurs because my cpu dai is registered in
platform device.
In this case the condition if (dai->dev != platform->dev)  in soc_probe_platform is false,
so dai widget is created a second time.

So I would like to know if  this is a normal behavior and I have to create a
specific device to register my cpu_dai?

Thanks in advance for your answers

BR

Arnaud
