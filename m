From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH RFC 7/9] ALSA: usb-audio: conditional
 interface altsetting
Date: Mon, 19 Aug 2013 22:13:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308192129020.1112@heraclitus>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
 <1376857363-1116-8-git-send-email-eldad@fogrefinery.com>
 <5211EEA6.6080809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 35FCE2650A0
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 22:13:30 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so1638653bkb.32
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:13:29 -0700 (PDT)
In-Reply-To: <5211EEA6.6080809@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

On Mon, 19 Aug 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > On some devices, if the endpoint for the other direction is in use,
> > setting one interface will shutdown the other (in use) endpoint.
> 
> There are (non-UAC) devices where both endpoints are in the same
> interface.

That's good to know. But doesn't setting the alternate the interface on
behalf of one ep while the other ep is in use distrub anything too?
Or did you mean something else?

> 
> > This patch needs revising. It adds a get_interface function, which
> > should not be neccesary (possibly unreliable on some devices?).
> 
> struct usb_interface has cur_altsetting.

Ah, didn't look there. Thanks!

Hmm, so is there a reason why is it also kept in snd_usb_substream 
(altset_idx)?
>From a quick check I see that it is only used in set_format, and using 
iface->cur_altsetting would be the same, so it might be redundant. I'll 
look into that next.

Cheers,
Eldad
