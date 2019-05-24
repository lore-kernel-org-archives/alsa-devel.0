From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/5] ASoC: madera: Add common support for
 Cirrus Logic Madera codecs
Date: Fri, 24 May 2019 16:24:10 +0100
Message-ID: <ae5eee88-0b79-1e58-5812-9e46e5bf3b75@opensource.cirrus.com>
References: <20190524104158.30731-1-ckeepax@opensource.cirrus.com>
 <20190524104158.30731-2-ckeepax@opensource.cirrus.com>
 <20190524145603.GE2456@sirena.org.uk>
 <2f4ab4ff-5b1e-8ef5-3ef7-8dfe413b4b95@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21243F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 17:24:18 +0200 (CEST)
In-Reply-To: <2f4ab4ff-5b1e-8ef5-3ef7-8dfe413b4b95@opensource.cirrus.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On 24/05/19 16:21, Richard Fitzgerald wrote:
> On 24/05/19 15:56, Mark Brown wrote:
>> On Fri, May 24, 2019 at 11:41:55AM +0100, Charles Keepax wrote:
>>
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Just read a register a few times to ensure the internal
>>> +=A0=A0=A0=A0 * oscillator sends out a few clocks.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 for (i =3D 0; i < 4; i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(madera->regmap, MADERA_SOFTW=
ARE_RESET, &val);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (ret)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(madera->dev,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "%s Failed to read regis=
ter: %d (%d)\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __func__, ret, i);
>>
>> Why use %s to format the __func__ rather than just concatenate?
> =

> GCC docs say that it's a magic variable so cannot be concatenated with st=
ring literals. Though I
> never tried concatenation to see if it works.
> =

>>
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 udelay(300);
>>
>> So we read the register a few times then add a few hundred us of delay
>> after?=A0 Surely that delay is going to be negligable compared to the ti=
me
>> spent on I/O?
> =

> The register reads are to create clock cycles in the silicon, not to gene=
rate delay.
> =


Sorry, just re-read your comment and realized I'd misread it. It's a hardwa=
re requirement
that after generating the internal clocks there must be a delay. I.e. we re=
quire a combination
of a guaranteed number of SYSCLKs followed by a guaranteed minimum delay.

>>
>>> +int madera_sysclk_ev(struct snd_soc_dapm_widget *w,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct snd_kcontrol *kcontrol, in=
t event)
>>> +{
>>> +=A0=A0=A0 struct snd_soc_component *component =3D snd_soc_dapm_to_comp=
onent(w->dapm);
>>> +=A0=A0=A0 struct madera_priv *priv =3D snd_soc_component_get_drvdata(c=
omponent);
>>> +
>>> +=A0=A0=A0 madera_spin_sysclk(priv);
>>> +
>>> +=A0=A0=A0 return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(madera_sysclk_ev);
>>
>> This will delay both before and after every power up and power down.
>> Are you sure that makes sense?
>>
> =

> I think that's correct but we can re-check with hardware people. It's not=
 just a delay,
> it needs to ensure there are always a certain number of SYSCLK cycles in =
the hardware to
> avoid leaving certain state machines in limbo.
> =

>>> +
>>> +=A0=A0=A0 ret =3D madera_check_speaker_overheat(madera, &warn, &shutdo=
wn);
>>> +=A0=A0=A0 if (ret)
>>> +=A0=A0=A0=A0=A0=A0=A0 shutdown =3D true; /* for safety attempt to shut=
down on error */
>>> +
>>> +=A0=A0=A0 if (shutdown) {
>>> +=A0=A0=A0=A0=A0=A0=A0 dev_crit(madera->dev, "Thermal shutdown\n");
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(madera->regmap,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MADERA_OU=
TPUT_ENABLES_1,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MADERA_OU=
T4L_ENA |
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MADERA_OU=
T4R_ENA, 0);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (ret !=3D 0)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_crit(madera->dev,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed to disable sp=
eaker outputs: %d\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret);
>>> +=A0=A0=A0 } else if (warn) {
>>> +=A0=A0=A0=A0=A0=A0=A0 dev_crit(madera->dev, "Thermal warning\n");
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 return IRQ_HANDLED;
>>
>> We will flag the interrupt as handled if there was neither a warning nor
>> a critical overheat?=A0 I'd expect some warning about a spurious interru=
pt
>> at least.
>>
>>> +static int madera_get_variable_u32_array(struct madera_priv *priv,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const cha=
r *propname,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 *dest,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int n_max,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int multi=
ple)
>>> +{
>>> +=A0=A0=A0 struct madera *madera =3D priv->madera;
>>> +=A0=A0=A0 int n, ret;
>>> +
>>> +=A0=A0=A0 n =3D device_property_read_u32_array(madera->dev, propname, =
NULL, 0);
>>> +=A0=A0=A0 if (n =3D=3D -EINVAL) {
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;=A0=A0=A0 /* missing, ignore */
>>> +=A0=A0=A0 } else if (n < 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 dev_warn(madera->dev, "%s malformed (%d)\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 propname, n);
>>> +=A0=A0=A0=A0=A0=A0=A0 return n;
>>> +=A0=A0=A0 } else if ((n % multiple) !=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 dev_warn(madera->dev, "%s not a multiple of %d e=
ntries\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 propname, multiple);
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 if (n > n_max)
>>> +=A0=A0=A0=A0=A0=A0=A0 n =3D n_max;
>>> +
>>> +=A0=A0=A0 ret =3D device_property_read_u32_array(madera->dev, propname=
, dest, n);
>>> +
>>> +=A0=A0=A0 if (ret < 0)
>>> +=A0=A0=A0=A0=A0=A0=A0 return ret;
>>> +=A0=A0=A0 else
>>> +=A0=A0=A0=A0=A0=A0=A0 return n;
>>> +}
>>
>> This feels like it should perhaps be a generic OF helper function -
>> there's nothing driver specific I'm seeing here and arrays that need to
>> be a multiple of N entries aren't that uncommon I think.
>>
>>> +=A0=A0=A0 mutex_lock(&priv->rate_lock);
>>> +=A0=A0=A0 cached_rate =3D priv->adsp_rate_cache[adsp_num];
>>> +=A0=A0=A0 mutex_unlock(&priv->rate_lock);
>>
>> What's this lock protecting?=A0 The value can we read can change as soon
>> as the lock is released and we're just reading a single word here rather
>> than traversing a data structure that might change under us or
>> something.
>>
>>> +void madera_destroy_bus_error_irq(struct madera_priv *priv, int dsp_nu=
m)
>>> +{
>>> +=A0=A0=A0 struct madera *madera =3D priv->madera;
>>> +
>>> +=A0=A0=A0 madera_free_irq(madera,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 madera_dsp_bus_error_irqs[dsp_num],
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &priv->adsp[dsp_num]);
>>> +}
>>> +EXPORT_SYMBOL_GPL(madera_destroy_bus_error_irq);
>>
>> We use free rather than destroy normally?
>>
>>> +static const char * const madera_dfc_width_text[MADERA_DFC_WIDTH_ENUM_=
SIZE] =3D {
>>> +=A0=A0=A0 "8bit", "16bit", "20bit", "24bit", "32bit",
>>> +};
>>
>> Spaces might make these more readable.
>>
>>> +static void madera_sleep(unsigned int delay)
>>> +{
>>> +=A0=A0=A0 if (delay < 20) {
>>> +=A0=A0=A0=A0=A0=A0=A0 delay *=3D 1000;
>>> +=A0=A0=A0=A0=A0=A0=A0 usleep_range(delay, delay + 500);
>>> +=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0 msleep(delay);
>>> +=A0=A0=A0 }
>>> +}
>>
>> This feels like it might make sense as a helper function as well - I
>> could've sworn there was one already but I can't immediately find it.
>>
> =
