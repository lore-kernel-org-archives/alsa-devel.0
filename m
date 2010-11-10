From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA UCM
Date: Wed, 10 Nov 2010 16:11:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011101608250.29422@eeebox2.perex-int.cz>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
	<1289046396.3318.53.camel@odin>
	<AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BF6BA244CA
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 16:11:02 +0100 (CET)
In-Reply-To: <AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: abraham duenas <aduejazz@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Nov 2010, abraham duenas wrote:

> Hello, I think this is missing:
>
> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index e233f41..a73595d 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -774,9 +774,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>        pthread_mutex_lock(&uc_mgr->mutex);
>        if (strcmp(identifier, "_verbs") == 0)
>                err = get_verb_list(uc_mgr, list);
> -        else if (strcmp(identifier, "_enadevs"))
> +        else if (strcmp(identifier, "_enadevs") == 0)
>                err = get_enabled_device_list(uc_mgr, list);
> -        else if (strcmp(identifier, "_enamods"))
> +        else if (strcmp(identifier, "_enamods") == 0)
>                err = get_enabled_modifier_list(uc_mgr, list);
>         else {
>                 str1 = strchr(identifier, '/');

I added this fix to my ucm tree. Thaks.

> And changing the "[" for a "{" in the SectionVerb and SectionDevice like this:
> SectionVerb {
>        EnableSequence {
>                cset "name='DL1 Media Playback Volume' 90"
>                cset "name='DL2 Media Playback Volume' 90"
>        }
> ..........
> SectionDevice."Headset".0 {
>        Comment "SDP4430 3.5mm Headset"
>
>        EnableSequence {
>                cset "name='DL1 Mixer Multimedia' 0"
>                cset "name='Sidetone Mixer Playback' 1"
>                cset "name='HS Right Playback' 0"
>                cset "name='HS Left Playback' 0"
>                cset "name='MUX_UL11' 9"
>                cset "name='MUX_UL10' 10"
>        }
> ...........
>
> I'm getting the expected error ONLY for the last element: listed in
> the EnableSequence field:
> e.g:
> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
> 'name='DL2 Media Playback Volume' 90'
> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
> 'name='MUX_UL10' 10'
>
> i'll keep on digging as time permits :)

I fixed the sequence parser. It should work now ok. So the only missing 
part is to add the 'snd_ctl_*' backend for cset commands. The parsing 
functions for ctl strings are available in my ucm branch now:

char *snd_ctl_ascii_elem_id_get(snd_ctl_elem_id_t *id);
int snd_ctl_ascii_elem_id_parse(snd_ctl_elem_id_t *dst, const char *str);
int snd_ctl_ascii_value_parse(snd_ctl_t *handle,
                               snd_ctl_elem_value_t *dst,
                               snd_ctl_elem_info_t *info,
                               const char *value);

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
