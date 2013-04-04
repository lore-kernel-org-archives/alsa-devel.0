From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Handle large period size end-of-stream situation
Date: Wed, 03 Apr 2013 22:35:30 -0700
Message-ID: <515D1122.9020502@gmail.com>
References: <515C459A.5070209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B412265E20
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 07:35:43 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id fb10so1297851pad.39
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 22:35:42 -0700 (PDT)
In-Reply-To: <515C459A.5070209@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 08:07 AM, Patrick Lai wrote:
> I am dealing with a use case requiring passing large buffer down to the
> DSP. Application in the user-space passes PCM through mmap interface.
> Per my understanding, ALSA is designed to work with DMA. Data is
> transferred in chunk equal to period size. At the end of playback,
> there may not be enough audio data left in the music stream to fill
> entire period. If remaining audio data only takes up very small chunk
> of period, playback takes longer to stop. Given that period size I have
> to deal with is quite large, this problem is observed easily. If my
> understanding is correct, what is the standard/recommended way of
> handling end of stream case?

In the typical end-of-stream case, you simply write the data that you 
have.  When the hw pointer catches up to the application pointer, you 
get an XRUN and the stream stops immediately.  There's no requirement 
that streams have to stop on period boundaries.

-gabriel
