From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix wrong detection of
 "Headphone+LO" or "Speaker+LO"
Date: Tue, 03 Mar 2015 14:24:28 +0100
Message-ID: <54F5B60C.1050808@canonical.com>
References: <54f5995b.7e5343ac.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A46826149D
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 14:24:30 +0100 (CET)
In-Reply-To: <54f5995b.7e5343ac.bm001@wupperonline.de>
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Ingo and thanks for trying to improve the driver,

I've been reading through the alsa-devel thread but your alsa-info was =

removed when it was posted to the list so it's a bit hard to see the =

context.

If I understand correctly, you have three DACs, one internal speaker, =

one headphone jack, and three jacks that are both used for 5.1 surround =

and line out/mic/line in. Is this correct?

How do the DACs get assigned in this case? One would assume that you'd =

get 02 -> Front LO, HP, Speaker, 03 -> Rear LO, 04 -> CLFE LO. And then =

the volume/mute control for DAC node 02 would be called "PCM" (since =

both hp_lo_shared and spk_lo_shared are true), but in fact it would be =

more appropriate to call it "Front".

Anyhow, I'd say that the typical case where we want the "Headphone+LO" =

names is where we have only one LO, and then multiout.num_dacs would be =

1, not 2. (I think, it was a while since I looked into that part of the =

driver...)

// David

On 2015-03-03 12:22, Ingo Br=FCckl wrote:
> Add the constraint mentioned in the comment.
>
> It does not apply to a scenario with three DACs and multi-IO where we
> would normally get a "Master Playback Volume" and a "Front Playback
> Volume" (prevented without checking for num_dacs).
>
> Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index ecee349..4c8910c 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1097,7 +1097,7 @@ static const char *get_line_out_pfx(struct hda_code=
c *codec, int ch,
>   	case AUTO_PIN_LINE_OUT:
>   		/* This deals with the case where we have two DACs and
>   		 * one LO, one HP and one Speaker */
> -		if (!ch && cfg->speaker_outs && cfg->hp_outs) {
> +		if (!ch && spec->multiout.num_dacs =3D=3D 2 && cfg->speaker_outs && cf=
g->hp_outs) {
>   			bool hp_lo_shared =3D !path_has_mixer(codec, spec->hp_paths[0], ctl_=
type);
>   			bool spk_lo_shared =3D !path_has_mixer(codec, spec->speaker_paths[0]=
, ctl_type);
>   			if (hp_lo_shared && spk_lo_shared)
> --
> 1.7.10
>

-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
