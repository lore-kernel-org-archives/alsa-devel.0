From: "tyeo098@gmail.com" <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 8 Jul 2015 16:24:27 -0400
Message-ID: <CAFCNMknNOkyEcuVo=NU7rza4CnFR66Jh3TqxLCGvBf=ZpOBPZA@mail.gmail.com>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
 <559D3411.6060306@gmail.com>
 <20150708182132.db38656fb4ccc2e38e41aba0@ao2.it>
 <559D5091.9020802@gmail.com>
 <20150708221745.f72dcbec9c96eb86ce0cbfc2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 48F40265A81
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 22:24:29 +0200 (CEST)
Received: by obbgp5 with SMTP id gp5so46277664obb.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 13:24:28 -0700 (PDT)
In-Reply-To: <20150708221745.f72dcbec9c96eb86ce0cbfc2@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Nicolas George <george@nsup.org>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Antonio,

Thanks for the update.
Unfortunately I'm away from the device right now but ill try that first
thing in the morning.

I do recall blacklisting the module so only the Intel module loads however.

However it seems now I have been editing the common file and not the atom
specific sst-acpi.c file.

An oversight on my part, ill edit the irqindex in the correct file and
report back in the morning EST.

Thanks for the help!

Tyler
On Jul 8, 2015 4:17 PM, "Antonio Ospite" <ao2@ao2.it> wrote:

> On Wed, 08 Jul 2015 12:32:17 -0400
> Tyler Yeomans <tyeo098@gmail.com> wrote:
>
> > Antonio,
> >
> > Hmm...
> > I have been running the driver like so:
> > (from sound/soc/intel/common/sst-acpi.c)
> > static struct sst_acpi_desc sst_acpi_baytrail_desc = {
> >      .drv_name = "baytrail-pcm-audio",
> >      .machines = baytrail_machines,
> >      .resindex_lpe_base = 0,
> >      .resindex_pcicfg_base = 1,
> >      .resindex_fw_base = 2,
> > *    .irqindex_host_ipc = 0,*
> >      .sst_id = SST_DEV_ID_BYT,
> >      .resindex_dma_base = -1,
> > };
> >
> > Which is what the patch at
> > https://bugzilla.kernel.org/attachment.cgi?id=155341 says to do.
> >
>
> Ah, sorry, the info from that bug report is outdated, for the
> snd-intel-sst-acpi you have to change
> sound/soc/intel/atom/sst/sst_acpi.c:
>
>
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c
> b/sound/soc/intel/atom/sst/sst_acpi.c
> index bb19b58..0badfa3 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -118,7 +118,7 @@ static const struct sst_res_info byt_rvp_res_info = {
>         .mbox_size = 0x1000,
>         .acpi_lpe_res_index = 0,
>         .acpi_ddr_index = 2,
> -       .acpi_ipc_irq_index = 5,
> +       .acpi_ipc_irq_index = 0,
>  };
>
>  static struct sst_platform_info byt_rvp_platform_data = {
>
>
> I didn't have to do that because I fixed the DSDT.
>
> > However I also noticed in this file that its looking for the wrong
> > firmware:
> > static struct sst_acpi_mach baytrail_machines[] = {
> > *{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },*
> >      { "193C9890", "byt-max98090",
> > "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> >      {}
> > };
> >
> > Which will not point to the SSP0 firmware uploaded by Vinod.
> >
>
> Just to recap: make sure to use the snd-intel-sst-acpi driver instead
> of snd-soc-sst-acpi as explained earlier in this thread:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094418.html
>
> As a quick and dirty way to do it you can remove snd-soc-sst-acpi.ko
> from the modules installation dir.
>
> A more robust solution would be to blacklist snd-soc-sst-acpi.
>
> Ciao,
>    Antonio
>
> --
> Antonio Ospite
> http://ao2.it
>
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
>
