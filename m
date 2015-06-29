From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix the dock headphone output
 on Fujitsu Lifebook E780
Date: Mon, 29 Jun 2015 21:36:30 +0800
Message-ID: <CAN8ccibVDe-meQAbPs8Vqt=-FVbWf6W8UNnxshwjf6T+xmpNNA@mail.gmail.com>
References: <1435560145-20621-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 490B1260567
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 15:36:32 +0200 (CEST)
Received: by oigx81 with SMTP id x81so117834730oig.1
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 06:36:31 -0700 (PDT)
In-Reply-To: <1435560145-20621-1-git-send-email-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Fujitsu Lifebook E780 sets the sequence number 0x0f to only only of
> the two headphones, thus the driver tries to assign another as the
> line-out, and this results in the inconsistent mapping between the
> created jack ctl and the actual I/O.  Due to this, PulseAudio doesn't
> handle it properly and gets the silent output.
>
> The fix is to ignore the non-HP sequencer checks.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=99681

Should driver create dock headphone playbavk switch and headphone playback
volume for headphone and dock headphone ?

This allow pulseaudio/user to mute dock headphone
