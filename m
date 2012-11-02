From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH v2] ASoC: mxs-pcm: Fix fifo size
Date: Sat, 3 Nov 2012 04:04:02 +0800
Message-ID: <CAP1dx+zSmfEeih4DP3=E-r5HZUYmEAf07WzTmgYypxP8DJ73RA@mail.gmail.com>
References: <1351703171-27855-1-git-send-email-festevam@gmail.com>
 <20121102150627.GE4413@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 023852650EC
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 21:04:03 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id c10so5318204ieb.38
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2012 13:04:03 -0700 (PDT)
In-Reply-To: <20121102150627.GE4413@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2 November 2012 23:06, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 31, 2012 at 03:06:11PM -0200, Fabio Estevam wrote:
>
>> According to MX28 Reference Manual the SAIF FIFO contains four 32-bit entries.
>
>> -     .fifo_size              = 32,
>> +     .fifo_size              = 4,
>
> fifo_size should be specified in bytes so the original code looks
> correct?

Then, probably it should be 16.
BTW, it seems this param is not used anymore:
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s05.html
That may be the reason why i see some other platforms pcm code just
set fifo_size to 0.

Regards
Dong Aisheng
