From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Wed, 23 Jan 2013 16:55:09 +0800
Message-ID: <CAN8cciaXbeyCJsOf5v2q7vunb1VrE8-0hYFXBZeAk9pd+dychA@mail.gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE0F2651DC
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 09:55:10 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id s9so13104969iec.41
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 00:55:09 -0800 (PST)
In-Reply-To: <s5hbocg1etr.wl%tiwai@suse.de>
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
> as most of feedbacks about the new generic parser migration were
> positive, I decided to take a risk: now all commit that have been in
> test/hda-migrate branch in sound-unstable git tree are merged to
> for-next branch of sound git tree for better test coverage.
> It means that all changes are merged to linux-next, i.e. will be
> included in 3.9 kernel.
>
> For the early adapter people, I'm going to keep test/hda-migrate
> branch of sound-unstable git tree updated for a while, but the branch
> will be abandoned some time later.
>
> If you encounter any regression by the recent update, please let me
> know.
>

Neither alsa-info.sh nor system log provide any info when user has
customised those hints

Some feature is only available when the hardware meet minimum requirement

e.g. independent headphone require at least two DAC
