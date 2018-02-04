From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Sun, 4 Feb 2018 16:42:13 +0200
Message-ID: <CAEnQRZAJ0RmCcG76nKjvVj_JGa+N5U2h4SCmFXDAGveE82ewfw@mail.gmail.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
 <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
 <20180202231102.GA2705@sirena.org.uk>
 <CAHp75Vdadii=judzHp_Wt-Yn7Ozyn2ybAKCtWAj=KtyHRsUucw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AFB6266D06
 for <alsa-devel@alsa-project.org>; Sun,  4 Feb 2018 15:42:14 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id v71so21119242wmv.2
 for <alsa-devel@alsa-project.org>; Sun, 04 Feb 2018 06:42:14 -0800 (PST)
In-Reply-To: <CAHp75Vdadii=judzHp_Wt-Yn7Ozyn2ybAKCtWAj=KtyHRsUucw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Mihai Serban <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Mihai Serban <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 4, 2018 at 4:31 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Feb 3, 2018 at 1:11 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Feb 02, 2018 at 09:33:18PM +0200, Andy Shevchenko wrote:
>>> On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>>
>>> > +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
>>> > +{
>>> > +       struct snd_soc_codec *codec = dai->codec;
>>> > +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
>>>
>>> > +       int ndt = 0;
>>>
>>> It might be even
>>>
>>>       int ndt = max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);
>>
>> Please don't encourage people to use the ternery operator like that, it
>> does nothing for legibility not to write out the conditionals.
>
> Noted.
>
>>> > +static const struct i2c_device_id ak5558_i2c_id[] = {
>>> > +       { "ak5558", 0 },
>>> > +       { }
>>> > +};
>>> > +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);
>>
>>> I dunno if it's really helpful to have. Though it's up to Mark and you.
>>
>> I don't care either way.
>
> Since Mark is okay with either, I would rather switch to ->probe_new()
> and remove above table.

Sure, will do. I forgot to put it in v1.
