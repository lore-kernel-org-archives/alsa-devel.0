From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 19:58:40 -0700
Message-ID: <51677860.7080402@gmail.com>
References: <51669249.8090100@list.ru> <51669353.7090903@metafoo.de>
 <5166D295.2070400@list.ru> <5166DB38.1010706@gmail.com>
 <5166FAB9.9010506@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f43.google.com (mail-da0-f43.google.com
 [209.85.210.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AC557261095
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 04:58:47 +0200 (CEST)
Received: by mail-da0-f43.google.com with SMTP id u36so950261dak.16
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 19:58:46 -0700 (PDT)
In-Reply-To: <5166FAB9.9010506@metafoo.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>, Stas Sergeev <stsp@list.ru>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 11:02 AM, Lars-Peter Clausen wrote:
>> Instead, wouldn't it be better to extend it by defining some platform data?  Maybe something like:
>
> Either you want a dummy or you want one with specific requirements. For the
> former case use the dummy codec, for the later case add a proper driver.
> Putting these kinds of things in your board file is in my opinion a bad habit.

Well, I've seen a couple cases where a dummy codec /is/ the proper 
driver and all that's needed is to restrict the formats that the DAI 
supports (sample rate, etc).

Yes, we can always write a board-specific dummy codec with the 
restricted formats -- but since there's already one in ASoC, why not 
make it extensible?

-gabriel
