From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
Date: Sun, 10 Jul 2011 16:36:44 +0800
Message-ID: <CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-4-git-send-email-b29396@freescale.com>
	<20110709030008.GD26900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110709030008.GD26900@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 08, 2011 at 11:59:43PM +0800, Dong Aisheng wrote:
>> The driver only supports playback firstly.
>
> Once more, *always* CC maintainers.
Got it.

>> +struct mxs_audio_platform_data {
>> + =A0 =A0 int sysclk;
>> +
>> + =A0 =A0 int (*init) (void); =A0 =A0 /* board specific init */
>> + =A0 =A0 int (*finit) (void); =A0 =A0/* board specific finit */
>
> Eh? =A0Your machine driver is already entirely board specific...
Still not.
It's originally used for some board's codec that do not need SAIF to
provide mclk.
I will remove it if we still do not need it to make the things simply.

>> + =A0 =A0 /* The SAIF clock should be either 512*fs or 384*fs */
>> + =A0 =A0 card_priv.sysclk =3D 512 * rate;
>> + =A0 =A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, MXS_SAIF_SYS_CLK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_priv.sysclk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_CLOCK_OUT);
>
> Why are you storing the sysclk? =A0You never reference it again and
> you're using different sysclks for everything in the system.
Yes, it may not really need to store it in this version of code.
I will change this part of clock setting in the next patch.

>> + =A0 =A0 /* set SGTL5000_SYSCLK as 256*fs to support 96k sample rate */
>> + =A0 =A0 snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, 256 * rate,=
 0);
>> +
>> + =A0 =A0 /* The MCLK output rate is 256*fs */
>> + =A0 =A0 snd_soc_dai_set_clkdiv(cpu_dai, MXS_SAIF_MCLK, 256);
>
> Why are you not checking errors on these?
Will add it.

>> +static int mxs_sgtl5000_soc_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> + =A0 =A0 /* TBD: add dapm widgets */
>> +
>> + =A0 =A0 return 0;
>> +}
>
> Remove empty functions.
Will do that.

>> +static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct mxs_audio_platform_data *plat =3D pdev->dev.platform_da=
ta;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 card_priv.pdev =3D pdev;
>> +
>> + =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 if (plat && plat->init && plat->init())
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> You're not calling snd_soc_register_card()...
>
>> + =A0 =A0 mxs_sgtl5000_snd_device =3D platform_device_alloc("soc-audio",=
 -1);
>> + =A0 =A0 if (!mxs_sgtl5000_snd_device)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>
> ...and you're using both a platform device and soc-audio to instantate
> which is a bit confused. =A0New code should not be using soc-audio.
Thanks for reminder.
I will change this part of code to following the new rule.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
