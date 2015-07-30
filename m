From: Micka <mickamusset@gmail.com>
Subject: Beaglebone black : Audio cap & Linux version
	4.1.3-ti-r6.2
Date: Thu, 30 Jul 2015 16:39:56 +0000
Message-ID: <CAF+MRtmPgAtUJ+th1e9sFj9zHN+917geRAf6WhmAG7M=rxYErg@mail.gmail.com>
References: <CAF+MRtnzqrFLjpFHKo7gH+YL+Y80ySbXyOT49wwD-=0i--8QvQ@mail.gmail.com>
 <CAOCHtYjHJ5p4=s-M42Nc6VFfTSjWf==VD8e_7_GafW36=7VeRA@mail.gmail.com>
 <CAF+MRtnsyC-JQP98hk2J+016TGf6cX=qVUuPGZPg_2gE_hPf1Q@mail.gmail.com>
 <CAF+MRtmNkda4twkBGmaBEj9-O2sDZk3vE6rD3x=FkoDQMFoUsw@mail.gmail.com>
 <CAOCHtYjk+BrJ1FdWKYLo4GgcQOYkggYWseKcYhvZ4k5LVUXttw@mail.gmail.com>
 <CAF+MRtkAn3H0=en02nEb8fcu9TQTmHJc6GPfmDoVAPOmHCH6jw@mail.gmail.com>
 <CAOCHtYgdbQRo7HogGtSBHGw+NJ5ZB5qAxq-Pbtv6-sAhEfRNAA@mail.gmail.com>
 <CAF+MRtnGLHYjSngd-c-9T+nrpG2n2O_adh9WeHQ=hgUFZu=CkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AAED260532
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 18:40:06 +0200 (CEST)
Received: by lahh5 with SMTP id h5so28557017lah.2
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 09:40:05 -0700 (PDT)
In-Reply-To: <CAF+MRtnGLHYjSngd-c-9T+nrpG2n2O_adh9WeHQ=hgUFZu=CkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI everyone, I'm trying to test the sound output with the
driver tlv320aic3104.

I'm stuck somewhere and I can't figure it out !

 I Put a lot of printk and I don't know where to put other printk.


Do you know who call the function soc_pcm_prepare ?

693 <http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L693>
*/**694 <http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L694>
* * Called by ALSA when the PCM substream is prepared, can set format,
sample*695 <http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L695>
* * rate, etc.  This function is non atomic and can be called multiple
times,*696 <http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L696>
* * it can refer to the runtime info.*697
<http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L697> *
*/*698 <http://lxr.free-electrons.com/source/sound/soc/soc-pcm.c#L698>
static int soc_pcm_prepare
<http://lxr.free-electrons.com/ident?i=soc_pcm_prepare>(struct
snd_pcm_substream
<http://lxr.free-electrons.com/ident?i=snd_pcm_substream> *substream)

Looks like that it's ALSA, but I can't find where ?

I tried to find a line in the kernel calling the function:
 rtd->ops <http://lxr.free-electrons.com/ident?i=ops>.prepare(.... )

can't find it ....


