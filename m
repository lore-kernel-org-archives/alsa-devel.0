From: "N, Harshapriya" <harshapriya.n@intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: Intel: Convert all sst_codecs
 data defintion to c99 style
Date: Fri, 9 Jun 2017 22:20:02 +0000
Message-ID: <6030C7A2BCC49F4EBE16F6749B0C7F1A06D3DBD8@ORSMSX102.amr.corp.intel.com>
References: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
 <1496885261-10771-3-git-send-email-harshapriya.n@intel.com>
 <20170609035852.GU2885@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D65CE26771B
 for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2017 00:20:04 +0200 (CEST)
In-Reply-To: <20170609035852.GU2885@localhost>
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
> Sent: Thursday, June 8, 2017 8:59 PM
> To: N, Harshapriya <harshapriya.n@intel.com>
> Cc: tiwai@suse.de; broonie@kernel.org; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2 2/3] ASoC: Intel: Convert all sst_codecs data defintion
> to c99 style
> 
> On Wed, Jun 07, 2017 at 06:27:40PM -0700, Harsha Priya wrote:
> > C99 style struct initialization helps in readability as well as
> > initialization of variables not specified as NULL. This patch changes
> > the struct data defintions in skl.c that were not in c99 style.
> 
> here as well :(
Sorry. My bad. I have updated it in the next version I just sent.
> 
> > ---
> >  sound/soc/intel/skylake/skl.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/intel/skylake/skl.c
> > b/sound/soc/intel/skylake/skl.c index 4ebae85..6a79fc7 100644
> > --- a/sound/soc/intel/skylake/skl.c
> > +++ b/sound/soc/intel/skylake/skl.c
> > @@ -876,10 +876,25 @@ static void skl_remove(struct pci_dev *pci)
> >  	dev_set_drvdata(&pci->dev, NULL);
> >  }
> >
> > -static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} }; -static
> > struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} }; -static struct
> > sst_codecs bxt_codecs = { 1, {"MX98357A"} }; -static struct sst_codecs
> > kbl_poppy_codecs = { 1, {"10EC5663"} };
> > +static struct sst_codecs skl_codecs = {
> > +	.num_codecs = 1,
> > +	.codecs = {"NAU88L25"}
> > +};
> > +
> > +static struct sst_codecs kbl_codecs = {
> > +	.num_codecs = 1,
> > +	.codecs = {"NAU88L25"}
> > +};
> > +
> > +static struct sst_codecs bxt_codecs = {
> > +	.num_codecs = 1,
> > +	.codecs = {"MX98357A"}
> > +};
> > +
> > +static struct sst_codecs kbl_poppy_codecs = {
> > +	.num_codecs = 1,
> > +	.codecs = {"10EC5663"}
> > +};
> >
> >  static struct sst_acpi_mach sst_skl_devdata[] = {
> >  	{
> > --
> > 1.9.1
> >
> 
> --
> ~Vinod
