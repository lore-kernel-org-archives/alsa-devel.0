From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: Re: [PATCH] ALSA: sonicvibes: add error handling for
	snd_ctl_add
Date: Thu, 14 Jun 2018 12:33:09 +0800
Message-ID: <CABb2TxJLbxn6BrF7JtEQQZjLWWRSQYwX8Sthnqg-O=Jvqm80kg@mail.gmail.com>
References: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
 <s5hlgblbgk5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 876432675CA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 06:33:11 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id l6-v6so6945987iti.2
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 21:33:11 -0700 (PDT)
In-Reply-To: <s5hlgblbgk5.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'll fix this in v2. Thanks for your kind reply.

Best,
Zhouyang

2018-06-11 21:26 GMT+08:00 Takashi Iwai <tiwai@suse.de>:

> On Mon, 11 Jun 2018 10:08:40 +0200,
> Zhouyang Jia wrote:
> >
> > When snd_ctl_add fails, the lack of error-handling code may
> > cause unexpected results.
> >
> > This patch adds error-handling code after calling snd_ctl_add.
> >
> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>
> I postpone this one because the change won't give anything as is
> although this change itself is correct.  If you look at the code
> closely, the caller of snd_sonicvibes_create_gameport() ignores the
> return value.
> So we need to fix two places.
>
>
> thanks,
>
> Takashi
>
