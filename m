From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 21 Oct 2011 14:07:40 +0530
Message-ID: <1319186260.24621.154.camel@matrix>
References: <1319121769.24621.130.camel@matrix>
	<CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id D6E21103A8A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 10:26:32 +0200 (CEST)
In-Reply-To: <CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-10-20 at 18:10 +0100, Girdwood, Liam wrote:
> On 20 October 2011 15:42, Ashish Chavan <ashish.chavan@kpitcummins.com> wrote:
> > DA7210 has three line outputs. OUT1 Left, OUT1 Right and OUT2 (mono).
> > This patch adds support for gain controls for these three line outs.
> > It also adds support for overall DAC gain control.
> >
> > Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
> > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > ---
> > Changes since v1:
> > - Removed explicit setting of default gains
> > - Renamed "DAC Playback" to "Digital Playback"
> > ---
> >  sound/soc/codecs/da7210.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 42 insertions(+), 0 deletions(-)
> >
> 
> >
> > +       /* Enable Line out amplifiers */
> > +       snd_soc_write(codec, DA7210_OUT1_L, DA7210_OUT1_L_EN);
> > +       snd_soc_write(codec, DA7210_OUT1_R, DA7210_OUT1_R_EN);
> > +       snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
> > +                    DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
> > +
> 
> Any reason for not using DAPM here ? Otherwise they are always on
> making your chip burn mW.....
> 

Not really. As explained in the comment in DAPM patch, this enables will
be effective (burn mW) only after respective IO is taken out from
STANDBY mode. DAPM takes care of managing STANDBY mode for all IOs and
ADC/DAC. I know this way of handling low power mode is bit non-trivial,
but it is what is recommended by chip designers. Actually Mark was also
initially confused with this and requested to put enough documentation
into code. After that I tried explaining the logic in source code
comment in DAPM patch. Let me know if it is not clear and doesn't convey
clearly what is should.

Thanks,

-- Ashish (GNU FAN)
