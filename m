From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Implement loopback control
 switch for Realtek and other codecs
Date: Thu, 10 Dec 2015 15:07:23 +0800
Message-ID: <CAN8cciZiqKyCDpm8b5u26-11UpjKaNk+MBQ6_=CuoR08dQ99_g@mail.gmail.com>
References: <1449591011-21360-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C1C1261721
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 08:07:23 +0100 (CET)
Received: by lbbkw15 with SMTP id kw15so44102615lbb.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2015 23:07:23 -0800 (PST)
In-Reply-To: <1449591011-21360-1-git-send-email-tiwai@suse.de>
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

2015-12-09 0:10 GMT+08:00 Takashi Iwai <tiwai@suse.de>:

> Many codecs, typically found on Realtek codecs, have the analog
> loopback path merged to the secondary input of the middle of the
> output paths.  Currently, we don't offer the dynamic switching in such
> configuration but let each loopback path mute by itself.
>
> This should work well in theory, but in reality, we often see that
> such a dead loopback path causes some background noises even if all
> the elements get muted.  Such a problem has been fixed by adding the
> quirk accordingly to disable aamix, and it's the right fix, per se.
> The only problem is that it's not so trivial to achieve it; user needs
> to pass a hint string via patch module option or sysfs.
>
> This patch gives a bit improvement on the situation: it adds "Loopback
> Mixing" control element for such codecs like other codecs (e.g. IDT or
> VIA codecs) with the individual loopback paths.  User can turn on/off
> the loopback path simply via a mixer app.
>
> For keeping the compatibility, the loopback is still enabled on these
> codecs.  But user can try to turn it off if experiencing a suspicious
> background or click noise on the fly, then build a static fixup later
> once after the problem is addressed.
>
> Other than the addition of the loopback enable/disablement control,
> there should be no changes.
>

How about the amp in at those mixers of surround jacks / mio jacks ?
