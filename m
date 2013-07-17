From: Diego Sueiro <diego.sueiro@gmail.com>
Subject: Re: Sound Card driver for audio codec, mux and dsp.
Date: Wed, 17 Jul 2013 14:24:09 -0300
Message-ID: <CAMCfZKHSfaph5OTjx7FM9-sW-_KPFraA531Q4NzG3Ocrd++odg@mail.gmail.com>
References: <CAMCfZKGJYKvnToaSMp6TEHyOHEa4u5+vwSk4EMQvKiNbzVyT7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 466512654E6
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 19:24:31 +0200 (CEST)
Received: by mail-ie0-f175.google.com with SMTP id a11so4544255iee.6
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 10:24:30 -0700 (PDT)
In-Reply-To: <CAMCfZKGJYKvnToaSMp6TEHyOHEa4u5+vwSk4EMQvKiNbzVyT7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there,

Looking at documentation and some code I realized that I need to
follow Alsa SoC layer implementation.

It already has an ASoC driver for sgtl5000 and imx platform.
So, I want to add more two devices, an audio mux and an audio dsp. How
can I accomplish this?


Abra=E7os,

--
*dS
Diego Sueiro

Administrador do Portal Embarcados
www.embarcados.com.br

Engenheiro de Controle e Automa=E7=E3o
UNIVERSIDADE FEDERAL DE ITAJUB=C0

/*long live rock 'n roll*/


On Wed, Jul 17, 2013 at 10:17 AM, Diego Sueiro <diego.sueiro@gmail.com> wro=
te:
> Hi there,
>
> I need to develop a solution to expose to userspace a single sound
> card with mixer controls for:
>
> Audio codec : sgtl5000
> Audio mux: used to select an audio source on sgtl5000 LINE_IN.
> Audio dsp :sta309a
>
> How can I implement this drivers? Should I have to create a sound-card
> driver which is going to register and control the other drivers
> (codec, mux, dsp)?
>
> Is there some device driver or tutorial guide that I can use as an exampl=
e?
>
> I'm using the kernel 3.0.15 from Freescale [1].
>
>
> [1] - http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=
=3Dimx_3.0.15_android
>
> Kind Regards,
>
> --
> *dS
> Diego Sueiro
