From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 Pandora
Date: Fri, 5 Dec 2008 11:15:04 +0200
Message-ID: <6ed0b2680812050115v635095f8p336a6825654a205f@mail.gmail.com>
References: <1228423194-19567-1-git-send-email-notasas@gmail.com>
	<bd7b27490812042348t6593afa8saafb3a42bd346ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id B47761037ED
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 10:15:05 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so4167312rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 01:15:04 -0800 (PST)
In-Reply-To: <bd7b27490812042348t6593afa8saafb3a42bd346ad7@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 5, 2008 at 9:48 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> 2008/12/4 Grazvydas Ignotas <notasas@gmail.com>
>>
>> +       /* Set McBSP clock to external */
>> +       ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
>> 0,
>> +                                           SND_SOC_CLOCK_IN);
>
> I'm glad to see external clocking using with McBSP. Never tested feature :-)

Yup, and in works fine. Thanks for adding support for that!.

>
>> +/* Digital audio interface glue - connects codec <--> CPU */
>> +static struct snd_soc_dai_link omap3pandora_dai[] = {
>> +       {
>> +               .name = "PCM1773",
>> +               .stream_name = "HiFi Out",
>> +               .cpu_dai = &omap_mcbsp_dai[0],
>> +               .codec_dai = &twl4030_dai,
>> +               .ops = &omap3pandora_out_ops,
>> +               .init = omap3pandora_out_init,
>> +       }, {
>> +               .name = "TWL4030",
>> +               .stream_name = "Line/Mic In",
>> +               .cpu_dai = &omap_mcbsp_dai[1],
>> +               .codec_dai = &twl4030_dai,
>> +               .ops = &omap3pandora_in_ops,
>> +               .init = omap3pandora_in_init,
>> +       }
>> +};
>
> Nice, first OMAP machine driver using McBSP in multilink configuration.

We also have bluetooth path, but I've left that for another time.

>> +       if (!machine_is_omap3_pandora()) {
>> +               pr_debug(PREFIX "Not OMAP3 Pandora\n");
>> +               return -ENODEV;
>> +       }
>> +       pr_info("OMAP3 Pandora SoC init\n");
>> +
>
> Minor muttering, but I don't see very much use for these debug prints.

Well, every other OMAP3 board file has this. Do I need to resend?
