From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: Re: [PATCH 3/5] ALSA: revo: Remove unused variable
Date: Tue, 1 Jul 2014 17:30:22 +0530
Message-ID: <CAK5sBcEkt_h9J5rO=rHagT=vvX621EG9_pTZqS2O=gRHMZQi-Q@mail.gmail.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
 <1404214378-24669-3-git-send-email-sachin.kamat@samsung.com>
 <s5h38el8f6d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A18261B21
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 14:00:24 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id mc6so5803000lab.38
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 05:00:23 -0700 (PDT)
In-Reply-To: <s5h38el8f6d.wl%tiwai@suse.de>
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

On Tue, Jul 1, 2014 at 5:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue,  1 Jul 2014 17:02:56 +0530,
> Sachin Kamat wrote:
>>
>> 'err' is not used in the function. Remove it.
>
> Better to handle the error case than ignoring it.

A comment below the code says
"/* error ignored; it's no fatal error */"

Hence, I removed it.

Regards,
Sachin.
