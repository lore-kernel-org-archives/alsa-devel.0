From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 2/2] snd-usb-audio: Add duplex mode for
 Digidesign Mbox 1 and enable mixer
Date: Sun, 09 Nov 2014 00:35:29 +1100
Message-ID: <545E1C21.3090803@gmail.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
 <1415059597-18344-3-git-send-email-damien@zamaudio.com>
 <s5ha9442z6d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C1DD2260441
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 14:35:38 +0100 (CET)
Received: by mail-pd0-f173.google.com with SMTP id v10so4975790pde.18
 for <alsa-devel@alsa-project.org>; Sat, 08 Nov 2014 05:35:37 -0800 (PST)
In-Reply-To: <s5ha9442z6d.wl-tiwai@suse.de>
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

Hi Takashi,

On 07/11/14 01:15, Takashi Iwai wrote:
> Hmm, can we achieve this without introducing the new audioformats
> thing, e.g. with COMPOSITE, instead?

I don't think COMPOSITE will work because the same interface has
multiple endpoints.  My code provides a framework for other devices with
the same issue.  I was told previously that this was the problem with
getting my previous attempt into the kernel.  Or is this doable without
adding a struct?

Damien
