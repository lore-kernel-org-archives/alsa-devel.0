From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v4 00/15] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Mon, 7 Oct 2013 19:20:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310071915350.1353@anubis>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
 <s5heh7xsa0d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 1716D261B21
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 19:20:40 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so2810982bkb.3
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 10:20:40 -0700 (PDT)
In-Reply-To: <s5heh7xsa0d.wl%tiwai@suse.de>
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
Cc: Nikolay Martynov <mar.kolya@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 7 Oct 2013, Takashi Iwai wrote:

> At Sun,  6 Oct 2013 22:31:05 +0200,
> Eldad Zack wrote:
> > 
> > Hi,
> > 
> > This patch series attempts to fix a long standing problem with the concurrent
> > usage of playback and capture on implicit feedback devices.
[snip]
> 
> For reducing the further development, I applied trivial cleanup / fix
> patches now, namely, below have been merged now:

Thanks, Takashi!

>   ALSA: usb-audio: remove unused parameter from sync_ep_set_params
>   ALSA: usb-audio: remove deactivate_endpoints()
>   ALSA: usb-audio: don't deactivate URBs on in-use EP
>   ALSA: usb-audio: void return type of snd_usb_endpoint_deactivate()
>   ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on error
>   ALSA: usb-audio: rename alt_idx to altsetting
>   ALSA: usb-audio: remove unused endpoint flag EP_FLAG_ACTIVATED
> 
> The patches below need trivial fixes:
>   ALSA: usb-audio: prevent NULL dereference on stop trigger
>   ALSA: usb-audio: improve logging messages
> 
> And these need reconsideration:
>   ALSA: usb-audio: always wait in start_endpoints
>   ALSA: usb-audio: correct ep use_count semantics (add set_param flag)
> 
> I'll check the rest later.

Thanks for the very fast response and the review! I'll try to fix all 
the issues for the rest and repost.

Cheers,
Eldad
