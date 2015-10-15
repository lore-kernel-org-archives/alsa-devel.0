From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: DSD: Playing silence before and after actual audio
 data
Date: Thu, 15 Oct 2015 18:13:54 +0500
Message-ID: <561FA692.5020105@gmail.com>
References: <561FA3C4.8040205@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D08260492
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 15:13:59 +0200 (CEST)
Received: by wijq8 with SMTP id q8so129216826wij.0
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 06:13:58 -0700 (PDT)
In-Reply-To: <561FA3C4.8040205@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Pietryka <martin.pietryka@streamunlimited.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

15.10.2015 18:01, Martin Pietryka wrote:
> Hi guys,
>
> I'm trying to figure out the best way to insert ~40ms worth of silence
> pattern before and after playing back DSD data.
>
> There seems to be support inside ALSA for a DSD silence pattern, but as
> far as I have seen it's only used when an underrun might occur
> (silence_threshold, silence_size).
>
> Is there some possibility inside ALSA to basically insert silence before
> and after playback, or how hard would it be to implement something like
> this? I have looked a bit for myself and for me it seems that the
> modifications needed inside ALSA to achieve this feature are
> substantial, but of course I also might have missed something.

So you already have some sound data that you want to play, and you know 
it is DSD. So, look at the silence pattern (which is 
0x6969696969696969ULL), and copy an appropriate number of its 
repetitions before and after your sound data. The result will be a valid 
DSD stream that contains silence, your data, and then silence again. 
Then play it as usual, i.e. no explicit ALSA support is needed.

-- 
Alexander E. Patrakov
