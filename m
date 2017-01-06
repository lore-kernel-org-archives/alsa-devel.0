From: Ricardo Biehl <rbpoficial@gmail.com>
Subject: Re: what is exactly pcm.boundary?
Date: Fri, 6 Jan 2017 14:08:47 -0200
Message-ID: <CAAu8FseE8M-6bynuphCK5HxnpqKzh_Y_bmeHEf6meTTD4bU2eA@mail.gmail.com>
References: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
 <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
 <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
 <922adfc9-c436-905a-466e-7fbba239439e@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FD126719D
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 17:08:48 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id c85so5990071wmi.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Jan 2017 08:08:48 -0800 (PST)
In-Reply-To: <922adfc9-c436-905a-466e-7fbba239439e@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

2017-01-06 6:09 GMT-02:00, Clemens Ladisch <clemens@ladisch.de>:
>
> Are you talking about code in your driver (where you are responsible for
> asking the hardware), or user space code (where you must not directly
> read hw_ptr)?  What is the actual problem you're trying to solve?
>

Hello!
I'm developing a "live microphone system over local network" which are user
space programs (clients => server) transferring audio nearly real-time
(human imperceptible latency).
I need to elaborate a good solution of implementation to have everything working
as expected -- networking, scheduling, IO management etc -- However I need at
first make sure I can get control over audio.

I decided to use ioctl() level of communication with ALSA in kernel, and what I
need is synchronization :-)
I must know which sample the hardware is currently processing to prevent a lot
of losses or latency increasing.

Cheers!

--
Ricardo Biehl Pasquali