my trace :
[  550.269286] ASoC: tlv320aic3x-hifi <-> 48038000.mcasp info:
[  550.269363] ASoC: rate mask 0x7fe
[  550.269398] ASoC: min ch 2 max ch 2
[  550.269431] ASoC: min rate 8000 max rate 96000
[  550.275809] tlv aic3x_hw_params
[  550.275862] snd_soc_read: snd soc component read: ret 0 reg 9 val 64
[  550.275934] snd_soc_component_write reg 9 val 64
[  550.275987] snd_soc_component_write reg 101 val 0
[  550.276030] snd_soc_component_write reg 7 val 10
[  550.276063] snd_soc_component_write reg 2 val 0
[  550.289260] snd_soc_component_write reg 11 val 1
[  550.289339] snd_soc_component_write reg 4 val 32
[  550.289375] snd_soc_component_write reg 5 val 30
[  550.289407] snd_soc_component_write reg 6 val 0
[  550.289952] soc_pcm_prepare
[  550.290003] snd_soc_component_write reg 10 val 0
[  550.290043] soc_dapm_stream_event 1
[  550.290107] soc_dapm_stream_event: dapm_power_widgets:start
dapm_power_widgets 1
[  550.290150] trace_snd_soc_dapm_start
[  550.290176] dapm reset
[  550.290226] trace_snd_soc_dapm_widget_power
[  550.290257] trace_snd_soc_dapm_widget_power
[  550.290284] trace_snd_soc_dapm_widget_power
[  550.290311] trace_snd_soc_dapm_widget_power
[  550.290339] trace_snd_soc_dapm_widget_power
[  550.290370] trace_snd_soc_dapm_widget_power
[  550.290395] trace_snd_soc_dapm_widget_power
[  550.290423] trace_snd_soc_dapm_widget_power
[  550.290448] trace_snd_soc_dapm_widget_power
[  550.290477] trace_snd_soc_dapm_widget_power
[  550.290503] trace_snd_soc_dapm_widget_power
[  550.290531] trace_snd_soc_dapm_widget_power
[  550.290557] trace_snd_soc_dapm_widget_power
[  550.290582] trace_snd_soc_dapm_widget_power
[  550.290608] trace_snd_soc_dapm_widget_power
[  550.290634] trace_snd_soc_dapm_widget_power
[  550.290659] trace_snd_soc_dapm_widget_power
[  550.290686] trace_snd_soc_dapm_widget_power
[  550.290712] trace_snd_soc_dapm_widget_power
[  550.290738] trace_snd_soc_dapm_widget_power
[  550.290765] trace_snd_soc_dapm_widget_power
[  550.290791] trace_snd_soc_dapm_widget_power
[  550.290817] trace_snd_soc_dapm_widget_power
[  550.290842] trace_snd_soc_dapm_widget_power
[  550.290879] dap set bias to off
[  550.290910] dapm_pre_sequence_async off
[  550.290937] snd soc dapm set bias level 1
[  550.290962] trace_snd_soc_bias_level_start 1
[  550.290988] trace_snd_soc_bias_level_done 1
[  550.291011] dapm_pre_sequence_async onsnd soc dapm set bias level 2
[  550.291047] trace_snd_soc_bias_level_start 2
[  550.291073] trace_snd_soc_bias_level_done 2
[  550.291318] dapm_pre_sequence_async off
[  550.291354] snd soc dapm set bias level 1
[  550.291381] trace_snd_soc_bias_level_start 1
[  550.291405] soc set bias level
[  550.291432] tlv set bias level 1
[  550.291456] tlv standby
[  550.291480] tlv set power
[  550.300504] snd_soc_read: snd soc component read: ret 0 reg 5 val 30
[  550.300583] snd_soc_read: snd soc component read: ret 0 reg 6 val 0
[  550.300631] snd_soc_component_write reg 5 val 30
[  550.301103] snd_soc_component_write reg 6 val 0
[  550.301577] trace_snd_soc_bias_level_done 1
[  550.301611] dapm_pre_sequence_async onsnd soc dapm set bias level 2
[  550.301650] trace_snd_soc_bias_level_start 2
[  550.301675] soc set bias level
[  550.301701] tlv set bias level 2
[  550.301724] tlv prepare
[  550.301757] trace_snd_soc_bias_level_done 2
[  550.301864] dapm event WILL_PMU
[  550.301897] dapm event WILL_PMU
[  550.301923] dapm event WILL_PMU
[  550.301948] dapm event WILL_PMU
[  550.301972] dapm event WILL_PMU
[  550.301997] dapm event WILL_PMU
[  550.302021] dapm event WILL_PMU
[  550.302045] dapm event WILL_PMU
[  550.302069] dapm event WILL_PMU
[  550.302094] dapm event WILL_PMU
[  550.302119] dapm event WILL_PMU
[  550.302143] dapm event WILL_PMU
[  550.302168] dapm event WILL_PMU
[  550.302192] dapm event WILL_PMU
[  550.302216] dapm event WILL_PMU
[  550.302240] dapm event WILL_PMU
[  550.302265] dapm event WILL_PMU
[  550.302289] dapm event WILL_PMU
[  550.302313] dapm event WILL_PMU
[  550.302337] dapm event WILL_PMU
[  550.302362] dapm event WILL_PMU
[  550.302386] dapm event WILL_PMU
[  550.302410] dapm event WILL_PMU
[  550.302435] dapm event WILL_PMU
[  550.302460] dapm sq run 1
[  550.302489] dapm sq run 1
[  550.302523] dapm event PRE_PMU
[  550.302550] dapm event PRE_PMD
[  550.302575] dapm event PRE_PMU
[  550.302599] dapm event PRE_PMD
[  550.302623] dapm event PRE_PMU
[  550.302647] dapm event PRE_PMD
[  550.302671] dapm event PRE_PMU
[  550.302696] dapm event PRE_PMD
[  550.302720] dapm event PRE_PMU
[  550.302744] dapm event PRE_PMD
[  550.302769] dapm event PRE_PMU
[  550.302793] dapm event PRE_PMD
[  550.302817] dapm event POST_PMU
[  550.302842] dapm event POST_PMD
[  550.302867] dapm event POST_PMU
[  550.302891] dapm event POST_PMD
[  550.302915] dapm event POST_PMU
[  550.302939] dapm event POST_PMD
[  550.302964] dapm event POST_PMU
[  550.302988] dapm event POST_PMD
[  550.303012] dapm event POST_PMU
[  550.303036] dapm event POST_PMD
[  550.303060] dapm event POST_PMU
[  550.303084] dapm event POST_PMD
[  550.303110] dapm event PRE_PMU
[  550.303134] dapm event PRE_PMD
[  550.303159] dapm event POST_PMU
[  550.303183] dapm event POST_PMD
[  550.303209] dapm event PRE_PMU
[  550.303234] dapm event PRE_PMD
[  550.303258] dapm event PRE_PMU
[  550.303282] dapm event PRE_PMD
[  550.303306] dapm event PRE_PMU
[  550.303331] dapm event PRE_PMD
[  550.303355] dapm event PRE_PMU
[  550.303379] dapm event PRE_PMD
[  550.303403] dapm event POST_PMU
[  550.303427] dapm event POST_PMD
[  550.303451] dapm event POST_PMU
[  550.303475] dapm event POST_PMD
[  550.303499] dapm event POST_PMU
[  550.303524] dapm event POST_PMD
[  550.303548] dapm event POST_PMU
[  550.303572] dapm event POST_PMD
[  550.303598] dapm event PRE_PMU
[  550.303622] dapm event PRE_PMD
[  550.303647] dapm event PRE_PMU
[  550.303671] dapm event PRE_PMD
[  550.304162] dapm event POST_PMU
[  550.304199] dapm event POST_PMD
[  550.304226] dapm event POST_PMU
[  550.304250] dapm event POST_PMD
[  550.304278] dapm event PRE_PMU
[  550.304303] dapm event PRE_PMD
[  550.304328] dapm event PRE_PMU
[  550.304352] dapm event PRE_PMD
[  550.304377] dapm event PRE_PMU
[  550.304401] dapm event PRE_PMD
[  550.304426] dapm event PRE_PMU
[  550.304450] dapm event PRE_PMD
[  550.304474] dapm event POST_PMU
[  550.304499] dapm event POST_PMD
[  550.304523] dapm event POST_PMU
[  550.304547] dapm event POST_PMD
[  550.304572] dapm event POST_PMU
[  550.304596] dapm event POST_PMD
[  550.304620] dapm event POST_PMU
[  550.304644] dapm event POST_PMD
[  550.304670] dapm event PRE_PMU
[  550.304695] dapm event PRE_PMD
[  550.305156] dapm event POST_PMU
[  550.305191] dapm event POST_PMD
[  550.305219] dapm event PRE_PMU
[  550.305245] dapm event PRE_PMD
[  550.305696] dapm event POST_PMU
[  550.305730] dapm event POST_PMD
[  550.305757] dapm event PRE_PMU
[  550.305782] dapm event PRE_PMD
[  550.306275] dapm event POST_PMU
[  550.306312] dapm event POST_PMD
[  550.306341] dapm event PRE_PMU
[  550.306366] dapm event PRE_PMD
[  550.306849] dapm event POST_PMU
[  550.306885] dapm event POST_PMD
[  550.306914] dapm event PRE_PMU
[  550.306939] dapm event PRE_PMD
[  550.317926] dapm event POST_PMU
[  550.317958] dapm event POST_PMD
[  550.317977] dapm event PRE_PMU
[  550.317991] dapm event PRE_PMD
[  550.318401] dapm event POST_PMU
[  550.318422] dapm event POST_PMD
[  550.318439] dapm event PRE_PMU
[  550.318454] dapm event PRE_PMD
[  550.318467] dapm event POST_PMU
[  550.318480] dapm event POST_PMD
[  550.318496] dapm_power_widgets run all the bias changes in parrallel
[  550.321470] dapm_post_sequence_async prepare 1
[  550.321498] snd soc dapm set bias level 3
[  550.321513] trace_snd_soc_bias_level_start 3
[  550.321527] soc set bias level
[  550.321543] tlv set bias level 3
[  550.321555] tlv bias on
[  550.321570] trace_snd_soc_bias_level_done 3
[  550.321649] dapm_power_widgets dapm_power_widgets
[  550.321666] DAPM sequencing finished
[  550.321680] trace_snd_soc_dapm_done
[  550.321695] pcm prepare call snd_soc_dai_digital_mute
[  550.321711] snd_soc_dai_digital_mute 0 0
[  550.321725] tlv aic3x_mute
[  550.321739] snd_soc_read: snd soc component read: ret 0 reg 43 val 168
[  550.321772] snd_soc_read: snd soc component read: ret 0 reg 44 val 168
[  550.321798] snd_soc_component_write reg 43 val 40
[  550.322224] snd_soc_component_write reg 44 val 40
[  550.322630] pcm prepare call snd_soc_dai_digital_mute for cpu_dai
[  550.322651] snd_soc_dai_digital_mute 0 0

>
>
