From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 6/6] ASoC: soc-core: use
 for_each_link_codecs() for dai_link codecs
Date: Tue, 22 Jan 2019 16:43:08 +0100
Message-ID: <6e72e1ea-8879-7cab-f2d8-18da7a0a883c@samsung.com>
References: <87imyiamj4.wl-kuninori.morimoto.gx@renesas.com>
 <CGME20190121003405epcas1p3f72eb59673abe94235326cbb24251b3d@epcas1p3.samsung.com>
 <87a7juamhi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id F02C92674A8
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 16:43:15 +0100 (CET)
In-reply-to: <87a7juamhi.wl-kuninori.morimoto.gx@renesas.com>
Content-language: en-GB
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On 1/21/19 01:32, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We can use for_each_link_codecs() without waiting
> for_each_rtd_codec_dai() on soc_bind_dai_link().
> Let's use for_each macro
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 8a58fa8..1c92b4a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -870,7 +870,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>  	struct snd_soc_dai_link *dai_link)
>  {
>  	struct snd_soc_pcm_runtime *rtd;
> -	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
> +	struct snd_soc_dai_link_component *codecs;
>  	struct snd_soc_dai_link_component cpu_dai_component;
>  	struct snd_soc_component *component;
>  	struct snd_soc_dai **codec_dais;
> @@ -905,9 +905,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>  	rtd->num_codecs = dai_link->num_codecs;
>  
>  	/* Find CODEC from registered CODECs */
> -	/* we can use for_each_rtd_codec_dai() after this */
>  	codec_dais = rtd->codec_dais;
> -	for (i = 0; i < rtd->num_codecs; i++) {
> +	for_each_link_codecs(dai_link, i, codecs) {
>  		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
>  		if (!codec_dais[i]) {
>  			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
 
It seems this patch causes card registration failure in multicodec 
configuration. When I revert the patch there is no error as below 
on Odroid boards:

-------------------8<----------------------------
[    3.059519] odroid-audio sound: multicodec <-> samsung-i2s mapping ok
[    3.060819] ------------[ cut here ]------------
[    3.065113] WARNING: CPU: 2 PID: 92 at sound/core/pcm_lib.c:2446 snd_pcm_add_chmap_ctls+0x158/0x180
[    3.074019] Modules linked in:
[    3.083838] CPU: 2 PID: 92 Comm: kworker/2:1 Not tainted 5.0.0-rc3-next-20190122-00002-gfce9abe78abf #162
[    3.093334] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.099424] Workqueue: events deferred_probe_work_func
[    3.104557] [<c0111ad4>] (unwind_backtrace) from [<c010d974>] (show_stack+0x10/0x14)
[    3.112275] [<c010d974>] (show_stack) from [<c09f51c4>] (dump_stack+0x90/0xc8)
[    3.119472] [<c09f51c4>] (dump_stack) from [<c0125a1c>] (__warn+0xf8/0x124)
[    3.126412] [<c0125a1c>] (__warn) from [<c0125a88>] (warn_slowpath_null+0x40/0x48)
[    3.133960] [<c0125a88>] (warn_slowpath_null) from [<c0741e1c>] (snd_pcm_add_chmap_ctls+0x158/0x180)
[    3.143083] [<c0741e1c>] (snd_pcm_add_chmap_ctls) from [<c0760ed8>] (hdmi_codec_pcm_new+0xb4/0x150)
[    3.152113] [<c0760ed8>] (hdmi_codec_pcm_new) from [<c07480d8>] (soc_link_dai_pcm_new+0x4c/0x84)
[    3.160873] [<c07480d8>] (soc_link_dai_pcm_new) from [<c074c0d0>] (snd_soc_instantiate_card+0xbbc/0xc78)
[    3.170329] [<c074c0d0>] (snd_soc_instantiate_card) from [<c074c2f0>] (snd_soc_register_card+0x164/0x19c)
[    3.179886] [<c074c2f0>] (snd_soc_register_card) from [<c075b1a8>] (devm_snd_soc_register_card+0x34/0x70)
[    3.189430] [<c075b1a8>] (devm_snd_soc_register_card) from [<c076e128>] (odroid_audio_probe+0x170/0x200)
[    3.198888] [<c076e128>] (odroid_audio_probe) from [<c05517c4>] (platform_drv_probe+0x48/0x98)
[    3.207481] [<c05517c4>] (platform_drv_probe) from [<c054f348>] (really_probe+0x224/0x3f4)
[    3.215724] [<c054f348>] (really_probe) from [<c054f76c>] (driver_probe_device+0x70/0x1c4)
[    3.223984] [<c054f76c>] (driver_probe_device) from [<c054d51c>] (bus_for_each_drv+0x44/0x8c)
[    3.232477] [<c054d51c>] (bus_for_each_drv) from [<c054f604>] (__device_attach+0xa0/0x138)
[    3.240722] [<c054f604>] (__device_attach) from [<c054e47c>] (bus_probe_device+0x88/0x90)
[    3.248882] [<c054e47c>] (bus_probe_device) from [<c054e9f4>] (deferred_probe_work_func+0x6c/0xbc)
[    3.257830] [<c054e9f4>] (deferred_probe_work_func) from [<c0144254>] (process_one_work+0x200/0x738)
[    3.266938] [<c0144254>] (process_one_work) from [<c01447f0>] (worker_thread+0x2c/0x4c8)
[    3.275014] [<c01447f0>] (worker_thread) from [<c014af94>] (kthread+0x128/0x164)
[    3.275025] [<c014af94>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
[    3.290546] Exception stack(0xee2a9fb0 to 0xee2a9ff8)
[    3.304866] 9fa0:                                     00000000 00000000 00000000 00000000
[    3.304873] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.304879] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    3.304973] irq event stamp: 10295
[    3.313685] hardirqs last  enabled at (10313): [<c0101a8c>] __irq_svc+0x8c/0xb0
[    3.351230] hardirqs last disabled at (10360): [<c018bb30>] console_unlock+0xc0/0x700
[    3.359077] softirqs last  enabled at (10376): [<c0102564>] __do_softirq+0x3a4/0x66c
[    3.366806] softirqs last disabled at (10387): [<c012d7c4>] irq_exit+0x140/0x168
[    3.374169] ---[ end trace 61e0cb0fbe08773c ]---
[    3.378743] hdmi-audio-codec hdmi-audio-codec.0.auto: ASoC: Failed to bind i2s-hifi with pcm device
[    3.387801] odroid-audio sound: ASoC: failed to instantiate card -16
[    3.396693] odroid-audio sound: snd_soc_register_card() failed: -16
[    3.400432] odroid-audio: probe of sound failed with error -16

[    3.537534] ALSA device list:
[    3.538439]   No soundcards found.
-------------------8<----------------------------

-- 
Regards,
Sylwester
