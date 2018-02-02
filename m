From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC
	driver
Date: Fri, 2 Feb 2018 18:09:39 +0200
Message-ID: <CAHp75VeiPrJc-G44BomwwSFs1AELWNis=aS-j=Pg85ttL78Jnw@mail.gmail.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com>
 <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
 <20180201134840.GA10785@sirena.org.uk>
 <CAHp75VfydH+9ABZRbV++Od3+wnvQdzXyyDFtfi-1FnOUYjOXQQ@mail.gmail.com>
 <20180202150609.GB7101@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id AA66326791F
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 17:09:42 +0100 (CET)
Received: by mail-qk0-f194.google.com with SMTP id i141so24509195qke.0
 for <alsa-devel@alsa-project.org>; Fri, 02 Feb 2018 08:09:42 -0800 (PST)
In-Reply-To: <20180202150609.GB7101@sirena.org.uk>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, Cosmin Samoila <cosmin.samoila@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 2, 2018 at 5:06 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 01, 2018 at 04:46:56PM +0200, Andy Shevchenko wrote:
>> On Thu, Feb 1, 2018 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
>> >> >> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
>> >> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> >> >> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
>> > Honestly the signoffs above are nothing unusual for a driver contributed
>> > by a vendor - things are often bouncing around internally for ages and
>> > it's good to keep credits for people.
>
>> We have Co-developed-by: for the authors.
>
> Which doesn't really get much use

True... (13 entries so far)

>  and in this case where it looks like
> the code has flowed from AKM to NXP the DCO bit is pretty important.

...though it doesn't replace SoB, it adds a bit of information to it
(points to the authors of the module).


-- 
With Best Regards,
Andy Shevchenko
