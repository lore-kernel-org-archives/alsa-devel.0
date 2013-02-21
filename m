From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 108/112] ALSA: hda - Fix multi-io channel
 mode management
Date: Thu, 21 Feb 2013 16:03:51 +0800
Message-ID: <CAN8ccibPwb2SbSzb_SBHk9LEiQ-Ec5P9KkbLb5wLVSZ6Ecn+YA@mail.gmail.com>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
 <1357645185-7645-109-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id D32802602C7
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 09:03:52 +0100 (CET)
Received: by mail-ie0-f172.google.com with SMTP id c10so11118719ieb.31
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 00:03:51 -0800 (PST)
In-Reply-To: <1357645185-7645-109-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alex.baldacchino.alsasub@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> The multi-io channels can vary not only from 1 to 6 but also may vary
> from 6 to 8 or such.  At the same time, there are more speaker pins
> available than the primary output pins.  So, we need three variables
> to check: the minimum channel counts for primary outputs, the current
> channel counts for primary outputs, and the minimum channel counts for
> all outputs.
>

Under which condition will the driver create the 6 / 8 channel mode control
?

An unused DAC

desktop with 5 jacks at rear panel and retask Blue Line In jack as output
Jack for side channel (AsRock
890GX Extreme3)
