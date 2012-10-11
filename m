From: Ondrej Zary <linux@rainbow-software.org>
Subject: calling snd_ctl_notify from mixer ctl_put
Date: Thu, 11 Oct 2012 21:29:02 +0200
Message-ID: <201210112129.03097.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E2A26529A
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 21:29:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hello,
I want to enable/disable some mixer controls based on state of another control 
(switching between limiter and AGC mode). So I (re)set the 
SNDRV_CTL_ELEM_ACCESS_INACTIVE flag in kctl->vd[0].access
and then call snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &kctl->id);
Everyting from ctl_put() mixer callback.

When changing the control value in alsamixer, it crashes with:
alsamixer: simple.c:948: snd_mixer_selem_get_enum_item: Assertion 
`(elem)->type == SND_MIXER_ELEM_SIMPLE' failed.

When the snd_ctl_notify() call is commented-out, it does not crash.

There is snd_ctl_activate_id() function in sound/core/control.c (not used by 
any driver, btw.) which does the same, protected by card->controls_rwsem. 
However, it locks up on that semaphore when called from the mixer callback.

Oxygen/Xonar WM8776 driver is doing the same thing - I wonder if I'm doing 
something wrong or if that driver crashes alsamixer too?

Is there any way to do this properly?

-- 
Ondrej Zary
