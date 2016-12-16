From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/2] ASoC: core: Add API to use DMI
 name in sound card long name
Date: Fri, 16 Dec 2016 15:31:37 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8819ED4F7@shsmsx102.ccr.corp.intel.com>
References: <cover.1481856472.git.mengdong.lin@linux.intel.com>
 <895e6e34fdf601cea514f6a205711cba85bfcdce.1481856472.git.mengdong.lin@linux.intel.com>
 <1481877598.14684.202.camel@loki> <5853B86F.4080602@linux.intel.com>
 <6bb1f7e2-c133-5474-6551-9028833aae43@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E26C426690B
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 16:31:45 +0100 (CET)
In-Reply-To: <6bb1f7e2-c133-5474-6551-9028833aae43@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mengdong Lin <mengdong.lin@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Friday, December 16, 2016 10:38 PM
> To: Mengdong Lin <mengdong.lin@linux.intel.com>; Liam Girdwood
> <liam.r.girdwood@linux.intel.com>
> Cc: tiwai@suse.de; Koul, Vinod <vinod.koul@intel.com>; alsa-devel@alsa-
> project.org; broonie@kernel.org; Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH 1/2] ASoC: core: Add API to use DMI
> name in sound card long name
> 
> On 12/16/16 3:48 AM, Mengdong Lin wrote:
> >
> > On 12/16/2016 04:39 PM, Liam Girdwood wrote:
> >> On Fri, 2016-12-16 at 10:51 +0800, mengdong.lin@linux.intel.com wrote:
> >>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> >>>
> >>> Intel DSP platform drivers are used by many different devices but
> >>> are difficult for userspace to differentiate. This patch adds an API
> >>> to allow the DMI name to be used in the sound card long name,
> >>> thereby helping userspace load the correct UCM configuration.
> >>> Usually machine drivers uses their own name as the sound card name
> >>> (short name), and leave the long name and driver name blank. This
> >>> API will generate DMI name from the DMI vendor, product and board
> >>> info, and then make up a unique card long name from the short name
> >>> and DMI name. If the machine driver has already explicitly set the
> >>> long name, although not observed, this API will do nothing.
> >>>
> >>> This patch also allows for further differentiation as many devices
> >>> that share the same DMI name i.e. Minnowboards, UP boards may be
> >>> configured with different codecs or firmwares. The API supports
> >>> flavoring the DMI name into the card longname to provide the extra
> >>> differentiation required for these devices.

