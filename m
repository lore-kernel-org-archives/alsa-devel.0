From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 2/4] ALSA pcm: allow non constant
 snd_pcm_chmap_elem
Date: Mon, 19 Dec 2016 18:16:53 +0100
Message-ID: <129e7c71-ce90-bad1-2c77-59a27b20fb34@st.com>
References: <201612200020.DdCKTN8h%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B8BE1266CF5
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 18:17:03 +0100 (CET)
In-Reply-To: <201612200020.DdCKTN8h%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


I had a doubt...this confirms that my arm compiler is too permissive :(
This patch in pcm_lib has to be abandoned.
I will propose a V4 with one/some constant table(s) defined in hdmi-codec...

Regards
Arnaud


On 12/19/2016 05:31 PM, kbuild test robot wrote:
> Hi Arnaud,
> 
> [auto build test WARNING on asoc/for-next]
> [also build test WARNING on v4.9 next-20161219]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Generic-HDMI-codec-Add-channel-mapping-control/20161219-235923
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: x86_64-acpi-redef (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    sound/pci/atiixp.c: In function 'snd_atiixp_pcm_new':
>>> sound/pci/atiixp.c:1298:10: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>              snd_pcm_alt_chmaps, chip->max_channels, 0,
>              ^~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/atiixp.c:31:0:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
> --
>    sound/pci/cmipci.c: In function 'snd_cmipci_pcm_spdif_new':
>>> sound/pci/cmipci.c:1966:10: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>              snd_pcm_alt_chmaps, cm->max_channels, 0,
>              ^~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/cmipci.c:35:0:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
> --
>    sound/pci/ens1370.c: In function 'snd_ensoniq_pcm':
>>> sound/pci/ens1370.c:1297:10: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>              surround_map, 2, 0, NULL);
>              ^~~~~~~~~~~~
>    In file included from sound/pci/ens1370.c:41:0:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
>    sound/pci/ens1370.c: In function 'snd_ensoniq_pcm2':
>    sound/pci/ens1370.c:1329:10: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>              snd_pcm_std_chmaps, 2, 0, NULL);
>              ^~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/ens1370.c:41:0:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from sound/pci/au88x0/au8810.c:9:0:
>    sound/pci/au88x0/au88x0_pcm.c: In function 'snd_vortex_new_pcm':
>>> sound/pci/au88x0/au88x0_pcm.c:659:11: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>               snd_pcm_std_chmaps,
>               ^~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/au88x0/au88x0.h:23:0,
>                     from sound/pci/au88x0/au8810.c:2:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/au88x0/au8810.c:9:0:
>    sound/pci/au88x0/au88x0_pcm.c:665:11: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>               snd_pcm_std_chmaps, 2, 0, NULL);
>               ^~~~~~~~~~~~~~~~~~
>    In file included from sound/pci/au88x0/au88x0.h:23:0,
>                     from sound/pci/au88x0/au8810.c:2:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
> --
>    sound/pci/ca0106/ca0106_main.c: In function 'snd_ca0106_pcm':
>>> sound/pci/ca0106/ca0106_main.c:1424:63: warning: passing argument 3 of 'snd_pcm_add_chmap_ctls' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK, map, 2,
>                                                                   ^~~
>    In file included from sound/pci/ca0106/ca0106_main.c:147:0:
>    include/sound/pcm.h:1389:5: note: expected 'struct snd_pcm_chmap_elem *' but argument is of type 'const struct snd_pcm_chmap_elem *'
>     int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
>         ^~~~~~~~~~~~~~~~~~~~~~
> 
> vim +1298 sound/pci/atiixp.c
> 
> ^1da177e Linus Torvalds 2005-04-16  1282  	/* PCM #0: analog I/O */
> 74ee4ff1 Takashi Iwai   2005-11-17  1283  	err = snd_pcm_new(chip->card, "ATI IXP AC97",
> 74ee4ff1 Takashi Iwai   2005-11-17  1284  			  ATI_PCMDEV_ANALOG, 1, 1, &pcm);
> ^1da177e Linus Torvalds 2005-04-16  1285  	if (err < 0)
> ^1da177e Linus Torvalds 2005-04-16  1286  		return err;
> ^1da177e Linus Torvalds 2005-04-16  1287  	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_atiixp_playback_ops);
> ^1da177e Linus Torvalds 2005-04-16  1288  	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_atiixp_capture_ops);
> ^1da177e Linus Torvalds 2005-04-16  1289  	pcm->private_data = chip;
> ^1da177e Linus Torvalds 2005-04-16  1290  	strcpy(pcm->name, "ATI IXP AC97");
> ^1da177e Linus Torvalds 2005-04-16  1291  	chip->pcmdevs[ATI_PCMDEV_ANALOG] = pcm;
> ^1da177e Linus Torvalds 2005-04-16  1292  
> ^1da177e Linus Torvalds 2005-04-16  1293  	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> 74ee4ff1 Takashi Iwai   2005-11-17  1294  					      snd_dma_pci_data(chip->pci),
> 74ee4ff1 Takashi Iwai   2005-11-17  1295  					      64*1024, 128*1024);
> ^1da177e Linus Torvalds 2005-04-16  1296  
> e36e3b86 Takashi Iwai   2012-08-03  1297  	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
> e36e3b86 Takashi Iwai   2012-08-03 @1298  				     snd_pcm_alt_chmaps, chip->max_channels, 0,
> e36e3b86 Takashi Iwai   2012-08-03  1299  				     &chmap);
> e36e3b86 Takashi Iwai   2012-08-03  1300  	if (err < 0)
> e36e3b86 Takashi Iwai   2012-08-03  1301  		return err;
> e36e3b86 Takashi Iwai   2012-08-03  1302  	chmap->channel_mask = SND_PCM_CHMAP_MASK_2468;
> e36e3b86 Takashi Iwai   2012-08-03  1303  	chip->ac97[0]->chmaps[SNDRV_PCM_STREAM_PLAYBACK] = chmap;
> e36e3b86 Takashi Iwai   2012-08-03  1304  
> ^1da177e Linus Torvalds 2005-04-16  1305  	/* no SPDIF support on codec? */
> ^1da177e Linus Torvalds 2005-04-16  1306  	if (chip->pcms[ATI_PCM_SPDIF] && ! chip->pcms[ATI_PCM_SPDIF]->rates)
> 
> :::::: The code at line 1298 was first introduced by commit
> :::::: e36e3b86c78cee9c7435eb33e0ef8a788193e812 ALSA: Implement channel maps for standard onboard AC97 drivers
> 
> :::::: TO: Takashi Iwai <tiwai@suse.de>
> :::::: CC: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
