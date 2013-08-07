From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v6 2/8] ASoC: atmel: machine driver for
	at91sam9x5-wm8731 boards
Date: Wed, 7 Aug 2013 10:20:20 +0200
Message-ID: <CACQ1gAhVfSV1MArzTGxSfJOcEksBv-O2AjVJm6eEoBGtggw5uA@mail.gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <20130806171156.GN6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 14F952610D2
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 10:20:42 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id h1so2723431oag.24
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 01:20:42 -0700 (PDT)
In-Reply-To: <20130806171156.GN6427@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, patches@opensource.wolfsonmicro.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/8/6 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 30, 2013 at 12:32:03PM +0200, Richard Genoud wrote:
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Description of the Asoc machine driver for an at91sam9x5 based board
>> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
>> master on the SSC/I2S interface. Its connections are a headphone jack
>> and an Line input jack.
>
> Applied, thanks.  We should really be able to merge this with the
> sam9g20ek driver that's here already but we can do that later.

I think it will be easier after the switch to the common clock framework.
I'll look into that.

Thanks !
