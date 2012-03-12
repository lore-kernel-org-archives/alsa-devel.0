From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 12:23:56 -0300
Message-ID: <CAOMZO5DQ3AQAc_sot-5k2jLmn5W25uN5=o4ybymX3-EGhZh9KA@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
	<CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
	<CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
	<CACKLOr0x3cGGLc7vF4gyP1XCBSJkOR1S3P2eYuuhJZ+EmX8zPQ@mail.gmail.com>
	<CAOMZO5C4w151sFUGzawwcnhApe4bvrQ5wLKXcBBaq_qUBG=61A@mail.gmail.com>
	<CAOMZO5AGJn6Z6O3_=nQ8mz2YJ9twntPsTe41vH13exQsceA1wg@mail.gmail.com>
	<CACKLOr09dAaRohcUwU8nQkC+vaid86um+3w=cEUb2MDbfe3uXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E93424354
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 16:23:58 +0100 (CET)
Received: by eeke50 with SMTP id e50so1066580eek.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 08:23:56 -0700 (PDT)
In-Reply-To: <CACKLOr09dAaRohcUwU8nQkC+vaid86um+3w=cEUb2MDbfe3uXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 3/12/12, javier Martin <javier.martin@vista-silicon.com> wrote:
> I get the following error when testing your patch in linux-next  master:
>
>
> ASoC: Platform device allocation failed
> mx27vis mx27vis.0: snd_soc_register_card failed (-22)
> mx27vis: probe of mx27vis.0 failed with error -22
> ALSA device list:
>   No soundcards found.

Thanks for testing it. I missed one line.

Could you please add the following line:

mx27vis_aic32x4.dev = &pdev->dev;

prior to

ret = snd_soc_register_card(&mx27vis_aic32x4);

and let me know if it works?

Then I will submit a new version of the patch.

Thanks,

Fabio Estevam
