From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ALSA: HDA: hda_local: Less magic numbers.
Date: Mon, 15 Sep 2008 09:10:10 +0930 (CST)
Message-ID: <200809142340.m8ENeAHC016054@turbo.physics.adelaide.edu.au>
References: <mailman.1.1221386401.30073.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 43EEF24633
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 14:05:38 +0200 (CEST)
In-Reply-To: <mailman.1.1221386401.30073.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Sep 14, 2008 12:00:01 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: robbat2@gentoo.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Robin H. Johnson wrote:

> Explain some of the magic numbers I saw while trying to fix the AD1989 SPDIF
> issue. Maybe should just use the expanded form directly in the verbs?
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> 
> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
> index d688f50..7957fef 100644
> --- a/sound/pci/hda/hda_local.h
> +++ b/sound/pci/hda/hda_local.h
> @@ -368,12 +368,15 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
>  #define AMP_OUT_UNMUTE	0xb000
>  #define AMP_OUT_ZERO	0xb000
>  /* pinctl values */
> -#define PIN_IN		0x20
> -#define PIN_VREF80	0x24
> -#define PIN_VREF50	0x21
> -#define PIN_OUT		0x40
> -#define PIN_HP		0xc0
> -#define PIN_HP_AMP	0x80
> +#define PIN_IN			(AC_PINCTL_IN_EN)
> +#define PIN_VREFHIZ	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_HIZ)
> +#define PIN_VREF50		(AC_PINCTL_IN_EN | AC_PINCTL_VREF_50)
> +#define PIN_VREFGRD	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_GRD)
> +#define PIN_VREF80		(AC_PINCTL_IN_EN | AC_PINCTL_VREF_80)
> +#define PIN_VREF100	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_100)
> +#define PIN_OUT		(AC_PINCTL_OUT_EN)
> +#define PIN_HP			(AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN)
> +#define PIN_HP_AMP		(AC_PINCTL_HP_EN)

Shrug.  In my opinion the above patch simply reworks the explanation,
shifting the "magic" from the PIN_* definitions to the AC_PINCTL_* defines.
One could take things one step further and replace the PIN_* defines with
AC_PINCTL_* references throughout the code, but this would make the code far
more verbose and harder to follow.

At the end of the day I'm not fussed either way.  Having said that, I don't
really see the practical advantage of the change but if Takashi et al thing
it's a good idea then I wouldn't oppose it.

Regards
  jonathan
