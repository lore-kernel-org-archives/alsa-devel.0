From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: control: add dimension validator
 for userspace element
Date: Wed, 6 Jul 2016 23:18:48 +0900
Message-ID: <577D1348.3040706@sakamocchi.jp>
References: <1467371413-16895-1-git-send-email-o-takashi@sakamocchi.jp>
 <1467371413-16895-3-git-send-email-o-takashi@sakamocchi.jp>
 <57766231.6060304@sakamocchi.jp> <s5hh9c8qxq3.wl-tiwai@suse.de>
 <577D029D.9090701@sakamocchi.jp> <s5h60sizy7w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 9DF1B2657FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 16:18:54 +0200 (CEST)
In-Reply-To: <s5h60sizy7w.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jul 6 2016 22:34, Takashi Iwai wrote:
> Yes, a validation of info->count is a good idea.
> And it can be even a simple WARN_ON().  It's a clear driver bug and
> it's better to be exposed as loudly as possible.

OK.

Then another question. The same function, snd_ctl_elem_info() uses a
combination of  at CONFIG_SND_DEBUG and snd_BUG_ON() to detect
info->access bug of each driver.

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c#n823

I guess that this is an assertion that each driver must not touch
info->access in its implementations of 'snd_kcontrol_info_t'. On the
other hand, the detection is just enabled at CONFIG_SND_DEBUG.

To me, it's strange, because ALSA control core changes its behaviour
depending on CONFIG_SND_DEBUG. If the option is off, buggy driver works.
Else, it brings kernel panic. This is quite confusing to both developers
of each driver and userspace applications.

In ALSA kernel/userspace interfaces, info->access is described as read-only.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h#n886

Therefore, I think it better to set zero in advance of calling
'snd_kcontrol_info_t' then check the return value with WARN_ON macro,
regardless of CONFIG_SND_DEBUG.

Or should I apply snd_WARN_ON() or snd_BUG_ON() to validators of
info->type and info->count to keep code consistency?


Regards

Takashi Sakamoto