> >>> +/* Move the DMI stuff below to a new file soc-dmi.c? */ struct
> >>> +snd_soc_dmi_name  {
> >>> +    const char *vendor;
> >>> +    const char *product;
> >>> +    const char *board;
> >>> +    const char *name;
> >>> +};
> >>> +
> >>> +#define SOC_DMI_ENTRY(_vendor, _product, _board, _name) \
> >>> +    { .vendor = (_vendor), .board = (_board), \
> >>> +      .product = (_product), .name = (_name) }
> >>> +
> >>> +/* DMI names. The matched DMI name will be appended to the card
> >>> short name
> >>> + * to make up the card long name. Machine drivers ususally use
> >>> + their
> >>> own name
> >>> + * as the card short name, and leave the long name empty. Machine
> >>> driver may
> >>> + * call API snd_soc_set_dmi_name() to get a unique long name. In
> >>> user space,
> >>> + * Use Case Manager (UCM) will try to find the best configuration
> >>> file by
> >>> + * matching the card long name at first, and if unavailable, match
> >>> the short
> >>> + * name as a fallback.
> >>> + * For example, for a Boradwell-based Dell XPS 13-2015(9343), the
> >>> card short
> >>> + * name is "broadwell-rt286" and the DMI name is "DELL-XPS", so the
> >>> long name
> >>> + * will be "broadwell-rt286-Dell-XPS". For a new Skylake-based Dell
> >>> XPS 13/15,
> >>> + * if the short name is "skl-xyz" and DMI name is "Dell-XPS", the
> >>> long name
> >>> + * will be "skl-xyz-Dell-XPS".In user space, Use Case Manager (UCM)
> >>> will try
> >>> + * to find the best configuration file by matching the card long
> >>> name (e.g.
> >>> + * broadwell-rt286-Dell-XPS), and if unavailable, fallback to the
> >>> default
> >>> + * configuration file by matching the short name (e.g.
> >>> broadwell-rt286).
> >>> + */
> >>> +static struct snd_soc_dmi_name dmi_names[]  = {
> >>> +    SOC_DMI_ENTRY("Intel Corp.", "Broadwell Client platform",
> >>> +              "Wilson Beach SDS", "Intel-Wilson-Beach"),
> >>> +    SOC_DMI_ENTRY("Dell Inc.", "XPS 13 9343", "0310JH", "Dell-XPS"),
> >>> +    SOC_DMI_ENTRY("ASUSTeK COMPUTER INC.", "T100TA", "T100TA",
> >>> +              "ASUS-T100"),
> >>> +    {}    /* terminator */
> >>> +};
> >>
> >>
> >> We cant have any tables here or add new data for each machine. The
> >> intention is that the long name should be made from the DMI name
> >> (just a verbatim copy really). That way we dont need to do any new
> >> driver updates for a new machine, we just read the DMI name.
> >>
> >> UCM will then try and find a config for the long name first, then
> >> will revert to the current short/driver name to load the existing configs.
> >> This way we dont break legacy or current users.
> >>
> >> Liam
> >
> > Hi Liam,
> >
> > It seems different OEMs may have different flavor to define their DMI
> > info. Directly using verbatim copy may result in too many different
> > long names even for a product series that may share the same config.
> > So I use the table here for a product family to share a single
> > configuration file, which is not the default one with the same name as
> > the card short name/driver name.
> 
> we can't have a table, it's just impossible to maintain.

You're right, this cannot scale.  I'll remove the table and do verbatim copy on DMI info as Liam suggested.

The card long name will be "shortname-vendor-product-board". The 'product' field will sit before the 'board' field because Dell XPS and ASUS tablets show that 'product' may be more meaningful than or equivalent to the 'board' . I'll keep the 'board' field in the long name since other OEMs may have a more meaningful 'board' that 'product', like Intel.

> > Take Dell XPS family for example, there are Boradwell based XPS 13/15
> > in
> > 2014 and 2015, their product name can be different like:
> > XPS-13-xxxx, XPS-15-xxxx, and xxxx numbers are different for different
> > years. And its board name could also change. I hope they can share the
> > same card long name "broadwell-rt286-Dell-XPS" and the same UCM
> > configuration file. Since XPS 13 and 15 only differ in screen size and
> > GFX, only in audio HW. And xxxx does not matter here.
> >
> > Although Dell XPS family may always revert to the short name/driver
> > name to use the default UCM configuration file "broadwell-rt286" or
> > "skl-xxx". But there may be other OEM machine family that can share a
> > same UCM config file but not the default one. And I hope when users
> > write a UCM configuration file, the file name could be more user
> > friendly than a pure number.
> >
> > And actually, the table is an option. If user don't want to define an
> > entry for a specific machine, this function will to the verbatim copy
> > to make the long name in the code below.
> 
> The intent is to provide the information to userspace so that a UCM
> configuration is selected. the decision on how to use the information can be
> made there in user space, taking into account the way the DMI information
> is set and the desire from the community to track hardware differences.
> For example Asus is pretty clean, you can use the full name
> bytcr_rt5640_Asus_T100TA to find a configuration. Others keep changing the
> product name so there is no way to track hardware proliferation. For Dell
> you may need to broadwell-rt286-Dell and ignore the suffixes and variations
> of the same hardware. You'd have one configuration for an entire family of
> products.

Okay. We'll let UCM library in user space do the name matching to select the best UCM file. I'll try to make UCM do the matching automatically, maybe we still need some simple rules for different vendors, but will never maintain a table for each machine.

Thanks for your advice, Pierre and Liam!

Regards
Mengdong 
