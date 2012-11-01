From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix channel swap for
	24-bit format
Date: Thu, 1 Nov 2012 22:20:50 +0800
Message-ID: <CAP1dx+zuyUsMxNFqN_NM0OWMN-jb8Fx+BWvHbutNUSik306e2Q@mail.gmail.com>
References: <1351638429-13865-1-git-send-email-festevam@gmail.com>
 <CAP1dx+ydbcYfFrdG0sa2Ro2kfJbCS99nm4J_uFWT4JUo7NkcdQ@mail.gmail.com>
 <20121101121133.GB4413@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E62842616E0
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:20:51 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id t11so1102453daj.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 07:20:50 -0700 (PDT)
In-Reply-To: <20121101121133.GB4413@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, DWinner@tc-helicon.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 1 November 2012 20:11, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 31, 2012 at 04:50:50PM +0800, Dong Aisheng wrote:
>> On 31 October 2012 07:07, Fabio Estevam <festevam@gmail.com> wrote:
>
>> > +                        * write data to saif data register to trigger
>> > +                        * the transfer.
>> > +                        * For 24-bit format the 32-bit FIFO register stores
>> > +                        * only one channel, so we need to write twice.
>> >                          */
>> >                         __raw_writel(0, saif->base + SAIF_DATA);
>> > +                       __raw_writel(0, saif->base + SAIF_DATA);
>
>> This probably could a workaround for the customer, but i'm not sure
>> Mark could accept it
>> since the code is a bit confusing. (Mark, what's your suggestion on this?)
>
> I'm not really concerned about the code, the comment is fairly clear
> except that it'd be good to mention that this is safe for data sizes
> other than 24 bit.  It's certainly really much more confusing than the
> existing code and if it works better that's obviously good!

If you're fine with it, i'm also ok.
This probably is a suitable solution for now since finding out the
strange IC behavior of this issue
may need much longer time without IC people's help and it's still not
on the plan.

Fabio,
You can update the patch with Mark's suggestion and resend it.

Regards
Dong Aisheng
