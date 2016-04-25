From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: Applied "ASoC: Make aux_dev more like a generic
 component" to the asoc tree
Date: Mon, 25 Apr 2016 16:43:46 +0200
Message-ID: <CAFqH_51=L=gPzrny=+aLjJYqF7XQwmzRmwPX+hyJG8ofuXuwAQ@mail.gmail.com>
References: <1452058171-32688-1-git-send-email-mengdong.lin@linux.intel.com>
 <E1aIFSG-0001HZ-VD@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5881264F8D
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 16:43:47 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id d62so12324218iof.1
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 07:43:47 -0700 (PDT)
In-Reply-To: <E1aIFSG-0001HZ-VD@debutante>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

2016-01-10 13:50 GMT+01:00 Mark Brown <broonie@kernel.org>:
> The patch
>
>    ASoC: Make aux_dev more like a generic component
>
> has been applied to the asoc tree at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From f2ed6b07645ed29c1e090ead2e41066385cba3ea Mon Sep 17 00:00:00 2001
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> Date: Wed, 6 Jan 2016 13:29:31 +0800
> Subject: [PATCH] ASoC: Make aux_dev more like a generic component
>
> aux_dev is mainly used by the machine driver to specify analog devices,
> which are registered as codecs. Making it more like a generic component
> can help the machine driver to use it to specify any component with
> topology info by name.
>
> Details:
> - Remove the stub 'rtd_aux' array from the soc card.
> - Add a list 'aux_comp_list' to store the components of aux_devs.
>   And add a list head 'list_aux' to struct snd_soc_component, for adding
>   such components to the above list.
> - Add a 'init' ops to a component for machine specific init.
>   soc_bind_aux_dev() will set it to be aux_dev's init. And it will be
>   called when probing the component.
> - soc_bind_aux_dev() will also search components by name of an aux_dev,
>   since it may not be a codec.
> - Move probing of aux_devs before checking new DAI links brought by
>   topology.
> - Move removal of aux_devs later than removal of links. Because topology
>   of aux components may register DAIs and the DAI drivers will go with
>   removal of the aux components, we want soc_remove_link_dais() to remove
>   the DAIs at first.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/sound/soc.h  |   8 ++-
>  sound/soc/soc-core.c | 146 +++++++++++++++++++++++++++------------------------
>  2 files changed, 83 insertions(+), 71 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 9d1383e8d039..5bc5def6af02 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -787,6 +787,7 @@ struct snd_soc_component {
>         unsigned int registered_as_component:1;
>
>         struct list_head list;
> +       struct list_head list_aux; /* for auxiliary component of the card */
>
>         struct snd_soc_dai_driver *dai_drv;
>         int num_dai;
> @@ -830,6 +831,9 @@ struct snd_soc_component {
>         int (*probe)(struct snd_soc_component *);
>         void (*remove)(struct snd_soc_component *);
>
> +       /* machine specific init */
> +       int (*init)(struct snd_soc_component *component);
> +
>  #ifdef CONFIG_DEBUG_FS
>         void (*init_debugfs)(struct snd_soc_component *component);
>         const char *debugfs_prefix;
> @@ -1130,8 +1134,7 @@ struct snd_soc_card {
>          */
>         struct snd_soc_aux_dev *aux_dev;
>         int num_aux_devs;
> -       struct snd_soc_pcm_runtime *rtd_aux;
> -       int num_aux_rtd;
> +       struct list_head aux_comp_list;
>
>         const struct snd_kcontrol_new *controls;
>         int num_controls;
> @@ -1537,6 +1540,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
>         INIT_LIST_HEAD(&card->widgets);
>         INIT_LIST_HEAD(&card->paths);
>         INIT_LIST_HEAD(&card->dapm_list);
> +       INIT_LIST_HEAD(&card->aux_comp_list);
>  }
>
>  static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c572673a5a24..c10bd668659c 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1413,6 +1413,16 @@ static int soc_probe_component(struct snd_soc_card *card,
>                         component->name);
>         }
>
> +       /* machine specific init */
> +       if (component->init) {
> +               ret = component->init(component);
> +               if (ret < 0) {
> +                       dev_err(component->dev,
> +                               "Failed to do machine specific init %d\n", ret);
> +                       goto err_probe;
> +               }
> +       }
> +
>         if (component->controls)
>                 snd_soc_add_component_controls(component, component->controls,
>                                      component->num_controls);
> @@ -1657,65 +1667,81 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>
>  static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
>  {
> -       struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
>         struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
> -       const char *name = aux_dev->codec_name;
> -
> -       rtd->component = soc_find_component(aux_dev->codec_of_node, name);
> -       if (!rtd->component) {
> -               if (aux_dev->codec_of_node)
> -                       name = of_node_full_name(aux_dev->codec_of_node);
> -
> -               dev_err(card->dev, "ASoC: %s not registered\n", name);
> -               return -EPROBE_DEFER;
> +       struct snd_soc_component *component;
> +       const char *name;
> +       struct device_node *codec_of_node;
> +
> +       if (aux_dev->codec_of_node || aux_dev->codec_name) {
> +               /* codecs, usually analog devices */
> +               name = aux_dev->codec_name;
> +               codec_of_node = aux_dev->codec_of_node;
> +               component = soc_find_component(codec_of_node, name);
> +               if (!component) {
> +                       if (codec_of_node)
> +                               name = of_node_full_name(codec_of_node);
> +                       goto err_defer;
> +               }
> +       } else if (aux_dev->name) {
> +               /* generic components */
> +               name = aux_dev->name;
> +               component = soc_find_component(NULL, name);
> +               if (!component)
> +                       goto err_defer;
> +       } else {
> +               dev_err(card->dev, "ASoC: Invalid auxiliary device\n");
> +               return -EINVAL;
>         }
>
> -       /*
> -        * Some places still reference rtd->codec, so we have to keep that
> -        * initialized if the component is a CODEC. Once all those references
> -        * have been removed, this code can be removed as well.
> -        */
> -        rtd->codec = rtd->component->codec;
> -
> +       component->init = aux_dev->init;
> +       list_add(&component->list_aux, &card->aux_comp_list);
>         return 0;
> +
> +err_defer:
> +       dev_err(card->dev, "ASoC: %s not registered\n", name);
> +       return -EPROBE_DEFER;
>  }
>
> -static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
> +static int soc_probe_aux_devices(struct snd_soc_card *card)
>  {
> -       struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
> -       struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
> +       struct snd_soc_component *comp;
> +       int order;
>         int ret;
>
> -       ret = soc_probe_component(card, rtd->component);
> -       if (ret < 0)
> -               return ret;
> -
> -       /* do machine specific initialization */
> -       if (aux_dev->init) {
> -               ret = aux_dev->init(rtd->component);
> -               if (ret < 0) {
> -                       dev_err(card->dev, "ASoC: failed to init %s: %d\n",
> -                               aux_dev->name, ret);
> -                       return ret;
> +       for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
> +               order++) {
> +               list_for_each_entry(comp, &card->aux_comp_list, list_aux) {
> +                       if (comp->driver->probe_order == order) {
> +                               ret = soc_probe_component(card, comp);
> +                               if (ret < 0) {
> +                                       dev_err(card->dev,
> +                                               "ASoC: failed to probe aux component %s %d\n",
> +                                               comp->name, ret);
> +                                       return ret;
> +                               }
> +                       }
>                 }
>         }
>
> -       return soc_post_component_init(rtd, aux_dev->name);
> +       return 0;
>  }
>
> -static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
> +static void soc_remove_aux_devices(struct snd_soc_card *card)
>  {
> -       struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
> -       struct snd_soc_component *component = rtd->component;
> +       struct snd_soc_component *comp, *_comp;
> +       int order;
>
> -       /* unregister the rtd device */
> -       if (rtd->dev_registered) {
> -               device_unregister(rtd->dev);
> -               rtd->dev_registered = 0;
> +       for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
> +               order++) {
> +               list_for_each_entry_safe(comp, _comp,
> +                       &card->aux_comp_list, list_aux) {
> +                       if (comp->driver->remove_order == order) {
> +                               soc_remove_component(comp);
> +                               /* remove it from the card's aux_comp_list */
> +                               list_del(&comp->list_aux);
> +                       }
> +               }
>         }
> -
> -       if (component)
> -               soc_remove_component(component);
>  }
>
>  static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
> @@ -1894,6 +1920,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>                 }
>         }
>
> +       /* probe auxiliary components */
> +       ret = soc_probe_aux_devices(card);
> +       if (ret < 0)
> +               goto probe_dai_err;
> +
>         /* Find new DAI links added during probing components and bind them.
>          * Components with topology may bring new DAIs and DAI links.
>          */
> @@ -1923,16 +1954,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>                 }
>         }
>
> -       for (i = 0; i < card->num_aux_devs; i++) {
> -               ret = soc_probe_aux_dev(card, i);
> -               if (ret < 0) {
> -                       dev_err(card->dev,
> -                               "ASoC: failed to add auxiliary devices %d\n",
> -                               ret);
> -                       goto probe_aux_dev_err;
> -               }
> -       }
> -
>         snd_soc_dapm_link_dai_widgets(card);
>         snd_soc_dapm_connect_dai_link_widgets(card);
>
> @@ -1992,8 +2013,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>         return 0;
>
>  probe_aux_dev_err:
> -       for (i = 0; i < card->num_aux_devs; i++)
> -               soc_remove_aux_dev(card, i);
> +       soc_remove_aux_devices(card);
>
>  probe_dai_err:
>         soc_remove_dai_links(card);
> @@ -2039,20 +2059,18 @@ static int soc_probe(struct platform_device *pdev)
>  static int soc_cleanup_card_resources(struct snd_soc_card *card)
>  {
>         struct snd_soc_pcm_runtime *rtd;
> -       int i;
>
>         /* make sure any delayed work runs */
>         list_for_each_entry(rtd, &card->rtd_list, list)
>                 flush_delayed_work(&rtd->delayed_work);
>
> -       /* remove auxiliary devices */
> -       for (i = 0; i < card->num_aux_devs; i++)
> -               soc_remove_aux_dev(card, i);
> -
>         /* remove and free each DAI */
>         soc_remove_dai_links(card);
>         soc_remove_pcm_runtimes(card);
>
> +       /* remove auxiliary devices */
> +       soc_remove_aux_devices(card);
> +
>         soc_cleanup_card_debugfs(card);
>
>         /* remove the card */
> @@ -2608,16 +2626,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
>         INIT_LIST_HEAD(&card->rtd_list);
>         card->num_rtd = 0;
>
> -       card->rtd_aux = devm_kzalloc(card->dev,
> -                                sizeof(struct snd_soc_pcm_runtime) *
> -                                card->num_aux_devs,
> -                                GFP_KERNEL);
> -       if (card->rtd_aux == NULL)
> -               return -ENOMEM;
> -
> -       for (i = 0; i < card->num_aux_devs; i++)
> -               card->rtd_aux[i].card = card;
> -
>         INIT_LIST_HEAD(&card->dapm_dirty);
>         INIT_LIST_HEAD(&card->dobj_list);
>         card->instantiated = 0;
> --
> 2.7.0.rc3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

I just found that this change produces a kernel NULL pointer
dereference [1]. Reverting the patch avoids the kernel oops. From a
quick look seems that moving the probing of aux_devs before checking
new DAI links is what causes the problem. I'm not really familiar with
the API so before send a patch I prefer share my thoughts.

The sound/soc/rockchip/rockchip_max98090.c registers a headset chip as
a snd_soc_aux_dev, and the problem is that the init function calls
ts3a227e_enable_jack_detect and snd_jack_set_key before
snd_soc_card_jack_new is called. I think similar problem can happen
with this driver: sound/soc/intel/boards/cht_bsw_max98090_ti.c

Makes sense what I'm saying for you? And is the proper fix delay the
call of ts3a227e_enable_jack_detect to be later?

[1] dmesg.log

[  132.091648] max98090 2-0010: MAX98090 REVID=0x43
[  132.094658] max98090 2-0010: use default 2.8v micbias
[  132.103997] Unable to handle kernel NULL pointer dereference at
virtual address 00000014
[  132.104396] pgd = eba34000
[  132.104552] [00000014] *pgd=00000000
[  132.104780] Internal error: Oops: 5 [#1] SMP ARM
[  132.105005] Modules linked in: snd_soc_rockchip_max98090(+)
snd_soc_ts3a227e smsc95xx mwifiex_sdio mwifiex btmrv
l_sdio btmrvl bluetooth rk_crypto sha256_generic nvmem_rockchip_efuse
snd_soc_max98090 snd_soc_rockchip_i2s nvmem_c
ore sha1_generic joydev rockchip_thermal [last unloaded: snd_soc_ts3a227e]
[  132.106579] CPU: 0 PID: 708 Comm: insmod Tainted: G        W
4.6.0-rc5+ #1
[  132.106920] Hardware name: Rockchip (Device Tree)
[  132.107147] task: ec1c8d80 ti: ec3e8000 task.ti: ec3e8000
[  132.107411] PC is at snd_jack_set_key+0x14/0x78
[  132.107643] LR is at ts3a227e_enable_jack_detect+0x38/0x8c [snd_soc_ts3a227e]
[  132.107979] pc : [<c06a3c10>]    lr : [<bf166150>]    psr: 60010013
sp : ec3e9bb0  ip : ec3e9bd0  fp : ec3e9bcc
[  132.108494] r10: 00000000  r9 : ec56a038  r8 : ec56a0a0
[  132.108742] r7 : ec569ff0  r6 : bf16bb30  r5 : eb8a7c58  r4 : bf16c080
[  132.109051] r3 : 00000000  r2 : 000000e2  r1 : 00004000  r0 : 00000000
[  132.109357] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  132.109688] Control: 10c5387d  Table: 2ba3406a  DAC: 00000051
[  132.109958] Process insmod (pid: 708, stack limit = 0xec3e8218)
[  132.110236] Stack: (0xec3e9bb0 to 0xec3ea000)
[  132.110450] 9ba0:                                     bf16c080
eb8a7c58 bf16bb30 ec569ff0
[  132.110832] 9bc0: ec3e9be4 ec3e9bd0 bf166150 c06a3c08 ec56a000
00000000 ec3e9bf4 ec3e9be8

...

[  132.290280] 9fe0: bee024f0 bee024e0 7f6546c3 b6f57b42 80010030
00000003 00000000 00000000
[  132.299958] [<c06a3c10>] (snd_jack_set_key) from [<bf166150>]
(ts3a227e_enable_jack_detect+0x38/0x8c [snd_soc_ts
3a227e])
[  132.309961] [<bf166150>] (ts3a227e_enable_jack_detect
[snd_soc_ts3a227e]) from [<bf16b124>] (rk_98090_headset_in
it+0x1c/0x24 [snd_soc_rockchip_max98090])
[  132.330170] [<bf16b124>] (rk_98090_headset_init
[snd_soc_rockchip_max98090]) from [<c06b771c>] (soc_probe_compon
ent+0x22c/0x334)
[  132.351063] [<c06b771c>] (soc_probe_component) from [<c06ba6a0>]
(snd_soc_register_card+0x560/0xd14)
[  132.362015] [<c06ba6a0>] (snd_soc_register_card) from [<c06c7e60>]
(devm_snd_soc_register_card+0x50/0x8c)
[  132.373129] [<c06c7e60>] (devm_snd_soc_register_card) from
[<bf16b0c0>] (snd_rk_mc_probe+0xc0/0x108 [snd_soc_roc
kchip_max98090])
[  132.395594] [<bf16b0c0>] (snd_rk_mc_probe
[snd_soc_rockchip_max98090]) from [<c04af5bc>] (platform_drv_probe+0x6
0/0xb0)
[  132.407335] [<c04af5bc>] (platform_drv_probe) from [<c04ad03c>]
(driver_probe_device+0x1dc/0x41c)
[  132.419192] [<c04ad03c>] (driver_probe_device) from [<c04ad364>]
(__driver_attach+0xe8/0x11c)
[  132.431112] [<c04ad364>] (__driver_attach) from [<c04aaf24>]
(bus_for_each_dev+0x7c/0xa0)
[  132.443033] [<c04aaf24>] (bus_for_each_dev) from [<c04ac900>]
(driver_attach+0x28/0x30)
[  132.454945] [<c04ac900>] (driver_attach) from [<c04ac340>]
(bus_add_driver+0x128/0x254)
[  132.466853] [<c04ac340>] (bus_add_driver) from [<c04ae3a4>]
(driver_register+0xac/0xf0)
[  132.478765] [<c04ae3a4>] (driver_register) from [<c04af4fc>]
(__platform_driver_register+0x40/0x54)
[  132.490793] [<c04af4fc>] (__platform_driver_register) from
[<bf16e018>] (snd_rk_mc_driver_init+0x18/0x24 [snd_so
c_rockchip_max98090])
[  132.515020] [<bf16e018>] (snd_rk_mc_driver_init
[snd_soc_rockchip_max98090]) from [<c0101de8>] (do_one_initcall+
0x128/0x1e4)
[  132.527685] [<c0101de8>] (do_one_initcall) from [<c02172f4>]
(do_init_module+0x6c/0x3ac)
[  132.540430] [<c02172f4>] (do_init_module) from [<c01bb1b4>]
(load_module+0x1a40/0x1f64)
[  132.553282] [<c01bb1b4>] (load_module) from [<c01bb93c>]
(SyS_finit_module+0xc4/0xd4)
[  132.566158] [<c01bb93c>] (SyS_finit_module) from [<c0108540>]
(ret_fast_syscall+0x0/0x1c)
[  132.579069] Code: e92dd8f0 e24cb004 e52de004 e8bd4000 (e5903014)
[  132.592242] ---[ end trace ca16e398efcae7d0 ]---
