From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: Samsung: Debug PCM
	snd_soc_dai_driver registration
Date: Mon, 13 Sep 2010 10:34:30 +0900
Message-ID: <AANLkTinrn=RPk5tktyXrdQ_KokkSYT6g+xYL_ZKiGkW=@mail.gmail.com>
References: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
	<20100910095438.GD3068@rakim.wolfsonmicro.main>
	<AANLkTimajKCsDLPuGRoO=339BpUQ_wXn8pDsC+7ErzET@mail.gmail.com>
	<20100910114754.GJ7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7930F244D0
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 03:34:31 +0200 (CEST)
Received: by wyb32 with SMTP id 32so5491791wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2010 18:34:31 -0700 (PDT)
In-Reply-To: <20100910114754.GJ7259@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, sw.youn@samsung.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 8:47 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Sep 10, 2010 at 08:24:03PM +0900, Jassi Brar wrote:
>> 2010/9/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> > You should be able to use the id field rather than adding the number to
>> > the names here.
>
>> But the id assignment was removed by Liam's patch, maybe unintentional ?
>
> Most likely an error - earlier versions of the patches didn't have the
> separate ID field IIRC.
>

ok, but I don't seem to be able to find out where
snd_soc_dai_driver.id is being used
and  sound/soc/sh/hac.c and sound/soc/atmel/atmel_ssc_dai.c seems to
be doing similar
Are we on the same page? Please help me understand it.
