From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH] ASoC: Fix long name of control for
	dapm_switch
Date: Fri, 6 Mar 2009 09:02:16 +0900
Message-ID: <4e1455be0903051602r198fd9a2gc5bde0ffd9ac8c0d@mail.gmail.com>
References: <4e1455be0903031747s65097766saea220037d1335ff@mail.gmail.com>
	<20090305172624.GH2416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F23F10386C
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 01:02:17 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so198960wfd.23
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 16:02:16 -0800 (PST)
In-Reply-To: <20090305172624.GH2416@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Unfortunately your patch doesn't apply against the current topic/asoc
> branch of Takashi's repository, I've implemented a slightly different
> version of it.
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name_len =3D strlen(w->kco=
ntrols[i].name) + 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w->id =3D=3D snd_soc_d=
apm_mixer)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name_len +=
=3D 1 + strlen(w->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w->id =3D=3D snd_soc_d=
apm_mixer_named_ctl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name_len =
=3D strlen(w->kcontrols[i].name) + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name_len =
=3D 2 + strlen(w->name)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 + strlen(w->kcontrols[i].name);
>
> Here I just changed the test to !=3D named_ctl.

ok, i will resend the patch.

>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (w->id) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case snd_soc_dapm_mixer:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>
> Your chanegs here appear to only flip to an if/else from a switch
> statement? =A0Please mention things like this in your commit logs (or
> split them into separate patches) - it makes your changes easier to
> review.

I think that a switch statement is used unnecessarily because this part has
only to check whether w->id is named_ctl.
ok, i will send them into splited patches.
Thanks.


-- =

- Joonyoung Shim
