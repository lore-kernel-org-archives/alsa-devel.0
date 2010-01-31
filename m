From: Louise Hoffman <louise.hoffman@gmail.com>
Subject: Re:
	=?windows-1252?q?Warning/error_from_ALSA=92s_pcm=5Fm?=
	=?windows-1252?q?in=2Ec_example=2E_Possible_problem=3F?=
Date: Sun, 31 Jan 2010 21:53:33 +0100
Message-ID: <30c82f5f1001311253q265c7634g1f5a6070db284922@mail.gmail.com>
References: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
	<4f3252891001302043n3a404f1awdd8a7bef9769eb5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F8F02447A
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 21:53:35 +0100 (CET)
Received: by ewy21 with SMTP id 21so1635129ewy.22
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 12:53:34 -0800 (PST)
In-Reply-To: <4f3252891001302043n3a404f1awdd8a7bef9769eb5a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> The correct way is to use snd_pcm_get_params() to get buffer_size and
> period_size
>
> *snd_pcm_set_params() has limitation
>
> The most common sound card (e.g. HDA ) has the following constraints
> on period bytes and buffer bytes
>
> =A0 =A0 snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_=
BYTES,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012=
8);
> =A0 =A0 snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_=
BYTES,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 128);

I am probably not good enough to understand these changes =3D( Pretty
hard core stuff =3D)


> you cannot get exactly 0.5 second period time when rate is multiple of 3 (
> e.g. 48000 Hz )

Does this mean, that I shouldn't give snd_pcm_writei() the number of
all the frames in the buffer, but only

sample_rate * latency =3D frames

?

So if I e.g. have:
sample_rate =3D 44100
latency =3D 0.5 [s]
all_frames =3D 100000

The number of frames that I should give to snd_pcm_writei() would be

sample_rate * latency =3D frames
44100*0.5 =3D 22050

and the number of iterations the for-loop should be?:

(int) 100000/22050 =3D 4; with frames=3D22050

and one extra, but only with

100000 mod 22050 =3D 11800

frames?
