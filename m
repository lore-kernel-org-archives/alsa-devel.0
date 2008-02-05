From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-tools: hdspmixer - Fix Digiface
	channel map for ADAT speed mode 1
Date: Tue, 05 Feb 2008 14:44:26 +0100
Message-ID: <m23as734cl.fsf@vador.mandriva.com>
References: <ALOGGER1202214458.5@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EA82243EA
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 14:44:34 +0100 (CET)
In-Reply-To: <ALOGGER1202214458.5@alsa-project.org> (Takashi Iwai's message of
	"Tue\, 5 Feb 2008 13\:27\:38 +0100 \(CET\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> changeset:   365:9d1e48f8dd5d
> tag:         tip
> user:        tiwai
> date:        Tue Feb 05 13:30:45 2008 +0100
> files:       hdspmixer/src/HDSPMixerCard.cxx
> description:
> hdspmixer - Fix Digiface channel map for ADAT speed mode 1
> 
> Fixed the channel map for ADAT speed mode 1 (rate > 48000).
> ALSA bug#3732
> 	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3732
 
Will you move the 1.0.16 tag so that it got included in final release?
 
> diff -r 7f30f325ab54 -r 9d1e48f8dd5d hdspmixer/src/HDSPMixerCard.cxx
> --- a/hdspmixer/src/HDSPMixerCard.cxx	Tue Feb 05 10:08:12 2008 +0100
> +++ b/hdspmixer/src/HDSPMixerCard.cxx	Tue Feb 05 13:30:45 2008 +0100
> @@ -299,7 +299,7 @@ void HDSPMixerCard::adjustSettings() {
>  	    break;
>  	case 1:
>  	    channels = 14;
> -	    channel_map = channel_map_ds;
> +	    channel_map = meter_map_ds;
>  	    dest_map = dest_map_ds;
>  	    meter_map = meter_map_ds;
>  	    lineouts = 2;
