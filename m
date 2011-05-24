From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 24 May 2011 10:27:45 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A4820B@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>	<s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>	<s5htycr0zuf.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A480B7@HQMAIL01.nvidia.com>
	<s5hr57o4py8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 608B4103847
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 19:28:00 +0200 (CEST)
In-Reply-To: <s5hr57o4py8.wl%tiwai@suse.de>
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

Takashi Iwai wrote at Monday, May 23, 2011 11:40 PM:
> At Mon, 23 May 2011 14:49:15 -0700, Stephen Warren wrote:
> > ...
> > I've been testing a preliminary fix for this internally. I found that
> > the /proc ELD files correctly report monitor_present and eld_valid when
> > we hot unplug a monitor, but the other fields in the ELD file are not
> > cleared out to their default state. As best I can tell, this is an ALSA
> > driver issue, since our display driver only fills in the other fields
> > when ELDV==1.
> 
> Then it's just showing stale data.  The eld fields are updated only
> when the data is valid.  The patch below should fix the confusion.

> ---
> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
> index 74b0560..cd96b1d 100644
> --- a/sound/pci/hda/hda_eld.c
> +++ b/sound/pci/hda/hda_eld.c
> @@ -477,6 +477,8 @@ static void hdmi_print_eld_info(struct snd_info_entry
> *entry,
> 
>  	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
>  	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
> +	if (!e->eld_valid)
> +		return;
>  	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
>  	snd_iprintf(buffer, "connection_type\t\t%s\n",
>  				eld_connection_type_names[e->conn_type]);

Takashi,

Your patch looks fine as far as the reporting side goes.

Should we also modify hdmi_intrinsic_event() as follows:

	if (pind && eldv) {
		hdmi_get_show_eld(codec, spec->pin[index],
				  &spec->sink_eld[index]);
		/* TODO: do real things about ELD */
	}
+	else {
+		memset(&spec->sink_eld[index], 0, sizeof(spec->sink_eld[index]));
+	}

... to make sure that if something accidentally uses the ELD data
without checking eld_valid, it'll get obviously bad data instead of
valid-looking-but-stale data? Right now, this isn't an issue, but if
we start pushing the ELD into user-space through a binary control,
it'd be nice if the ELD content were consistent in this way.

Hmm. Actually, hdmi_eld isn't storing the raw ELD bytes, but a parsed
representation of them, so this may not be entirely relevant.

-- 
nvpublic
