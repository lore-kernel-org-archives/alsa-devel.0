From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 19:50:18 -0700
Message-ID: <5167766A.8060505@gmail.com>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
 <5166D295.2070400@list.ru> <5166DB38.1010706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F50260783
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 04:50:55 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id 5so1168239pdd.17
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 19:50:54 -0700 (PDT)
In-Reply-To: <5166DB38.1010706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 08:48 AM, Gabriel M. Beddingfield wrote:
>> The attached patch adds a playback stream for the dummy
>> codec. Would it be possible to apply this?
>
> No... not like that.

I was wrong.  Sorry.

That patch is on the right track.  As Lars said, it needs a Capture DAI, 
too.  Might also consider adding more audio formats.

> Instead, wouldn't it be better to extend it by defining some platform data?
 > Maybe something like:

I still think that making this extensible is a good idea (platform 
data), but fall back on a very permissive default DAI (like in your patch).

-gabriel
