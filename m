From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 24 May 2011 14:00:13 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A482F4@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>	<s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com>	<s5htycr0zuf.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A480B7@HQMAIL01.nvidia.com>
	<s5hr57o4py8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7007510385F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 23:00:21 +0200 (CEST)
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

Thinking about this more, that condition should be:

    if (!(eld->monitor_present && eld->eld_valid))

I think. Of course, graphics drivers shouldn't be setting ELDV without
PD, but best to be safe within ALSA.

As background, it looks like one of our codecs might be inverting the
PD bit (an issue different to the existing old_pin_detect WAR), which
ends up causing that combination.

Related, there are a few inconsistencies in the way patch_hdmi.c handles
ELD retrieval; hdmi_present_sense looks only at ELDV, whereas
hdmi_intrinsic_event looks at both PD and ELDV. I plan to make a patch
to solve that and the WAR for the NVIDIA HW PD handling above. I can
roll your change into that if you want.

>  	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
>  	snd_iprintf(buffer, "connection_type\t\t%s\n",
>  				eld_connection_type_names[e->conn_type]);

-- 
nvpublic
