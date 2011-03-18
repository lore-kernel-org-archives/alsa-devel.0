From: Margarita Olaya <magi@slimlogic.co.uk>
Subject: Re: [PATCH] alsa-lib: ucm: allow values to be read
	from devices
Date: Fri, 18 Mar 2011 10:19:31 -0600
Message-ID: <AANLkTinyCJahMWNuKNjcpXScPespqmVWnvJufTn1rT5c@mail.gmail.com>
References: <AANLkTikd29BONAW9Zqwrb=tKN1iSVcsig+6Egi1001WD@mail.gmail.com>
	<s5h1v24touc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F9101039F4
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 17:19:36 +0100 (CET)
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by slimlogic.co.uk (Postfix) with ESMTPSA id 232551304BC
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 16:19:33 +0000 (GMT)
Received: by vws16 with SMTP id 16so3880792vws.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 09:19:32 -0700 (PDT)
In-Reply-To: <s5h1v24touc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Fri, Mar 18, 2011 at 9:44 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 15 Mar 2011 10:45:19 -0600,
> Margarita Olaya wrote:
>>
>> This allows devices value to be read using the get_value().
>> Also fix a little formatting.
>>
>> Signed-off-by: Margarita Olaya Cabrera <magi@slimlogic.co.uk>
>> ---
>> =A0src/ucm/main.c | =A0 19 +++++++++++++------
>> =A01 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/src/ucm/main.c b/src/ucm/main.c
>> index 42fd373..fb11e61 100644
>> --- a/src/ucm/main.c
>> +++ b/src/ucm/main.c
>> @@ -1063,20 +1063,27 @@ static int get_value3(const char **value,
>> =A0 * \return Zero on success (value is filled), otherwise a negative er=
ror code
>> =A0 */
>> =A0static int get_value(snd_use_case_mgr_t *uc_mgr,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *identifier,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char **value,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *modifier)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *identifier,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char **value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *item)
>
> Please fix also the corresponding DocBook comment when you change the
> parameter (and semantics).
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev =3D find_device(uc_mgr->active_verb, item);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_value1(value, &dev=
->value_list, identifier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err >=3D0 || err !=3D -ENO=
ENT)
>
> Put a space after '>=3D'.
>
> Could you resubmit with these fixes?
>

Thanks for review, I will resubmit the patch shortly :)

Regards,
Margarita
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
