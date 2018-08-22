From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Re: [PATCH v2] ALSA: pcm: Return 0 when size <
 start_threshold in capture
Date: Wed, 22 Aug 2018 12:25:24 -0300
Message-ID: <20180822152524.GA13037@localhost.localdomain>
References: <20180822150359.GA12976@localhost.localdomain>
 <s5hy3cye8wu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com
 [209.85.216.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E9118267663
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 17:25:32 +0200 (CEST)
Received: by mail-qt0-f180.google.com with SMTP id r37-v6so2559009qtc.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 08:25:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hy3cye8wu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi wrote:
> Almost good, but still not perfect, unfortunately :)
> The patch should be applicable onto the kernel tree as is with -p1
> option, i.e. the diff should be like
>   --- a/sound/core/pcm_lib.c
>   +++ b/sound/core/pcm_lib.c
>
> But never mind, I'll apply this manually at this time, just keep the
> above in mind for the next time.

Ok, thank you!

The .orig thing is ok if I had used the full pathname?

diff does not generate a/ and b/ (at least with '-up'
options). By the way, 'diff -up' is what
submitting-patches document recommends when no git tree
is available.
