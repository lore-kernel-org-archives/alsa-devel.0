From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: [PATCH] hda: Add dmux to STAC 9228
Date: Fri, 19 Oct 2007 12:45:16 -0600
Message-ID: <4718FB3C.9080607@canonical.com>
References: <4717D1E0.9080903@embeddedalley.com> <4718DF33.501@canonical.com>
	<4718F072.9060007@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tpi.com (mail.tpi.com [198.107.51.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 535C224679
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 20:45:33 +0200 (CEST)
In-Reply-To: <4718F072.9060007@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Tellman,
	Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

This doesn't seem to make a lot of difference. The external microphone
is marginally better, but still not really usable (recognizable but
distorted). The Gnome ALSA mixer shows 3 capture sources plus digital
and 3 mux's. Only the first capture source records anything. I verified
that you must have an external mic plugged in just to make sure the
built-in mic wasn't recording.

rtg

Matthew Ranostay wrote:
> I think the problem is that I set the dmux to ADC1MUX instead of
> ADC0MUX, could you test this patch to confirm?
> Please let me know your results.
> 
> Thanks,
> 
> Matt Ranostay
> 
> 
> ------------------------------------------------------------------------
> 
> diff -r 7cf5e23f804e pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Fri Oct 19 08:23:00 2007 +0200
> +++ b/pci/hda/patch_sigmatel.c	Fri Oct 19 13:47:35 2007 -0400
> @@ -2777,7 +2777,7 @@ static int patch_stac927x(struct hda_cod
>  	case 0x10280209: /* STAC 9228 */
>  		spec->dmic_nids = stac927x_dmic_nids;
>  		spec->num_dmics = STAC927X_NUM_DMICS;
> -		spec->dmux_nid = 0x1c;
> +		spec->dmux_nid = 0x1b;
>  		break;
>  	default:
>  		spec->num_dmics = 0;	
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Tim Gardner tim.gardner@ubuntu.com
