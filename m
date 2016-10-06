From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Audio on mx6q udoo
Date: Thu, 6 Oct 2016 16:01:32 -0300
Message-ID: <CAOMZO5DtJG6Otw8rfZQQymsoZJ4UhB2idgDCXgWN69OMyQc_Ww@mail.gmail.com>
References: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
 <57F6644F.3070500@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 88A50266820
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 21:01:34 +0200 (CEST)
Received: by mail-ua0-f171.google.com with SMTP id r64so26311232uar.3
 for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2016 12:01:34 -0700 (PDT)
In-Reply-To: <57F6644F.3070500@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Thu, Oct 6, 2016 at 11:48 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> I assume that you tested older kernel on this board and got proper output
> there.

Yes, I tested audio on Udoo's 3.14 kernel and it plays well.

> Even if you don't get any sound is playing time correct - that is
> does for example 30 second file play for 30 seconds?
> If not then it might be DMA or sampling rate setup problem.

Yes, the timing seems to be correct.

> Is the AC'97 codec model detected correctly
> (/proc/asound/card0/codec97#0/ac97#0-0)?
> If not then it might be some problem with accessing AC'97 regs
> (like SSI clock not running).

alsamixer reports:

Chip: VIA Technologies VIA1613 rev 3.

> You can also try to revert
> http://www.spinics.net/lists/alsa-devel/msg54983.html to go back
> to RB tree register cache, maybe this will help.
>
> I have tried to run today's linux-next on my UDOO board but it crashes
> at boot somewhere in imx6q_pm_pu_power_off(), so unfortunately can't
> test it for now.

I see the same issue with 4.7.6.

Are you able to get audio working with kernel 4.7.6?

Thanks,

Fabio Estevam
