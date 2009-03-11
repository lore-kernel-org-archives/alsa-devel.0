From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/3][RFC] ASoC: Add Magician machine
	support.
Date: Wed, 11 Mar 2009 22:03:57 +0100
Message-ID: <74d0deb30903111403v40e81da7o4bb703500f06458c@mail.gmail.com>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
	<1236798128.6781.187.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F22810389C
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 22:03:58 +0100 (CET)
Received: by gxk2 with SMTP id 2so478225gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 14:03:57 -0700 (PDT)
In-Reply-To: <1236798128.6781.187.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 8:02 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> Overall looks good. One very minor issue :-
>
> On Wed, 2009-03-11 at 19:16 +0100, Philipp Zabel wrote:
>> HTC Magician has a Philips UDA1380 codec connected via
>> SSP1 (playback) and I2S (capture).
>> There is a flip-flop between the SSP frame clock output
>> and the codec's word select input pin. To make the codec
>> see proper I2S input, the SSP has to send two frames per
>> sample.
>>
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>> ---
>> =A0sound/soc/pxa/Kconfig =A0 =A0| =A0 10 +
>> =A0sound/soc/pxa/Makefile =A0 | =A0 =A02 +
>> =A0sound/soc/pxa/magician.c | =A0563 +++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 575 insertions(+), 0 deletions(-)
>> =A0create mode 100644 sound/soc/pxa/magician.c
>>
>
> snip
>
>> --- /dev/null
>> +++ b/sound/soc/pxa/magician.c
>> @@ -0,0 +1,563 @@
>> +/*
>> + * SoC audio for HTC Magician
>> + *
>> + * Copyright (c) 2006-2009 Philipp Zabel <philipp.zabel@gmail.com>
>> + *
>> + * based on spitz.c,
>> + * Authors: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
>
> This address is no longer valid. Could you change to the address I'm
> sending with.

Of course, thanks. Will resend tomorrow with the address corrected.

regards
Philipp
