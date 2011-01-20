From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about ASOC codec drivers
Date: Thu, 20 Jan 2011 20:54:35 +0000
Message-ID: <20110120205435.GA1815@opensource.wolfsonmicro.com>
References: <AANLkTim-3xObWzoF4aMUA6umYcD=wDhvY+mChqQhU=JY@mail.gmail.com>
	<20110118191923.GB17591@sirena.org.uk>
	<AANLkTinKB1gHgrvk=pfbqqQnGaebne6uuVFFGARdS7+D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E396243EF
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:54:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinKB1gHgrvk=pfbqqQnGaebne6uuVFFGARdS7+D@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neiljay@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 04:12:12PM +0000, Neil Jones wrote:
> > ...is exactly what you told the driver to do.  You've told the core
> > there are seven items in the enumeration so it's expecting an array of
> > seven strings.

> DUH! sorry, in my head i read .xmax as .xmask cheers for the spot.

> I still get 'Failed to add route Line Input->Input Mux' though ?

You've probably typoed one of the strings.  Look at the code to see why
it's detecting this error.

> @@ -761,6 +761,8 @@ typedef int __bitwise snd_ctl_elem_iface_t;
>  #define SNDRV_CTL_POWER_D3hot          (SNDRV_CTL_POWER_D3|0x0000)
>  /* Off, with power */
>  #define SNDRV_CTL_POWER_D3cold         (SNDRV_CTL_POWER_D3|0x0001)
>  /* Off, without power */
> 
> +#define SNDRV_CTL_ELEMENT_INFO_NAME_LENGTH 64
> +
>  struct snd_ctl_elem_id {
>         unsigned int numid;             /* numeric identifier, zero = invalid */
>         snd_ctl_elem_iface_t iface;     /* interface identifier */
> @@ -799,7 +801,8 @@ struct snd_ctl_elem_info {
>                 struct {
>                         unsigned int items;     /* R: number of items */
>                         unsigned int item;      /* W: item number */
> -                       char name[64];          /* R: value name */
> +                       /* R: value name */
> +                       char name[SNDRV_CTL_ELEMENT_INFO_NAME_LENGTH];
>                 } enumerated;
>                 unsigned char reserved[128];
>         } value;

This I'd submit separately to Takashi.

> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2056,8 +2056,9 @@ int snd_soc_info_enum_double(struct snd_kcontrol
> *kcontrol,
> 
>         if (uinfo->value.enumerated.item > e->max - 1)
>                 uinfo->value.enumerated.item = e->max - 1;
> -       strcpy(uinfo->value.enumerated.name,
> -               e->texts[uinfo->value.enumerated.item]);
> +       strncpy(uinfo->value.enumerated.name,
> +               e->texts[uinfo->value.enumerated.item],
> +               SNDRV_CTL_ELEMENT_INFO_NAME_LENGTH);
>         return 0;

ARRAY_SIZE() would do just as well here but this does look reasonable.
