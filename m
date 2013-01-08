From: Maurizio Avogadro <mavoga@gmail.com>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel
 codec probing issue?
Date: Tue, 08 Jan 2013 09:23:14 +0100
Message-ID: <50EBD772.3090008@gmail.com>
References: <1356704740.3953.26.camel@lamella> <s5hvcber5cz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B6156261655
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 10:24:22 +0100 (CET)
Received: by mail-bk0-f46.google.com with SMTP id q16so94638bkw.19
 for <alsa-devel@alsa-project.org>; Tue, 08 Jan 2013 01:24:22 -0800 (PST)
In-Reply-To: <s5hvcber5cz.wl%tiwai@suse.de>
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

Takashi Iwai <tiwai <at> suse.de> writes:

> [...]
>
> If it's new in 3.7, this could be a regression by runtime D3.
> Try to pass power_save_controller=0 option to snd-hda-intel module
> (or change it via sysfs dynamically).
>
> thanks,
>
> Takashi

Hi Takashi

same codec here (ALC269VB on a Clevo W150HRM), same kernel, same issue.
Disabling power_save_controller solves the issue, but I could achieve
the same result by setting enable_msi=0, which I chose in the hope to
preserve power saving capabilities.

thanks, Maurizio
