From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] PulseAudio and softvol
Date: Wed, 15 May 2013 16:34:26 +0000
Message-ID: <CAN8cciYV_4LJku4uUDpMX7svR+fOhvbZO0nKsTbD--iw15ndhw@mail.gmail.com>
References: <1368611744.6590.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id B89D426167E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:34:27 +0200 (CEST)
Received: by mail-ie0-f182.google.com with SMTP id a14so4197386iee.27
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 09:34:27 -0700 (PDT)
In-Reply-To: <1368611744.6590.8.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Hello,
> A number of users have intermittently(?) been hitting a crash in
> alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
> reproduce this reliably, so can't find an easy way to debug/fix.
>
> However, this raises a tangential question - why do we need softvol to
> be plugged for 'front' at all? David explained to me that this is to
> guarantee the existence of a PCM control. Perhaps I don't fully
> understand this, because I'm unconvinced by the reason. Could someone
> explain/refute?

Because  alc660 codec did not has any hardware volume control on the output

http://www.alsa-project.org/db/?f=a327b0925a1697d60ea427fe3f16821d7ef7030b
