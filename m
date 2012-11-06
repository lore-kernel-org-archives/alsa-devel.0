From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Tue, 6 Nov 2012 16:10:41 +0530
Message-ID: <5098E929.7040404@st.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
 [207.126.144.143])
 by alsa0.perex.cz (Postfix) with ESMTP id B8C6D2616CB
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 11:40:49 +0100 (CET)
In-Reply-To: <505BE5BB.5010008@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 9/21/2012 9:27 AM, Rajeev kumar wrote:
> Hello Mark,
>
> On 9/20/2012 5:19 PM, Mark Brown wrote:
>> On Thu, Sep 20, 2012 at 04:46:27PM +0530, Rajeev kumar wrote:
>>
>>> I have not provided the dapm support in codec. When the system goes
>>> in hibernation state it gets crashed. command for putting the system
>>> in hibernation:
>>
>> DAPM is mandatory now, though any device with an audio interface
>> connected should have some DAPM widgets added transparently so its not
>> always explicitly present in the CODEC driver. It's just causing too
>> much pain to special case non-DAPM devices and theres really not any
>> cases where there's no need for widgets.
>>
>

Once again I am raising this issue. Sorry for that.
First time I have implemented dapm support for my codec driver (sta529), 
but still crash is there. There is no any asynchronous events, so 
platform/Machine driver does not contains any dapm widgets.

Please find below the implementation for dapm.

static const struct snd_soc_dapm_widget sta529_dapm_widgets[] = {
         SND_SOC_DAPM_DAC("DAC", "Play", SND_SOC_NOPM , 0, 0),
         SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
         SND_SOC_DAPM_OUTPUT("HPL"),
         SND_SOC_DAPM_OUTPUT("HPR"),
         SND_SOC_DAPM_OUTPUT("SPKL"),
         SND_SOC_DAPM_OUTPUT("SPKR"),
         SND_SOC_DAPM_INPUT("MIC1"),
};

static const struct snd_soc_dapm_route sta529_audio_map[] = {
         {"DAC", NULL, "output"},
         {"ADC", NULL, "input"},
         {"HPL", NULL, "HP Left Out"},
         {"HPR", NULL, "HP Right Out"},
         {"SPKL", NULL, "SPK Left Out"},
         {"SPKR", NULL, "SPK Right Out"},
   };
struct snd_soc_codec_driver sta529_codec_driver = {
         .probe = sta529_probe,
         .remove = sta529_remove,
         .set_bias_level = sta529_set_bias_level,
         .suspend = sta529_suspend,
         .resume = sta529_resume,
         .controls = sta529_snd_controls,
         .num_controls = ARRAY_SIZE(sta529_snd_controls),
         .dapm_widgets = sta529_dapm_widgets,
         .num_dapm_widgets = ARRAY_SIZE(sta529_dapm_widgets),
         .dapm_routes = sta529_audio_map,
         .num_dapm_routes = ARRAY_SIZE(sta529_audio_map),
};


Could you please suggest me, is there any thing more I need to do to 
make it work or I am missing something.

For reference, please find crash log also.

snd_soc_dapm_shutdown+0x4c/0x11c) from [<803ce05c>] 
(snd_soc_poweroff+0x68/0x70)
[<803ce05c>] (snd_soc_poweroff+0x68/0x70) from [<80288b1c>] 
(platform_pm_poweroff+0x40/0x58)
[<80288b1c>] (platform_pm_poweroff+0x40/0x58) from [<8028d1a8>] 
(dpm_run_callback.isra.4+0x3c/0x74)
[<8028d1a8>] (dpm_run_callback.isra.4+0x3c/0x74) from [<8028dbcc>] 
(__device_suspend+0x180/0x228)
[<8028dbcc>] (__device_suspend+0x180/0x228) from [<8028e5d4>] 
(dpm_suspend+0xb4/0x220)
[<8028e5d4>] (dpm_suspend+0xb4/0x220) from [<8028e97c>] 
(dpm_suspend_start+0x6c/0x74)
[<8028e97c>] (dpm_suspend_start+0x6c/0x74) from [<8005b778>] 
(hibernation_platform_enter+0x48/0x128)
[<8005b778>] (hibernation_platform_enter+0x48/0x128) from [<8005b9ac>] 
(hibernate+0x154/0x21c)
[<8005b9ac>] (hibernate+0x154/0x21c) from [<80059b10>] 
(state_store+0xbc/0xd0)
[<80059b10>] (state_store+0xbc/0xd0) from [<801f093c>] 
(kobj_attr_store+0x1c/0x28)
[<801f093c>] (kobj_attr_store+0x1c/0x28) from [<80127bd0>] 
(sysfs_write_file+0x118/0x14c)
[<80127bd0>] (sysfs_write_file+0x118/0x14c) from [<800d2640>] 
(vfs_write+0xc4/0x140)
[<800d2640>] (vfs_write+0xc4/0x140) from [<800d28bc>] (sys_write+0x4c/0x78)
[<800d28bc>] (sys_write+0x4c/0x78) from [<8000de20>] 
(ret_fast_syscall+0x0/0x48)
Code: e59350f8 e3a03000 e2455014 ea00000f (e595201c)


Best Regards
Rajeev

> Best Regards
> Rajeev
>
>
>
>
