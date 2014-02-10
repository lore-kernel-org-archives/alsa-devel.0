From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_1/2=5D_ASoC=3A_fsl=3A_Separation_?=
 =?utf-8?q?of_the_main_audio_options_and_boards?=
Date: Mon, 10 Feb 2014 10:29:03 +0400
Message-ID: <1392013743.262980234@f144.i.mail.ru>
References: <1391621512-15064-1-git-send-email-shc_work@mail.ru>
 <20140210055357.GE9628@S2101-09.ap.freescale.net>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f144.i.mail.ru (f144.i.mail.ru [128.140.171.240])
 by alsa0.perex.cz (Postfix) with ESMTP id EA6902610B7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 07:29:06 +0100 (CET)
In-Reply-To: <20140210055357.GE9628@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>
Cc: =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.de>, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>, =?UTF-8?B?Tmljb2xpbiBDaGVu?= <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hello.

> On Wed, Feb 05, 2014 at 09:31:51PM +0400, Alexander Shiyan wrote:
> > This patch provide separation of the main audio options and boards.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  sound/soc/fsl/Kconfig | 36 ++++++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
...
> >  if SND_IMX_SOC
> >  
> >  config SND_SOC_IMX_SSI
> > @@ -122,12 +133,7 @@ config SND_SOC_IMX_PCM_FIQ
> >  	tristate
> >  	select FIQ
> 
> Hmm, why do you choose to have SND_SOC_IMX_SSI and SND_SOC_IMX_PCM_FIQ
> still stay in board section?

SND_SOC_IMX_SSI is used for ATAGS boards only, and selected for each individual
platform driver, so there are no need to select this option especially.

For SND_SOC_IMX_PCM_FIQ I just not imagine yet how to describe this option
in Kconfig ;) In any case, it can be done later if the total change concept looks good.

Thanks.

---
