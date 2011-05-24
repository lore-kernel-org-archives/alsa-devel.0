From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 24 May 2011 12:18:28 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A48288@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>	<s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>	<s5htycr0zuf.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A480B7@HQMAIL01.nvidia.com>
	<s5hr57o4py8.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A4820B@HQMAIL01.nvidia.com>
	<s5hfwo43r81.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id E29B71039AF
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 21:18:47 +0200 (CEST)
In-Reply-To: <s5hfwo43r81.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>, ALSA@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Tuesday, May 24, 2011 12:10 PM:
> > Takashi Iwai wrote at Monday, May 23, 2011 11:40 PM:
> > > ---
> > > diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
> > > index 74b0560..cd96b1d 100644
> > > --- a/sound/pci/hda/hda_eld.c
> > > +++ b/sound/pci/hda/hda_eld.c
> > > @@ -477,6 +477,8 @@ static void hdmi_print_eld_info(struct snd_info_entry
> > > *entry,
> > >
> > >  	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
> > >  	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
> > > +	if (!e->eld_valid)
> > > +		return;
> > >  	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
> > >  	snd_iprintf(buffer, "connection_type\t\t%s\n",
> > >  				eld_connection_type_names[e->conn_type]);

> ---
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 3229018..4dbe8d6 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -707,6 +707,7 @@ static void hdmi_intrinsic_event(struct hda_codec
> *codec, unsigned int res)
>  	if (index < 0)
>  		return;
> 
> +	memset(&spec->sink_eld[index], 0, sizeof(spec->sink_eld[index]));
>  	if (spec->old_pin_detect) {
>  		if (pind)
>  			hdmi_present_sense(codec, tag, &spec->sink_eld[index]);

Both:
Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks.

-- 
nvpublic
