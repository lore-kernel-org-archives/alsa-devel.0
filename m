From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Make slave strings more
	user-friendly
Date: Fri, 27 Feb 2015 20:21:07 +0100
Message-ID: <54F0C3A3.8060300@canonical.com>
References: <54f0bf96.2c66145e.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3762608B4
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 20:21:02 +0100 (CET)
In-Reply-To: <54f0bf96.2c66145e.bm001@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?windows-1252?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org



On 2015-02-27 20:03, Ingo Br=FCckl wrote:
> "Line Out" has been used throughout, so don't abbreviate.

The abbreviation is on purpose because there are string lengths you need =

to stay under, especially combined with other stuff, an extreme example =

would be "Front Headphone+Line Out Surround Playback Volume" that might =

get cut off.

Also, "Headphone+LO" is already put into PulseAudio (and potentially =

other places as well).

So please don't change this.

>
> Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index b680b4e..834730f 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1103,9 +1103,9 @@ static const char *get_line_out_pfx(struct hda_code=
c *codec, int ch,
>   			if (hp_lo_shared && spk_lo_shared)
>   				return spec->vmaster_mute.hook ? "PCM" : "Master";
>   			if (hp_lo_shared)
> -				return "Headphone+LO";
> +				return "Headphone+Line Out";
>   			if (spk_lo_shared)
> -				return "Speaker+LO";
> +				return "Speaker+Line Out";
>   		}
>   	}
>
> @@ -4619,7 +4619,7 @@ static const char * const slave_pfxs[] =3D {
>   	"CLFE", "Bass Speaker", "PCM",
>   	"Speaker Front", "Speaker Surround", "Speaker CLFE", "Speaker Side",
>   	"Headphone Front", "Headphone Surround", "Headphone CLFE",
> -	"Headphone Side", "Headphone+LO", "Speaker+LO",
> +	"Headphone Side", "Headphone+Line Out", "Speaker+Line Out",
>   	NULL,
>   };
>
> --
> 1.7.10
>

-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
