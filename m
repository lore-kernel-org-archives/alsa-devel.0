From: Margarita Olaya <magi@slimlogic.co.uk>
Subject: Re: [PATCHv4] alsa-lib: ucm: allow values to be read
 from devices
Date: Fri, 18 Mar 2011 11:45:57 -0600
Message-ID: <AANLkTikUSCgGdf55tdpNoN1XZajo0-MexuxGOaAi7oBR@mail.gmail.com>
References: <AANLkTiki7pTTJcJBtMq71=53GW9Xf8VQh6w9EWOaF=_b@mail.gmail.com>
	<s5hipvgs53l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 05A99103A07
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 18:46:07 +0100 (CET)
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by slimlogic.co.uk (Postfix) with ESMTPSA id F372D1304BC
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 17:45:58 +0000 (GMT)
Received: by vxi40 with SMTP id 40so3729238vxi.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:45:58 -0700 (PDT)
In-Reply-To: <s5hipvgs53l.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2011 at 11:36 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 18 Mar 2011 11:26:22 -0600,
> Margarita Olaya wrote:
>>
>> This allows devices value to be read using the get_value().
>> Also fix a little formatting.
>>
>> Signed-off-by: Margarita Olaya Cabrera <magi@slimlogic.co.uk>
>> Acked-by: Liam Girdwood <lrg@ti.com>
>
> Committed now. =A0Thanks.
>

Thanks :)

>
> Takashi
>
>> ---
>> =A0src/ucm/main.c | =A0 21 ++++++++++++++-------
>> =A01 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/ucm/main.c b/src/ucm/main.c
>> index 42fd373..88f8bf6 100644
>> --- a/src/ucm/main.c
>> +++ b/src/ucm/main.c
>> @@ -1059,24 +1059,31 @@ static int get_value3(const char **value,
>> =A0 * \param uc_mgr Use case manager
>> =A0 * \param identifier Value identifier (string)
>> =A0 * \param value Returned value string
>> - * \param modifier modifier name (string)
>> + * \param item Modifier or Device name (string)
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
>> =A0{
>> - =A0 =A0 =A0 =A0struct use_case_modifier *mod;
>> + =A0 =A0 struct use_case_modifier *mod;
>> + =A0 =A0 struct use_case_device *dev;
>> =A0 =A0 =A0 int err;
>>
>> - =A0 =A0 if (modifier !=3D NULL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 mod =3D find_modifier(uc_mgr, modifier);
>> + =A0 =A0 if (item !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mod =3D find_modifier(uc_mgr, item);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mod !=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_value1(value, &m=
od->value_list, identifier);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err >=3D 0 || err !=3D -=
ENOENT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev =3D find_device(uc_mgr->active_verb, item);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_value1(value, &dev=
->value_list, identifier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err >=3D 0 || err !=3D -EN=
OENT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 err =3D get_value1(value, &uc_mgr->active_verb->value_list, =
identifier);
>> =A0 =A0 =A0 if (err >=3D 0 || err !=3D -ENOENT)
>> --
>> 1.7.0.4
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
