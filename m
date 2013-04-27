From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH] ALSA: USB: adjust for changed 3.8 USB API
Date: Sat, 27 Apr 2013 15:08:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304271447440.4910@xoschi>
References: <517BA418.3010104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 141F2260307
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2013 15:08:56 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id jk14so1986337bkc.3
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2013 06:08:56 -0700 (PDT)
In-Reply-To: <517BA418.3010104@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: alsa-devel@alsa-project.org


On Sat, 27 Apr 2013, Clemens Ladisch wrote:

> The recent changes in the USB API ("implement new semantics for
> URB_ISO_ASAP") made the former meaning of the URB_ISO_ASAP flag the
> default, and changed this flag to mean that URBs can be delayed.
> This is not the behaviour wanted by any of the audio drivers because
> it leads to discontinuous playback with very small period sizes.
> Therefore, our URBs need to be submitted without this flag.
> 
> Reported-by: Joe Rayhawk <jrayhawk@fairlystable.org>
> Cc: <stable@vger.kernel.org> # 3.8 only
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

This is slightly offtopic but related:

I figured a change of these semantics might impact consistent latency,
so I went ahead and tested this. It turns out that with my device
(uses implicit feedback) on current mainline I get up to +/- 10 frames 
change across stream restarts, while with 3.7.0 I get +/- 1 frame 
change.
I restarted the stream about 20 times with each kernel.

So I tested this patch to see if it helps, but there's no change for my 
setup with 3.9.

Cheers,
Eldad
