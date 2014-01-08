From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Wed, 8 Jan 2014 01:50:45 -0200
Message-ID: <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
 <20140107122813.GA6750@MrMyself>
 <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f179.google.com (mail-ve0-f179.google.com
 [209.85.128.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB2D2616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 04:50:46 +0100 (CET)
Received: by mail-ve0-f179.google.com with SMTP id jw12so849653veb.10
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 19:50:45 -0800 (PST)
In-Reply-To: <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Tue, Jan 7, 2014 at 10:49 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jan 7, 2014 at 10:28 AM, Nicolin Chen
> <Guangyu.Chen@freescale.com> wrote:
>> On Tue, Jan 07, 2014 at 10:29:48AM -0200, Fabio Estevam wrote:
>>> Nicolin,
>>>
>>> On linux-next I am no longer able to play audio without the sdma
>>> firmware (ok, maybe we should handle this topic on another thread).
>>
>> I haven't tested the linux-next tree with my SabreSD recently. But..would that
>> be caused by the SDMA firmware version 2? Please try this patch to trick the
>> original sdma firmware and see if it's gonna work.
>
> firmware/imx/sdma/sdma-imx6q.bin.ihex does not exist in mainline, so I
> can't apply your patch.
>
> Please send me your modified firmware offline and I can give it a try.
>
> It would be really better if we could play audio without using any
> firmware as in 3.13-rc7.

Just retried with your updated SDMA firmware (version 2.1) and now I
can get audio playback to work again.

Also confirmed that running with no SDMA firmware the crash still happens.

In 3.12 and 3.13-rc we are able to play audio without using any SDMA
firmware, but it we are not longer able to do this now. Other than
that, people will have to use the exact 2.1 firmware version, so there
will be a regression in 3.14, right?

Couldn't we keep the 3.12/3.13 behaviour, ie, be able to play audio
without loading any SDMA firmware?

Regards,

Fabio Estevam
