From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 7/7] M-Audio Fast Track Ultra: Add effect
	controls
Date: Mon, 23 Apr 2012 18:07:40 +0200
Message-ID: <CAFz=ag5qozGLiJqUHgT5DMXZp2=fZVdZqoHcLKbCoNeCgVDyfg@mail.gmail.com>
References: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
	<1335191857-6725-8-git-send-email-linuxaudio@showlabor.de>
	<s5hfwbu5vpi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hfwbu5vpi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

Hi again,

2012/4/23 Takashi Iwai <tiwai@suse.de>:
>>
>> - =A0 =A0 static char *texts[8] =3D {"Room 1",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Room 2",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Room 3",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Hall 1",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Hall 2",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Plate",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Delay",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Echo"
>> + =A0 =A0 static const char *texts[8] =3D {"Room 1",
>
> Write it in the first place in that way.

Sure, would be better.

>
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Room 2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Room 3",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Hall 1",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Hall 2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Plate",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Delay",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Echo"
>> =A0 =A0 =A0 };
>>
>> =A0 =A0 =A0 uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
>> @@ -614,6 +614,13 @@ static int snd_ftu_eff_switch_get(struct snd_kcontr=
ol *kctl,
>> =A0 =A0 =A0 int err;
>> =A0 =A0 =A0 unsigned char value[2];
>>
>> + =A0 =A0 const int id =3D 6;
>> + =A0 =A0 const int validx =3D 1;
>> + =A0 =A0 const int val_len =3D 2;
>> +
>> + =A0 =A0 value[0] =3D 0x00;
>> + =A0 =A0 value[1] =3D 0x00;
>> +
>> =A0 =A0 =A0 pval =3D (struct snd_ftu_eff_switch_priv_val *)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kctl->private_value;
>>
>> @@ -630,14 +637,6 @@ static int snd_ftu_eff_switch_get(struct snd_kcontr=
ol *kctl,
>> =A0 =A0 =A0 if (snd_BUG_ON(!chip))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 const int id =3D 6;
>> - =A0 =A0 const int validx =3D 1;
>> - =A0 =A0 const int val_type =3D USB_MIXER_S16;
>
> Ditto. =A0Not good to fix something in a later patch if you already know
> it should be fixed.

If I had known I would have done...

Regards,

Felix
