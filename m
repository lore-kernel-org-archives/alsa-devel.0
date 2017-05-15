From: Naveen M <naveen.m@intel.com>
Subject: Re: [PATCH v2 1/6] ASoC: Intel: Convert all machine
	data to C99 style
Date: Mon, 15 May 2017 11:07:42 +0530
Message-ID: <29598.9106911749$1505300774@news.gmane.org>
References: <1494505944-31378-1-git-send-email-naveen.m@intel.com>
 <1494505944-31378-2-git-send-email-naveen.m@intel.com>
 <20170515052022.GA15061@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 276D4266D52
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 07:37:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170515052022.GA15061@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 15, 2017 at 10:50:23AM +0530, Vinod Koul wrote:
> On Thu, May 11, 2017 at 06:02:19PM +0530, Naveen M wrote:
> > C99 style struct initialization helps in readability as well as
> > initialization of variables not specified as NULL.
> > 
> > Signed-off-by: Naveen M <naveen.m@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> this needs:
> 
> Suggested-by: Takashi Iwai <tiwai@suse.de>
Will be added in V3. Thanks for pointing this out.
> 
> > ---
> >  sound/soc/intel/atom/sst/sst_acpi.c | 209 ++++++++++++++++++++++++++++--------
> >  sound/soc/intel/skylake/skl.c       |  60 +++++++++--
> 
> Series looks good to me, but I feel we should split these two to separate
> patches as they touch two different drivers.
> 
Sure, will be fixed with V3.
> >  2 files changed, 211 insertions(+), 58 deletions(-)
> > 
> > diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> > index dd250b8..193c4d7 100644
> > --- a/sound/soc/intel/atom/sst/sst_acpi.c
> > +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> > @@ -453,12 +453,20 @@ static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
> >  
> >  
> >  static struct sst_acpi_mach cht_surface_mach = {
> > -	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -								&chv_platform_data };
> > +	.id = "10EC5640",
> > +	.drv_name = "cht-bsw-rt5645",
> > +	.fw_filename = "intel/fw_sst_22a8.bin",
> > +	.board = "cht-bsw",
> > +	.pdata = &chv_platform_data,
> > +};
> >  
> >  static struct sst_acpi_mach byt_thinkpad_10 = {
> > -	"10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
> > -	                                                        &byt_rvp_platform_data };
> > +	.id = "10EC5640",
> > +	.drv_name = "cht-bsw-rt5672",
> > +	.fw_filename = "intel/fw_sst_0f28.bin",
> > +	.board = "cht-bsw",
> > +	.pdata = &byt_rvp_platform_data,
> > +};
> >  
> >  static struct sst_acpi_mach *cht_quirk(void *arg)
> >  {
> > @@ -486,68 +494,175 @@ static struct sst_acpi_mach *byt_quirk(void *arg)
> >  
> >  
> >  static struct sst_acpi_mach sst_acpi_bytcr[] = {
> > -	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", byt_quirk,
> > -						&byt_rvp_platform_data },
> > -	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
> > -						&byt_rvp_platform_data },
> > -	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
> > -						&byt_rvp_platform_data },
> > -	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
> > -						&byt_rvp_platform_data },
> > -	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
> > -						&byt_rvp_platform_data },
> > -	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
> > -						&byt_rvp_platform_data },
> > +	{
> > +		.id = "10EC5640",
> > +		.drv_name = "bytcr_rt5640",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcr_rt5640",
> > +		.machine_quirk = byt_quirk,
> > +		.pdata = &byt_rvp_platform_data,
> > +	},
> > +	{
> > +		.id = "10EC5642",
> > +		.drv_name = "bytcr_rt5640",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcr_rt5640",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> > +	{
> > +		.id = "INTCCFFD",
> > +		.drv_name = "bytcr_rt5640",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcr_rt5640",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> > +	{
> > +		.id = "10EC5651",
> > +		.drv_name = "bytcr_rt5651",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcr_rt5651",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> > +	{
> > +		.id = "DLGS7212",
> > +		.drv_name = "bytcht_da7213",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcht_da7213",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> > +	{
> > +		.id = "DLGS7213",
> > +		.drv_name = "bytcht_da7213",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcht_da7213",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> >  	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
> > -	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
> > -						&byt_rvp_platform_data },
> > -	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
> > -						&byt_rvp_platform_data },
> > +	{
> > +		.id = "10EC5645",
> > +		.drv_name = "cht-bsw-rt5645",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> > +	{
> > +		.id = "10EC5648",
> > +		.drv_name = "cht-bsw-rt5645",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> >  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
> >  	/*
> >  	 * This is always last in the table so that it is selected only when
> >  	 * enabled explicitly and there is no codec-related information in SSDT
> >  	 */
> > -	{"80860F28", "bytcht_nocodec", "intel/fw_sst_0f28.bin", "bytcht_nocodec", NULL,
> > -						&byt_rvp_platform_data },
> > +	{
> > +		.id = "80860F28",
> > +		.drv_name = "bytcht_nocodec",
> > +		.fw_filename = "intel/fw_sst_0f28.bin",
> > +		.board = "bytcht_nocodec",
> > +		.pdata = &byt_rvp_platform_data
> > +	},
> >  #endif
> >  	{},
> >  };
> >  
> >  /* Cherryview-based platforms: CherryTrail and Braswell */
> >  static struct sst_acpi_mach sst_acpi_chv[] = {
> > -	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -	{"10EC5672", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -	{"10EC3270", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -
> > -	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> > -						&chv_platform_data },
> > -	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
> > -						&chv_platform_data },
> > -	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
> > -						&chv_platform_data },
> > +	{
> > +		.id = "10EC5670",
> > +		.drv_name = "cht-bsw-rt5672",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "10EC5672",
> > +		.drv_name = "cht-bsw-rt5672",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "10EC5645",
> > +		.drv_name = "cht-bsw-rt5645",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "10EC5650",
> > +		.drv_name = "cht-bsw-rt5645",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "10EC3270",
> > +		.drv_name = "cht-bsw-rt5645",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +
> > +	{
> > +		.id = "193C9890",
> > +		.drv_name = "cht-bsw-max98090",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "cht-bsw",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "DLGS7212",
> > +		.drv_name = "bytcht_da7213",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcht_da7213",
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "DLGS7213",
> > +		.drv_name = "bytcht_da7213",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcht_da7213",
> > +		.pdata = &chv_platform_data
> > +	},
> >  	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
> > -	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
> > -						&chv_platform_data },
> > -	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
> > -						&chv_platform_data },
> > +	{
> > +		.id = "10EC5640",
> > +		.drv_name = "bytcr_rt5640",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcr_rt5640",
> > +		.machine_quirk = cht_quirk,
> > +		.pdata = &chv_platform_data
> > +	},
> > +	{
> > +		.id = "10EC3276",
> > +		.drv_name = "bytcr_rt5640",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcr_rt5640",
> > +		.pdata = &chv_platform_data
> > +	},
> >  	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
> > -	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
> > -						&chv_platform_data },
> > +	{
> > +		.id = "10EC5651",
> > +		.drv_name = "bytcr_rt5651",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcr_rt5651",
> > +		.pdata = &chv_platform_data
> > +	},
> >  #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
> >  	/*
> >  	 * This is always last in the table so that it is selected only when
> >  	 * enabled explicitly and there is no codec-related information in SSDT
> >  	 */
> > -	{"808622A8", "bytcht_nocodec", "intel/fw_sst_22a8.bin", "bytcht_nocodec", NULL,
> > -						&chv_platform_data },
> > +	{
> > +		.id = "808622A8",
> > +		.drv_name = "bytcht_nocodec",
> > +		.fw_filename = "intel/fw_sst_22a8.bin",
> > +		.board = "bytcht_nocodec",
> > +		.pdata = &chv_platform_data
> > +	},
> >  #endif
> >  	{},
> >  };
> > diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> > index 6df3b31..22a7e39 100644
> > --- a/sound/soc/intel/skylake/skl.c
> > +++ b/sound/soc/intel/skylake/skl.c
> > @@ -863,28 +863,66 @@ static void skl_remove(struct pci_dev *pci)
> >  }
> >  
> >  static struct sst_acpi_mach sst_skl_devdata[] = {
> > -	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
> > -	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
> > -				NULL, NULL, &skl_dmic_data },
> > -	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
> > -				NULL, NULL, &skl_dmic_data },
> > +	{
> > +		.id = "INT343A",
> > +		.drv_name = "skl_alc286s_i2s",
> > +		.fw_filename = "intel/dsp_fw_release.bin",
> > +	},
> > +	{
> > +		.id = "INT343B",
> > +		.drv_name = "skl_n88l25_s4567",
> > +		.fw_filename = "intel/dsp_fw_release.bin",
> > +		.pdata = &skl_dmic_data
> > +	},
> > +	{
> > +		.id = "MX98357A",
> > +		.drv_name = "skl_n88l25_m98357a",
> > +		.fw_filename = "intel/dsp_fw_release.bin",
> > +		.pdata = &skl_dmic_data
> > +	},
> >  	{}
> >  };
> >  
> >  static struct sst_acpi_mach sst_bxtp_devdata[] = {
> > -	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
> > -	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
> > +	{
> > +		.id = "INT343A",
> > +		.drv_name = "bxt_alc298s_i2s",
> > +		.fw_filename = "intel/dsp_fw_bxtn.bin",
> > +	},
> > +	{
> > +		.id = "DLGS7219",
> > +		.drv_name = "bxt_da7219_max98357a_i2s",
> > +		.fw_filename = "intel/dsp_fw_bxtn.bin",
> > +	},
> >  };
> >  
> >  static struct sst_acpi_mach sst_kbl_devdata[] = {
> > -	{ "INT343A", "kbl_alc286s_i2s", "intel/dsp_fw_kbl.bin", NULL, NULL, NULL },
> > -	{ "INT343B", "kbl_n88l25_s4567", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
> > -	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL, NULL, &skl_dmic_data },
> > +	{
> > +		.id = "INT343A",
> > +		.drv_name = "kbl_alc286s_i2s",
> > +		.fw_filename = "intel/dsp_fw_kbl.bin",
> > +	},
> > +	{
> > +		.id = "INT343B",
> > +		.drv_name = "kbl_n88l25_s4567",
> > +		.fw_filename = "intel/dsp_fw_kbl.bin",
> > +		.pdata = &skl_dmic_data
> > +	},
> > +	{
> > +		.id = "MX98357A",
> > +		.drv_name = "kbl_n88l25_m98357a",
> > +		.fw_filename = "intel/dsp_fw_kbl.bin",
> > +		.pdata = &skl_dmic_data
> > +	},
> >  	{}
> >  };
> >  
> >  static struct sst_acpi_mach sst_glk_devdata[] = {
> > -	{ "INT343A", "glk_alc298s_i2s", "intel/dsp_fw_glk.bin", NULL, NULL, NULL },
> > +	{
> > +		.id = "INT343A",
> > +		.drv_name = "glk_alc298s_i2s",
> > +		.fw_filename = "intel/dsp_fw_glk.bin",
> > +	},
> >  };
> >  
> >  /* PCI IDs */
> > -- 
> > 1.9.1
> > 
> 
> -- 
> ~Vinod

-- 
