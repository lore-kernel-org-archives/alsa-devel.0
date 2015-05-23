From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: zx: Add ZTE zx296702 I2S DAI
	driver
Date: Sat, 23 May 2015 22:02:52 +0800
Message-ID: <CABymUCPEhe5pWrEskDE664Ca588LkC03pbumqUnTAj_6rkagbQ@mail.gmail.com>
References: <1432119972-6934-1-git-send-email-jun.nie@linaro.org>
 <20150522123657.GS21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A6E792604AB
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 16:02:53 +0200 (CEST)
Received: by lbcmx3 with SMTP id mx3so28866934lbc.1
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 07:02:53 -0700 (PDT)
In-Reply-To: <20150522123657.GS21391@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org

2015-05-22 20:36 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Wed, May 20, 2015 at 07:06:11PM +0800, Jun Nie wrote:
>> Add ZTE zx296702 I2S DAI driver
>
> This looks good but depends on the DMA driver and a couple of small
> nits:
>
>> +config ZX296702_I2S
>> +     bool "ZX296702 i2s"
>
> I see no reason for this to be bool as opposed to a tristate - why not
> let people build it as a module?
>
>> +     default:
>> +             dev_err(cpu_dai->dev, "Unknwon master/slave format\n");
>
> The driver consistently misspells unknown.

Will fix the two issues. Thanks!

Jun
