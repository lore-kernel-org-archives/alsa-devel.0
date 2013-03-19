From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: usb: Parse UAC2 extension unit like
 for UAC1
Date: Tue, 19 Mar 2013 17:24:33 +0100
Message-ID: <51489141.4060405@gmail.com>
References: <20130319161214.GB7539@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BD1260309
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 17:24:33 +0100 (CET)
Received: by mail-bk0-f44.google.com with SMTP id j4so328887bkw.31
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 09:24:33 -0700 (PDT)
In-Reply-To: <20130319161214.GB7539@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.03.2013 17:12, Torstein Hegge wrote:
> UAC2_EXTENSION_UNIT_V2 differs from UAC1_EXTENSION_UNIT, but can be handled in
> the same way when parsing the unit. Otherwise parse_audio_unit() fails when it
> sees an extension unit on a UAC2 device.
> 
> UAC2_EXTENSION_UNIT_V2 is outside the range allocated by UAC1.
> 
> Signed-off-by: Torstein Hegge <hegge@resisty.net>

I can't test this, but the change seems fine, so I'll give my

Acked-by: Daniel Mack <zonque@gmail.com>

Apart from that, I already prepared some patches to make mixer unit
failures non-fatal, so that future occurances of unhandled unit types
won't prevent the entire card creation. I'll wait from test feedback and
then submit.



Thanks,
Daniel



> ---
>  sound/usb/mixer.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 638e7f7..8eb84c0 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -725,7 +725,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
>  		case UAC1_PROCESSING_UNIT:
>  		case UAC1_EXTENSION_UNIT:
>  		/* UAC2_PROCESSING_UNIT_V2 */
> -		/* UAC2_EFFECT_UNIT */ {
> +		/* UAC2_EFFECT_UNIT */
> +		case UAC2_EXTENSION_UNIT_V2: {
>  			struct uac_processing_unit_descriptor *d = p1;
>  
>  			if (state->mixer->protocol == UAC_VERSION_2 &&
> @@ -2052,6 +2053,8 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
>  			return parse_audio_extension_unit(state, unitid, p1);
>  		else /* UAC_VERSION_2 */
>  			return parse_audio_processing_unit(state, unitid, p1);
> +	case UAC2_EXTENSION_UNIT_V2:
> +		return parse_audio_extension_unit(state, unitid, p1);
>  	default:
>  		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
>  		return -EINVAL;
> 
