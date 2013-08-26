From: Nikolay Martynov <mar.kolya@gmail.com>
Subject: Re: [PATCH v3 00/11] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Mon, 26 Aug 2013 19:23:06 -0400
Message-ID: <CALGY4fuux1=qy14eCfcGDcPmARAw6C+MqEEuwL=KF_-mVmUJ+g@mail.gmail.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id BFBC5261B2C
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 01:23:10 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id hz10so2447177vcb.26
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 16:23:06 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

  I've tried this patch and can confirm that it fixes the issue with CM108
based USB headset I've described on the list several days ago (tried with
Skype).
  Thank you!


2013/8/25 Eldad Zack <eldad@fogrefinery.com>

> Hi,
>
> This patch series attempts to fix a long standing problem with the
> concurrent
> usage of playback and capture on implicit feedback devices.
>
> Applies against current for-next (HEAD
> 68538bf2bce557c3b5fe8c59b034d45352500db1 ).
>
> v2:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065649.html
> v1:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065517.html
>
>  * Changed "altset_idx" to "altsetting" thanks to Clemens' clarification.
>
>  #3: Thanks to Daniel's test, fixed a NULL dereference caused by userspace
> calling
>      snd_pcm_open() and then snd_pcm_close() immediately.
>  #8: subs->altset_idx was left intact, since it corresponds to the array
> index.
>  #10: this patch now removed subs->altset_idx, but also changes the check
> to be
>       performed against fmt->altsetting.
>  #11: New. This changes the name of snd_usb_endpoint member alt_idx to
> altsetting
>       for the same reason Clemens described.
>
> Clemens and Daniel - thank you very much for your help!
>
> Cheers,
> Eldad
>
> Eldad Zack (11):
>   ALSA: usb-audio: remove unused parameter from sync_ep_set_params
>   ALSA: usb-audio: remove deactivate_endpoints()
>   ALSA: usb-audio: prevent NULL dereference on stop trigger
>   ALSA: usb-audio: don't deactivate URBs on in-use EP
>   ALSA: usb-audio: void return type of snd_usb_endpoint_deactivate()
>   ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on error
>   ALSA: usb-audio: correct ep use_count semantics (add set_param flag)
>   ALSA: usb-audio: conditional interface altsetting
>   ALSA: usb-audio: conditional concurrent usage of endpoint
>   ALSA: usb-audio: remove altset_idx from snd_usb_substream
>   ALSA: usb-audio: rename alt_idx to altsetting
>
>  sound/usb/card.h     |   4 +-
>  sound/usb/endpoint.c |  82 ++++++++++++++++++-------
>  sound/usb/endpoint.h |  11 +++-
>  sound/usb/pcm.c      | 168
> ++++++++++++++++++++++++++++++++++++++-------------
>  sound/usb/pcm.h      |   2 +
>  sound/usb/proc.c     |   4 +-
>  6 files changed, 201 insertions(+), 70 deletions(-)
>
> --
> 1.8.1.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Martynov Nikolay.
Email: mar.kolya@gmail.com
