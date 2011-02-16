From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
 support
Date: Thu, 17 Feb 2011 02:01:03 +0800
Message-ID: <20110216180103.GA21063@ubuntu.localdomain>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	<87k4gzq2no.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id F0E102434C
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 03:07:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87k4gzq2no.fsf@lechat.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed 2011-02-16 19:01:47, Arnaud Patard wrote:
> <zhaoming.zeng@freescale.com> writes:
> 
> Hi,
> 
> > From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> >
> > Add Freescale SGTL5000 codec support
> >
> > Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> > ---
> > changes since v2:
> > 1. clean up register default values
> > 2. rewrite codec power up code, add sgtl5000_set_power_regs()
> > 3. rewrite codec clock configure code sgtl5000_set_clock()
> > 4. reimplement PM hooks, restore register by particular order.
> > 5. clean up dapm code, remove dac and adc event hooks.
> > 6. clean up codec private structure, remove unnecessary fields.
> > 7. add comments for uncommon code.
> >
> > Thanks for Mark's review.
> > ---
> >  sound/soc/codecs/Kconfig    |    4 +
> >  sound/soc/codecs/Makefile   |    1 +
> >  sound/soc/codecs/sgtl5000.c | 1229 +++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/sgtl5000.h |  403 ++++++++++++++
> >  4 files changed, 1637 insertions(+), 0 deletions(-)
> >
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index c48b23c..57b909a 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -32,6 +32,7 @@ config SND_SOC_ALL_CODECS
> >  	select SND_SOC_MAX98088 if I2C
> >  	select SND_SOC_MAX9877 if I2C
> >  	select SND_SOC_PCM3008
> > +	select SND_SOC_SGTL5000 if I2C
> >  	select SND_SOC_SPDIF
> >  	select SND_SOC_SSM2602 if I2C
> >  	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
> > @@ -176,6 +177,9 @@ config SND_SOC_MAX98088
> >  config SND_SOC_PCM3008
> >         tristate
> >  
> > +config SND_SOC_SGTL5000
> > +	tristate
> > +
> >  config SND_SOC_SPDIF
> >  	tristate
> >  
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 579af9c..78e36cc 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -18,6 +18,7 @@ snd-soc-dmic-objs := dmic.o
> >  snd-soc-l3-objs := l3.o
> >  snd-soc-max98088-objs := max98088.o
> >  snd-soc-pcm3008-objs := pcm3008.o
> > +snd-soc-sgtl5000-objs := sgtl5000.o
> >  snd-soc-alc5623-objs := alc5623.o
> >  snd-soc-spdif-objs := spdif_transciever.o
> >  snd-soc-ssm2602-objs := ssm2602.o
> 
> you're actually missing something like :
> obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
>
my mistake, I test it on 2.6.37 branch, forget to merge this line.
> 
> > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > new file mode 100644
> > index 0000000..2646ecb
> > --- /dev/null
> > +++ b/sound/soc/codecs/sgtl5000.c
> 
> [...]
> 
> > +static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
> > +				   enum snd_soc_bias_level level)
> > +{
> > +	int i;
> > +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +	case SND_SOC_BIAS_PREPARE:
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +		if (codec->bias_level == SND_SOC_BIAS_OFF) {
> 
> I don't see a member 'bias_level' in snd_soc_codec in the trees I have
> on my drive. Which tree did you use ?
I will check the ASoC changes of 2.6.38, and rebase to it.
> 
> > +			for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> > +				if (!sgtl5000->supplies[i])
> > +					continue;
> > +				regulator_enable(sgtl5000->supplies[i]);
> > +			}
> > +		}
> > +		break;

.....

> > +static int sgtl5000_remove(struct snd_soc_codec *codec)
> > +{
> > +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> > +	int i;
> > +
> > +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > +
> > +	snd_soc_dapm_free(codec);
> 
> same here.
> 
> [...]
> 
> Arnaud
>
Thanks.
