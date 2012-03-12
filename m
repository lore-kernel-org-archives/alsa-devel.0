From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 16:43:14 +0100
Message-ID: <CACKLOr0oFVCUNdjv7crU=15NC0YDm4og5zUWKL=w7b46NVEaGA@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
	<CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
	<CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
	<CACKLOr0x3cGGLc7vF4gyP1XCBSJkOR1S3P2eYuuhJZ+EmX8zPQ@mail.gmail.com>
	<CAOMZO5C4w151sFUGzawwcnhApe4bvrQ5wLKXcBBaq_qUBG=61A@mail.gmail.com>
	<CAOMZO5AGJn6Z6O3_=nQ8mz2YJ9twntPsTe41vH13exQsceA1wg@mail.gmail.com>
	<CACKLOr09dAaRohcUwU8nQkC+vaid86um+3w=cEUb2MDbfe3uXw@mail.gmail.com>
	<CAOMZO5DQ3AQAc_sot-5k2jLmn5W25uN5=o4ybymX3-EGhZh9KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C3F124386
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 16:43:18 +0100 (CET)
Received: by eaak11 with SMTP id k11so1053988eaa.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 08:43:15 -0700 (PDT)
In-Reply-To: <CAOMZO5DQ3AQAc_sot-5k2jLmn5W25uN5=o4ybymX3-EGhZh9KA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 12 March 2012 16:23, Fabio Estevam <festevam@gmail.com> wrote:
> On 3/12/12, javier Martin <javier.martin@vista-silicon.com> wrote:
>> I get the following error when testing your patch in linux-next =A0maste=
r:
>>
>>
>> ASoC: Platform device allocation failed
>> mx27vis mx27vis.0: snd_soc_register_card failed (-22)
>> mx27vis: probe of mx27vis.0 failed with error -22
>> ALSA device list:
>> =A0 No soundcards found.
>
> Thanks for testing it. I missed one line.
>
> Could you please add the following line:
>
> mx27vis_aic32x4.dev =3D &pdev->dev;
>
> prior to
>
> ret =3D snd_soc_register_card(&mx27vis_aic32x4);
>
> and let me know if it works?
>
> Then I will submit a new version of the patch.
>
> Thanks,
>
> Fabio Estevam

Yeah, that works.

Tested-by: Javier Martin


-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
