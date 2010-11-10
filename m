From: abraham duenas <aduejazz@gmail.com>
Subject: Re: [PATCH] add missing comparison to strcmp call
Date: Wed, 10 Nov 2010 08:59:44 -0600
Message-ID: <AANLkTi=3qaVqW+jtG9Pf56Fp_pyNjak5L3gD9gU4P4Ev@mail.gmail.com>
References: <AANLkTi=Chhzawwe=84Z6K11TFi4hpe2d+zW4zNy49DLw@mail.gmail.com>
	<1289394784.3284.35.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A6298244B7
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 15:59:47 +0100 (CET)
Received: by wyb33 with SMTP id 33so795241wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 06:59:45 -0800 (PST)
In-Reply-To: <1289394784.3284.35.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 10, 2010 at 7:13 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Tue, 2010-11-09 at 15:43 -0600, abraham duenas wrote:
>> >From f796e5f464d3454761b618912e5b4d14716c2bfc Mon Sep 17 00:00:00 2001
>> From: abraham duenas <abraham.duenas@ti.com>
>> Date: Tue, 9 Nov 2010 15:31:16 -0600
>> Subject: [PATCH] add missing comparison to strcmp call
>>
>
> Could do with a little more description here.
>
>>
>> Signed-off-by: abraham duenas <abraham.duenas@ti.com>
>> ---
>> =A0src/ucm/main.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/ucm/main.c b/src/ucm/main.c
>> index e233f41..a73595d 100644
>> --- a/src/ucm/main.c
>> +++ b/src/ucm/main.c
>> @@ -774,9 +774,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>> =A0 =A0 =A0 =A0 pthread_mutex_lock(&uc_mgr->mutex);
>> =A0 =A0 =A0 =A0 if (strcmp(identifier, "_verbs") =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_verb_list(uc_mgr, list);
>> - =A0 =A0 =A0 =A0else if (strcmp(identifier, "_enadevs"))
>> + =A0 =A0 =A0 =A0else if (strcmp(identifier, "_enadevs") =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_enabled_device_list(uc_mgr, =
list);
>> - =A0 =A0 =A0 =A0else if (strcmp(identifier, "_enamods"))
>> + =A0 =A0 =A0 =A0else if (strcmp(identifier, "_enamods") =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D get_enabled_modifier_list(uc_=
mgr, list);
>> =A0 =A0 =A0 =A0 =A0else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str1 =3D strchr(identifier, '/');
>
> Looks fine to me, did this solve all your parsing issues ?
>
> Thanks
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>

Not completely... I'm getting the "cset not yet implemented..."
warning for the last element in the row. This is, for this sequence:
cset "name=3D'Master Playback Switch' 1,1"
cset "name=3D'Master Playback Volume' 25,25"
cset "name=3D'Master Mono Playback' 0"

I only get the warning for the last cset call:
"cset not yet implemented: 'name=3D'Master Mono Playback' 0'
