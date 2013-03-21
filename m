From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] Sound: sgtl5000 Allow codec clock
	frequency to be set.
Date: Thu, 21 Mar 2013 11:11:56 -0500
Message-ID: <CAOZdJXXv=O3vmSCJ1ojhis+Fn7FJ7yhd2wVt10m77Cixbew2BA@mail.gmail.com>
References: <20130319170322.27828.7691.stgit@localhost>
 <514A63EE.7000707@tabi.org> <514AC738.6050900@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F8A265143
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 17:12:00 +0100 (CET)
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by muin.pair.com (Postfix) with ESMTPSA id 37E638FC37
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 12:11:58 -0400 (EDT)
Received: by mail-la0-f49.google.com with SMTP id fs13so5419994lab.22
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 09:11:56 -0700 (PDT)
In-Reply-To: <514AC738.6050900@parkeon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mfuzzey@parkeon.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2013 at 3:39 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> With this patch and that DT example the frequency of clock 162 will be _set_
> to 20MHz

Does that mean that it ignores the ' clocks' parameter?

> If clock-frequency is omitted the binding is still correct (hence the
> optional) but the frequency of clock 162 would not be modified.
>
> In the documentation I wrote "If both a clock and clock-frequency are
> provided the clock's rate will be set. " maybe this is not clear enough?

It's not clear what it will be set *to*.
