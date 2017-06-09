From: "N, Harshapriya" <harshapriya.n@intel.com>
Subject: Re: [PATCH v2 3/3] ASoC: Intel: Add Kabylake
 RT5663+RT5514+MAX98927 machine driver entry
Date: Fri, 9 Jun 2017 22:19:52 +0000
Message-ID: <6030C7A2BCC49F4EBE16F6749B0C7F1A06D3DBC9@ORSMSX102.amr.corp.intel.com>
References: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
 <1496885261-10771-4-git-send-email-harshapriya.n@intel.com>
 <20170609034507.GT2885@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 499972676E3
 for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2017 00:19:54 +0200 (CEST)
In-Reply-To: <20170609034507.GT2885@localhost>
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
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Koul, Vinod
> Sent: Thursday, June 8, 2017 8:45 PM
> To: N, Harshapriya <harshapriya.n@intel.com>
> Cc: tiwai@suse.de; broonie@kernel.org; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2 3/3] ASoC: Intel: Add Kabylake
> RT5663+RT5514+MAX98927 machine driver entry
> 
> On Wed, Jun 07, 2017 at 06:27:41PM -0700, Harsha Priya wrote:
> > This patch adds Kabylake I2S machine driver which uses codecs
> > MAX98927 as speakers and RT5514 as dmic on ssp0 and
> > RT5663 as headset on ssp1.
> 
> 
> You missed signing off this patch.
> 
> Please reread Documentation/process/submitting-patches.rst and esp the
> "Developer's Certificate of Origin 1.1" part
> 
> Without SoB this submission cannot be considered.
My bad. I have updated it in the next version I just sent.

> 
> > ---
> >  sound/soc/intel/skylake/skl.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/sound/soc/intel/skylake/skl.c
> > b/sound/soc/intel/skylake/skl.c index 6a79fc7..e761550 100644
> > --- a/sound/soc/intel/skylake/skl.c
> > +++ b/sound/soc/intel/skylake/skl.c
> > @@ -896,6 +896,12 @@ static void skl_remove(struct pci_dev *pci)
> >  	.codecs = {"10EC5663"}
> >  };
> >
> > +static struct sst_codecs kbl_5663_5514_codecs = {
> > +	.num_codecs = 2,
> > +	.codecs = {"10EC5663", "10EC5514"}
> > +};
> > +
> > +
> >  static struct sst_acpi_mach sst_skl_devdata[] = {
> >  	{
> >  		.id = "INT343A",
> > @@ -960,6 +966,14 @@ static void skl_remove(struct pci_dev *pci)
> >  	},
> >  	{
> >  		.id = "MX98927",
> > +		.drv_name = "kbl_r5514_5663_max",
> > +		.fw_filename = "intel/dsp_fw_kbl.bin",
> > +		.machine_quirk = sst_acpi_codec_list,
> > +		.quirk_data = &kbl_5663_5514_codecs,
> > +		.pdata = &skl_dmic_data
> > +	},
> > +	{
> > +		.id = "MX98927",
> >  		.drv_name = "kbl_rt5663_m98927",
> >  		.fw_filename = "intel/dsp_fw_kbl.bin",
> >  		.machine_quirk = sst_acpi_codec_list,
> > --
> > 1.9.1
> >
> 
> --
> ~Vinod
