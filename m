From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH v5-resend 4/7] ASoC: sirf: Add SiRF I2S
	driver
Date: Fri, 7 Mar 2014 16:38:44 +0800
Message-ID: <CAByv0RPdLOC+JAEQ7o76QDAPFoJO9G+6u0mzcd=i33RC17zYzQ@mail.gmail.com>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-5-git-send-email-rongjun.ying@csr.com>
 <20140307060516.GE13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id D20DA2659B0
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 09:38:45 +0100 (CET)
Received: by mail-qg0-f49.google.com with SMTP id z60so10630570qgd.8
 for <alsa-devel@alsa-project.org>; Fri, 07 Mar 2014 00:38:44 -0800 (PST)
In-Reply-To: <20140307060516.GE13126@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-03-07 14:05 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, Mar 05, 2014 at 04:34:37PM +0800, RongJun Ying wrote:
>
> Mostly OK, a couple of small things below:
>
>> +static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
>> +     int src_rate)
>> +{
>> +     struct sirf_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +
>> +     switch (div_id) {
>> +     case SIRF_I2S_EXT_CLK:
>> +             i2s->ext_clk = 1;
>> +             break;
>> +     case SIRF_I2S_PWM_CLK:
>> +             i2s->ext_clk = 0;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
>> +     i2s->src_clk_rate = src_rate;
>> +     return 0;
>> +}
>
> This should be set_sysclk().

OK

>
>> +     base = devm_ioremap(&pdev->dev, mem_res->start,
>> +             resource_size(mem_res));
>> +     if (base == NULL)
>> +             return -ENOMEM;
>
> As mentioned on the other patch this should be devm_ioremap_resource() -
> if you are sharing the register range use a core device to own the
> register map.

I may use the mfd driver to manage all shring the regsiter range.

Thanks

-- 
------------------------------
Rongjun Ying
