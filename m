From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Thu, 24 Jan 2013 11:26:35 +0800
Message-ID: <CAN8cciZ=v=9MJwmTA9+AEBSJJnFGPQ+x3qZX2WVQdwTDBbK=8A@mail.gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de>
 <CAN8cciaXbeyCJsOf5v2q7vunb1VrE8-0hYFXBZeAk9pd+dychA@mail.gmail.com>
 <s5h4ni81d17.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DE00260311
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 04:26:38 +0100 (CET)
Received: by mail-ve0-f182.google.com with SMTP id pb11so1286004veb.41
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 19:26:37 -0800 (PST)
In-Reply-To: <s5h4ni81d17.wl%tiwai@suse.de>
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

>
> > Some feature is only available when the hardware meet minimum
requirement
> > e.g. independent headphone require at least two DAC
>
> Why it's a regression?
>

Those hda codecs  with a single DAC (e.g. stac920x, alc260) and ad1986a
does no support independent headphone

Also those alc66x datasheet does not mention the support of multi-streaming
playback

Don't create the control when there is internal speaker

When driver assign two DAC to internal speaker and subwoofer (vt1802 on
Asus g75) and it is confusing when there is no headphone playback volume
control

Don't create the control when there is no headphone Jack  when the user is
retasked  the headphone Jack to Mic by early patching

Automatically disable for those headphone mic  jack when the HP Jack is
retasked as mic
