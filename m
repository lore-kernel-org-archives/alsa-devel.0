From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm
	2010-10-20-15-01	uploaded]
Date: Fri, 22 Oct 2010 13:51:38 +0200
Message-ID: <4CC17ACA.2090802@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com>	<s5hlj5sc7do.wl%tiwai@suse.de>	<4CBFF25C.2080908@gmail.com>	<s5hfww0c6oj.wl%tiwai@suse.de>
	<4CC085F5.9070905@gmail.com> <4CC17629.6050703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 09BA1243E6
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 13:51:41 +0200 (CEST)
Received: by bwz9 with SMTP id 9so1228479bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2010 04:51:40 -0700 (PDT)
In-Reply-To: <4CC17629.6050703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/22/2010 01:31 PM, Clemens Ladisch wrote:
> Jiri Slaby wrote:
>> On 10/21/2010 10:05 AM, Takashi Iwai wrote:
>>>   commit de8c85f7840e5e29629de95f5af24297fb325e0b
>>>     ALSA: HDA: Sigmatel: work around incorrect master muting
>>
>> Reverting this one helps.
> 
> This one introduced even more wrong volume information on some codecs.
> Pleasy try this patch on top:

Yup, works for me.

> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -32,6 +32,7 @@
>  #include <sound/core.h>
>  #include <sound/asoundef.h>
>  #include <sound/jack.h>
> +#include <sound/tlv.h>
>  #include "hda_codec.h"
>  #include "hda_local.h"
>  #include "hda_beep.h"
> @@ -1145,7 +1146,7 @@ static int stac92xx_build_controls(struct hda_codec *codec)
>  		/* correct volume offset */
>  		vmaster_tlv[2] += vmaster_tlv[3] * spec->volume_offset;
>  		/* minimum value is actually mute */
> -		vmaster_tlv[3] |= 0x1000;
> +		vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
>  		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
>  					  vmaster_tlv, slave_vols);
>  		if (err < 0)
> 

thanks,
-- 
js
