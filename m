From: Benjamin Valentin <benpicco@googlemail.com>
Subject: Re: No surround sound with ALC892 on B150M Pro4/D3 -
 fixed with hdajackretask
Date: Thu, 20 Oct 2016 23:47:47 +0200
Message-ID: <20161020234747.5d1da301@nashorn>
References: <20161018005049.79d55d0b@nashorn>
	<s5hpomv1fyv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 293DB261B03
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 23:47:50 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id x79so2295326lff.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 14:47:50 -0700 (PDT)
In-Reply-To: <s5hpomv1fyv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Oct 2016 12:18:16 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Does the patch below work for you?

Thank you, that works - there is only one typo ;)

> ---
>  sound/pci/hda/patch_realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c index b582d57fe184..284315555229
> 100644 --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
>  static const struct hda_fixup alc662_fixups[] = {
> @@ -6901,6 +6902,16 @@ static const struct hda_fixup alc662_fixups[]
> = { { }
>  		}
>  	},
> +	[ALC892_FIXUP_ASROCK_MOBO] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x15, 0x40f000f0 }, /* disabled */
> +			{ 0x16, 0x40f000f0 }, /* disabled */
> +			{ 0x18, 0x01014011 }, /* LO */
> +			{ 0x18, 0x01014012 }, /* LO */
			^^^^^^
should be
  +			{ 0x15, 0x40f000f0 }, /* disabled */
  +			{ 0x16, 0x40f000f0 }, /* disabled */
  +			{ 0x18, 0x01014011 }, /* LO */
  +			{ 0x1a, 0x01014012 }, /* LO */

otherwise there will be no center/lfe channel.

Thanks!
Benjamin
