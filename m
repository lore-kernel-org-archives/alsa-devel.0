From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for AK5558 ADC driver
Date: Sun, 4 Feb 2018 16:31:50 +0200
Message-ID: <CAHp75Vdadii=judzHp_Wt-Yn7Ozyn2ybAKCtWAj=KtyHRsUucw@mail.gmail.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com> <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
 <20180202231102.GA2705@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180202231102.GA2705-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, "S.j. Wang" <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>, Mihai Serban <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cosmin Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>, dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 3, 2018 at 1:11 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Feb 02, 2018 at 09:33:18PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org> wrote:
>
>> > +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
>> > +{
>> > +       struct snd_soc_codec *codec = dai->codec;
>> > +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
>>
>> > +       int ndt = 0;
>>
>> It might be even
>>
>>       int ndt = max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);
>
> Please don't encourage people to use the ternery operator like that, it
> does nothing for legibility not to write out the conditionals.

Noted.

>> > +static const struct i2c_device_id ak5558_i2c_id[] = {
>> > +       { "ak5558", 0 },
>> > +       { }
>> > +};
>> > +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);
>
>> I dunno if it's really helpful to have. Though it's up to Mark and you.
>
> I don't care either way.

Since Mark is okay with either, I would rather switch to ->probe_new()
and remove above table.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
