From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] ASoC: da7213: Delete an error message
 for a failed memory allocation in da7213_fw_to_pdata()
Date: Fri, 24 Nov 2017 12:33:04 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711241231560.3316@hadrien>
References: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
 <6dc71b14-4c14-82f6-9dad-92bfa9854de2@users.sourceforge.net>
 <2E89032DDAA8B9408CB92943514A0337014C1B116F@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-640844049-1511523185=:3316"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id F3433266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 12:33:06 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1B116F@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--8323329-640844049-1511523185=:3316
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Nov 2017, Adam Thomson wrote:

> On 23 November 2017 17:33, SF Markus Elfring wrote:
>
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 23 Nov 2017 17:56:54 +0100
> >
> > Omit an extra message for a memory allocation failure in this function.
>
> I'm not sure this is an extra message. We don't return -ENOMEM as a result of
> this operation and probe won't fail on this. So does devm_kzalloc() print error
> messages?

Unless there is NO WARN, a backtrace will be generated in the out of
memory case.

julia

>
> > This issue was detected by using the Coccinelle software.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  sound/soc/codecs/da7213.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> > index 41d9b1da27c2..d1b77a0e3b74 100644
> > --- a/sound/soc/codecs/da7213.c
> > +++ b/sound/soc/codecs/da7213.c
> > @@ -1654,10 +1654,8 @@ static struct da7213_platform_data
> >  	u32 fw_val32;
> >
> >  	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
> > -	if (!pdata) {
> > -		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
> > +	if (!pdata)
> >  		return NULL;
> > -	}
> >
> >  	if (device_property_read_u32(dev, "dlg,micbias1-lvl", &fw_val32) >= 0)
> >  		pdata->micbias1_lvl = da7213_of_micbias_lvl(codec, fw_val32);
> > --
> > 2.15.0
> N?????r??y??????X??ǧv???)޺{.n?????z?ޖ6?????)?????*jg???
?????ݢj/???z?ޖ????ޙ????&?)ߡ?a???????G???????:+v???w????
--8323329-640844049-1511523185=:3316
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-640844049-1511523185=:3316--
