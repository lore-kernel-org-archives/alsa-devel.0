From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 2/2] snd-usb-audio: Add duplex mode for
 Digidesign Mbox 1 and enable mixer
Date: Mon, 10 Nov 2014 18:34:25 +1100
Message-ID: <54606A81.6080009@gmail.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
 <1415059597-18344-3-git-send-email-damien@zamaudio.com>
 <s5ha9442z6d.wl-tiwai@suse.de> <545E1C21.3090803@gmail.com>
 <s5hk3343f6y.wl-tiwai@suse.de> <545F747A.7090002@ladisch.de>
 <s5hfvds2sjo.wl-tiwai@suse.de> <545FFC8F.9040001@gmail.com>
 <s5hbnof3632.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 698362605D6
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 08:34:31 +0100 (CET)
Received: by mail-pd0-f177.google.com with SMTP id v10so7285055pde.36
 for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2014 23:34:30 -0800 (PST)
In-Reply-To: <s5hbnof3632.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 10/11/14 17:47, Takashi Iwai wrote:
> My bad, take the additional fix patch below.
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Fix Oops by composite quirk enhancement
> 
> The quirk argument itself was used as iterator, so it cannot be taken
> back to the original value, obviously.
> 
> Fixes: d4b8fc66f770 ('ALSA: usb-audio: Allow multiple entries for the same iface in composite quirk')
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/quirks.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I confirm that this fixes the kernel oops, and the logic works.  See
next patch series for working patch!

Damien
