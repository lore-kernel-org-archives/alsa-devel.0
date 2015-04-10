From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: hda/generic - Fix wrong initial
 power state for fixed pins
Date: Fri, 10 Apr 2015 16:51:58 +0800
Message-ID: <CAN8cciZOCokwQmgciiSiKQiatNtn4UkJyUyVCM3N0J64PMbvEg@mail.gmail.com>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
 <1428568838-21550-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD1A265FE9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 10:51:59 +0200 (CEST)
Received: by obbeb7 with SMTP id eb7so7922127obb.3
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 01:51:58 -0700 (PDT)
In-Reply-To: <1428568838-21550-3-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> When the widget power-saving is enabled, the first automute hook
> invocation checks through the whole pins and it also tries to
> synchronize the power state.  However, this results in a wrong state
> because it calls unconditionally snd_hda_jack_detect_state().
> This patch adds a check of jack detectability before the actual jack
> detection call.

What happen when the computer has no headphone jack ?

No mic jack and internal mic

Those  thin mini itx motherboard use firmware to disable mixer and remove
all input pins

# Prevent the AA-loopback from being enabled which can pull in white noise
(ACI#380)
[hint]
mixer_nid = 0

Will the driver still power down the audio mixer and audio inputs ?

Seem driver still create capture device when there is no input pins

https://bugs.freedesktop.org/show_bug.cgi?id=54881#c16

https://bugs.freedesktop.org/show_bug.cgi?id=54881#c16
