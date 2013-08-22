From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v2 00/10] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Thu, 22 Aug 2013 19:43:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308221932490.1343@heraclitus>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
 <5215AB8D.8020001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A01EB26086E
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 19:43:09 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so827452bkb.9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:43:09 -0700 (PDT)
In-Reply-To: <5215AB8D.8020001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org



On Thu, 22 Aug 2013, Daniel Mack wrote:

> On 21.08.2013 23:37, Eldad Zack wrote:
> > Hi,
> > 
> > This patch series attempts to fix a long starting problem with the concurrent
> > usage of playback and capture on implicit feedback devices.
> > 
> > Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).
> 
> Thanks a lot for working on this! I'll give that series a test run tonight.

That's great, thanks!

Cheers,
Eldad
