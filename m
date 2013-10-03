From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-usx2y: fix start frame mask
Date: Thu, 03 Oct 2013 16:35:10 +0200
Message-ID: <524D809E.2010509@gmail.com>
References: <1380721197-4889-1-git-send-email-zonque@gmail.com>
 <s5hr4c3u6la.wl%tiwai@suse.de> <524C2485.2030301@gmail.com>
 <CAEw7SVG-NK4Zjr5pvL2xusCDBD6-H1v1P-J9Q7rpbuQma+FiAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f52.google.com (mail-ee0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F20E26556D
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 16:35:14 +0200 (CEST)
Received: by mail-ee0-f52.google.com with SMTP id c41so1127700eek.25
 for <alsa-devel@alsa-project.org>; Thu, 03 Oct 2013 07:35:14 -0700 (PDT)
In-Reply-To: <CAEw7SVG-NK4Zjr5pvL2xusCDBD6-H1v1P-J9Q7rpbuQma+FiAA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guido Aulisi <guido.aulisi@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03.10.2013 11:59, Guido Aulisi wrote:
> Hi,
> I saw this thread only today.
> if I remember well, that patch worked because the check wrapped around
> 03ff, but in the end I removed that check totally.

That's what the second version of my patch also does.

Next time, when detecting such problems, please consider sending a patch
to alsa-devel, so fixes make it to the users eventually :)


Thanks,
Daniel
