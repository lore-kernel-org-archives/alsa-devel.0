From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH 2/4] ASoC: SAMSUNG: Add I2S0 internal dma
 driver
Date: Fri, 10 Jun 2011 08:31:08 +0900
Message-ID: <04bc01cc26fd$501d4a60$f057df20$@com>
References: <1307606950-8310-1-git-send-email-sbkim73@samsung.com>
	<1307606950-8310-3-git-send-email-sbkim73@samsung.com>
	<4DF09782.1090901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id B58F424333
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 01:31:15 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LMJ00FFJQNY8S70@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 10 Jun 2011 08:31:10 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LMJ00I0FQNXXQ@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 10 Jun 2011 08:31:10 +0900 (KST)
In-reply-to: <4DF09782.1090901@ti.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, jassisinghbrar@gmail.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


On 09/06/11 18:51, Liam Girdwood wrote:
> 
> Looks fine to me, but needs one fix before it can be applied.
> 
> Acked-by: Liam Girdwood <lrg@ti.com>
> 
> > ---
> >  sound/soc/samsung/Makefile |    2 +
> >  sound/soc/samsung/idma.c   |  492
> ++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/samsung/idma.h   |   28 +++
> >  3 files changed, 522 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/soc/samsung/idma.c
> >  create mode 100644 sound/soc/samsung/idma.h
> >
> 
> snip
> 
> > +
> > +static int idma_new(struct snd_card *card,
> > +       struct snd_soc_dai *dai, struct snd_pcm *pcm)
> > +{
> 
> This call API has changed in -next.

OK, I will check -next and will apply it.

Thanks and regards,
SB Kim
