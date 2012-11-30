From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Fri, 30 Nov 2012 15:21:42 +0800
Message-ID: <CAN8ccibE0xEpOTPwLrFAJbypSnO4jdaAHRK3L=_bqHFY1ATepA@mail.gmail.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3378C2615E8
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 08:21:43 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so90334qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 23:21:42 -0800 (PST)
In-Reply-To: <1354202489-12769-5-git-send-email-tiwai@suse.de>
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
> HP Z220 with ALC221 codec has a front jack that should work as both
> the front mic and the secondary headphone.  This patch adds a new
> mixer enum to change the jack behavior.
>
> In the headphone mode, the auto-mic switching is disabled and the
> input is fixed to the rear line-in.
>

I expect when any input jack(line in or mic) is retasked as output e.g.
alc_set_multi_io() the corresponding jack detection kcontrol should change
to false
