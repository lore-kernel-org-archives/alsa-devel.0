From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: calling snd_ctl_notify from mixer ctl_put
Date: Fri, 12 Oct 2012 08:03:13 +0200
Message-ID: <5077B2A1.5070608@ladisch.de>
References: <201210112129.03097.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B2DF026036F
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 08:03:15 +0200 (CEST)
In-Reply-To: <201210112129.03097.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ondrej Zary wrote:
> I want to enable/disable some mixer controls based on state of another control
> (switching between limiter and AGC mode). So I (re)set the
> SNDRV_CTL_ELEM_ACCESS_INACTIVE flag in kctl->vd[0].access
> and then call snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &kctl->id);
> Everyting from ctl_put() mixer callback.
>
> When changing the control value in alsamixer, it crashes with:
> alsamixer: simple.c:948: snd_mixer_selem_get_enum_item: Assertion
> `(elem)->type == SND_MIXER_ELEM_SIMPLE' failed.

Looks like a bug in alsamixer.


Regards,
Clemens
