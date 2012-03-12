From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 10:29:44 -0300
Message-ID: <CAOMZO5AGJn6Z6O3_=nQ8mz2YJ9twntPsTe41vH13exQsceA1wg@mail.gmail.com>
References: <1331499423-9761-1-git-send-email-festevam@gmail.com>
	<CACKLOr2j-Apnno+-h6B6Rax2-H7ZTuQ=RzyeyB7pOsqJ=xUJuA@mail.gmail.com>
	<CAOMZO5BkK0m8vhH8i1x2f049YUT0_4OOiOXrGL5pPUzMo9p8xA@mail.gmail.com>
	<CACKLOr0x3cGGLc7vF4gyP1XCBSJkOR1S3P2eYuuhJZ+EmX8zPQ@mail.gmail.com>
	<CAOMZO5C4w151sFUGzawwcnhApe4bvrQ5wLKXcBBaq_qUBG=61A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E0B1610409B
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 14:29:44 +0100 (CET)
Received: by eaak11 with SMTP id k11so897824eaa.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 06:29:44 -0700 (PDT)
In-Reply-To: <CAOMZO5C4w151sFUGzawwcnhApe4bvrQ5wLKXcBBaq_qUBG=61A@mail.gmail.com>
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

On 3/12/12, Fabio Estevam <festevam@gmail.com> wrote:
> On 3/12/12, javier Martin <javier.martin@vista-silicon.com> wrote:
>
>> Could you please provide a git repository and a branch for me to test
>> this patch?
>
> Please apply this patch against linux-next git tree.

You also need this patch:
http://comments.gmane.org/gmane.linux.drivers.video-input-infrastructure/45617

Otherwise linux-next does not build for mx27.

Regards,

Fabio Estevam
