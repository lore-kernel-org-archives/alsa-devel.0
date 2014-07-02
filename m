From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: Re: [PATCH] ASoC: add Wolfson WM8973 codec driver
Date: Wed, 2 Jul 2014 09:24:49 +0800
Message-ID: <CAHa2TOZeSVZZpRKXH2TEqZiX9Ra4kw8hDtDh++9AMAms_Ywtkg@mail.gmail.com>
References: <1403852955-18974-1-git-send-email-xavier.hsu@linaro.org>
 <53AD7ABB.7010201@metafoo.de>
 <20140701110500.GA19534@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
 [74.125.82.171])
 by alsa0.perex.cz (Postfix) with ESMTP id ECFF0265150
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 03:24:49 +0200 (CEST)
Received: by mail-we0-f171.google.com with SMTP id q58so10597936wes.30
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 18:24:49 -0700 (PDT)
In-Reply-To: <20140701110500.GA19534@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Everybody :

I will provide an updated patch for supporting wm8971 and wm8973 soon.

Many Thanks.
Xavier


2014-07-01 19:05 GMT+08:00 Charles Keepax <
ckeepax@opensource.wolfsonmicro.com>:

> On Fri, Jun 27, 2014 at 04:07:55PM +0200, Lars-Peter Clausen wrote:
> > On 06/27/2014 09:09 AM, Xavier Hsu wrote:
> >> This patch adds support for the wm8973 codec, based on the
> >> existing wm8971 codec driver.
> >>
> >
> > Those two look really similar. Do you think they can both be supported by
> > the same driver, rather than duplicating most of the code?
> >
> > - Lars
>
> I am not super familiar with these two devices but looking
> through the two datasheets it certainly seems they should be
> supported by the same driver. I would like to see some reason if
> we were to not go down this route.
>
> Thanks,
> Charles
>
