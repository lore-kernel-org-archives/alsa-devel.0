From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: ice1724 - Changing Level Meters from MIXER to PCM?
Date: Tue, 06 Oct 2009 10:28:01 +0200
Message-ID: <4ACAFF91.1050908@ivitera.com>
References: <4ACAFE00.9050308@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 51DA7103874
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 10:27:36 +0200 (CEST)
In-Reply-To: <4ACAFE00.9050308@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Hi,
> 
> Following your discussion on moving low-level controls from MIXER to PCM
> types, I would like to suggest the following two patches:
> 
> diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
> index 3896fb9..28ca8a4 100644
> --- a/sound/pci/ice1712/ice1724.c
> +++ b/sound/pci/ice1712/ice1724.c
> @@ -2160,7 +2160,7 @@ static int snd_vt1724_pro_peak_get(struct
> snd_kcontrol *kcontrol,
>  }
> 
>  static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
> -       .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +       .iface = SNDRV_CTL_ELEM_IFACE_PCM,
>         .name = "Multi Track Peak",
>         .access = SNDRV_CTL_ELEM_ACCESS_READ |
> SNDRV_CTL_ELEM_ACCESS_VOLATILE,
>         .info = snd_vt1724_pro_peak_info,
> 
> 
> diff --git a/envy24control/levelmeters.c b/envy24control/levelmeters.c
> index 3bf1a94..9bdaace 100644
> --- a/envy24control/levelmeters.c
> +++ b/envy24control/levelmeters.c
> @@ -262,7 +262,7 @@ void level_meters_reset_peaks(GtkButton *button,
> gpointer da
>  void level_meters_init(void)
>  {
>         snd_ctl_elem_value_malloc(&peaks);
> -       snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_MIXER);
> +       snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_PCM);
>         snd_ctl_elem_value_set_name(peaks, "Multi Track Peak");
>  }
> 
> 
> 
> 
> The point is these controls are read-only, display incorrectly in
> alsamixer, and are very confusing for majority of users who do not read
> envy24 datasheet and the source code.
> 
> Thanks for considering this IMO useful change.
> 
> Regards,
> 


Sorry for a mistake - envy24control is used for ice1712 only, i.e. the
change should happen in ice1712.c too. No further implications for
change in ice1724.c.

Should you approve the change, I will send proper patch emails.


Thanks,

Pavel
