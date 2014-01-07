From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Tue, 7 Jan 2014 10:29:48 -0200
Message-ID: <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f44.google.com (mail-vb0-f44.google.com
 [209.85.212.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C20C82616F4
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 13:29:50 +0100 (CET)
Received: by mail-vb0-f44.google.com with SMTP id x8so48172vbf.17
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 04:29:48 -0800 (PST)
In-Reply-To: <52CBEDFA.10603@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Nicolin Chen <b42378@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Lars-Peter,

On Tue, Jan 7, 2014 at 10:07 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> We've had similar problems like this before. Typically this is caused by the
> dmaengine driver calling the complete callback when it shouldn't. E.g. after
> dmaegine_terminate_all() has already been called for the channel. There is
> also unfortunately a small chance condition (which needs some extensions to
> the dmaengine API before we can fix it). But the chance for this race
> condition to occur is really small and has only been observed on a 4 (or 8,
> not sure) core system so far. Is the problem reproducible in your case? Also

Thanks for your comments. Yes, I get this issue on a mx6 quad all the
time running linux-next, but not on a mx6solo.

> do you have a know good kernel version?

Tried it on 3.13-rc7 and it works fine.

Nicolin,

On linux-next I am no longer able to play audio without the sdma
firmware (ok, maybe we should handle this topic on another thread).

Regards,

Fabio Estevam
