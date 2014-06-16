From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: [PATCH 1/3] sound: Add a quirk to enforce
	period_bytes
Date: Mon, 16 Jun 2014 09:22:08 -0400
Message-ID: <CAGoCfiw3du9rXFvDfsUYLu4Ru6mbdWa+LtAyYupXosM0n-71NA@mail.gmail.com>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com>
 <1402762571-6316-2-git-send-email-m.chehab@samsung.com>
 <539E9F25.7030504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3DD2652E1
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 15:22:09 +0200 (CEST)
Received: by mail-qc0-f178.google.com with SMTP id c9so7632937qcz.37
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 06:22:08 -0700 (PDT)
In-Reply-To: <539E9F25.7030504@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: alsa-devel@alsa-project.org

> This looks like a workaround for a userspace bug that would affect all
> USB audio devices.  What period/buffer sizes are xawtv/tvtime trying to
> use?

I have similar concerns, although I don't know what the right solution
is.  For example, the last time Mauro tweaked the latency in tvtime,
it broke support for all cx231xx devices (note that tvtime and xawtv
share essentially the same ALSA code):

http://git.linuxtv.org/cgit.cgi/tvtime.git/commit/?id=3d58ba563bfcc350c180b59a94cec746ccad6ebe

It seems like there is definitely something wrong with the
latency/period selection in both applications, but we need some
insight from people who are better familiar with the ALSA subsystem
for advice on the "right" way to do low latency audio capture (i.e.
properly negotiating minimal latency in a way that works with all
devices).

Devin

-- 
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
