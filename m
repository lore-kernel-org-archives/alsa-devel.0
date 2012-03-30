From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Enable VAG when
	DAC/ADC up
Date: Fri, 30 Mar 2012 12:12:35 +0800
Message-ID: <CAAQ0ZWRPzWUeBV34H81t0ymN2sncaZ8PeX2Nv_owNaAjfgpxig@mail.gmail.com>
References: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
	<20120329213243.GC4153@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ACA1310455D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 06:12:37 +0200 (CEST)
Received: by laap9 with SMTP id p9so275231laa.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 21:12:35 -0700 (PDT)
In-Reply-To: <20120329213243.GC4153@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 30 March 2012 05:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wr=
ote:
> On Fri, Mar 30, 2012 at 12:13:02AM +0800, Shawn Guo wrote:
>> From: Zeng Zhaoming <zengzm.kernel@gmail.com>
>>
>> As manual described, VAG is an internal voltage reference of DAC/ADC,
>> So enabled it before DAC/ADC up.
>
> Applied, thanks. =A0I applied it for 3.4 since it's basically a bug fix,
> please check that the patch got applied correctly.

Yes, it looks correct to me.

Regards,
Shawn
