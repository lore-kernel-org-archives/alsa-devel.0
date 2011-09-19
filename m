From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sn95031: Staticize
	sn95031_pcm_hw_params
Date: Mon, 19 Sep 2011 10:26:25 +0100
Message-ID: <CABS+qY2OXP8Uaz0P2fAaie5643ajNbvq+7D1yX7hHF=cTAZ5VA@mail.gmail.com>
References: <1316421268.23109.1.camel@phoenix>
	<1316421320.26662.5.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 048B62498D
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 11:26:26 +0200 (CEST)
Received: by mail-qw0-f47.google.com with SMTP id 6so5485589qwh.6
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 02:26:26 -0700 (PDT)
In-Reply-To: <1316421320.26662.5.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Axel Lin <axel.lin@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <harshapriya@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19 September 2011 09:35, Vinod Koul <vinod.koul@linux.intel.com> wrote:

> On Mon, 2011-09-19 at 16:34 +0800, Axel Lin wrote:
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> > ---
> >  sound/soc/codecs/sn95031.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
> > index b4f1cb4..29945b0 100644
> > --- a/sound/soc/codecs/sn95031.c
> > +++ b/sound/soc/codecs/sn95031.c
> > @@ -658,7 +658,7 @@ static int sn95031_pcm_spkr_mute(struct snd_soc_dai
> *dai, int mute)
> >       return 0;
> >  }
> >
> > -int sn95031_pcm_hw_params(struct snd_pcm_substream *substream,
> > +static int sn95031_pcm_hw_params(struct snd_pcm_substream *substream,
> >               struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> >  {
> >       unsigned int format, rate;
>
> Acked-by: Vinod Koul <vinod.koul@linux.intel.com>
>
> --
> ~Vinod
>
>
Acked-by: Liam Girdwood <lrg@ti.com>
