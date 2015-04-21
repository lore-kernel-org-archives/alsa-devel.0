From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Tue, 21 Apr 2015 11:58:54 +0200
Message-ID: <CABFtUbS_TTGgfOVLE=hnm73=8Gmg4jKG+8-_5uNFDPieg-sNvg@mail.gmail.com>
References: <23057263.IjMh4t6SYF@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 024642606F4
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 11:58:56 +0200 (CEST)
Received: by qgdy78 with SMTP id y78so65698481qgd.0
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 02:58:54 -0700 (PDT)
In-Reply-To: <23057263.IjMh4t6SYF@xps13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-04-19 19:26 GMT+02:00 Gabriele Mazzotta <gabriele.mzt@gmail.com>:
> Hi,
>
> I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
> command verb caches, too") is somehow causing a pop noise on startup
> when headphones are plugged in, but I couldn't figure out the exact
> cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> Realtek ALC3661)? Does anyone have any idea of what the cause might be?


Small update: I found that if I add a printk in alc_shutup_dell_xps13()
or I increase the delay from 20ms to 200ms, I get the pop noise on
start, with or without a551d91473 reverted. I will try to find out what
this delay is exactly affecting.
