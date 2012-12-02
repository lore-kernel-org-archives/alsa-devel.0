From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: hda - More generic auto-mic
 switching for Realtek codecs
Date: Sun, 2 Dec 2012 09:55:56 +0800
Message-ID: <CAN8cciYhX57p-ZQ1t9xym2pkiPNruEoFXD6jUOXDwWW651hQ3w@mail.gmail.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C22261743
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 02:55:58 +0100 (CET)
Received: by mail-ie0-f170.google.com with SMTP id k10so2834168iea.29
 for <alsa-devel@alsa-project.org>; Sat, 01 Dec 2012 17:55:57 -0800 (PST)
In-Reply-To: <1354202489-12769-3-git-send-email-tiwai@suse.de>
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
> Instead of limiting the automatic input-source selection only to the
> mics (internal, external and dock mics), allow it for generic inputs,
> e.g. switching between the rear line-in and the front mic.

the problem of addng line in jack to auto mic is line in does not has any
boost (gain) but most mic have a boost control

the other problem is those acer aspire 8930g notebook has internal 5.1
speakers and three jacks which can support external 5.1 speakers

it seem the the channel mode control limit the max channels to 2 when there
is internal 5.1 speaker

when channel mode is 6ch the mic jack is retasked as output and cannot be
used

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/943386
