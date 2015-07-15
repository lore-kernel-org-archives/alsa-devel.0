From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Softvol: Allow per process volume control.
Date: Thu, 16 Jul 2015 00:46:25 +0900
Message-ID: <55A68051.2050905@sakamocchi.jp>
References: <20150709032406.12952.5374@spalge.com>
 <s5hlhehn0ng.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C16A265D42
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 17:46:31 +0200 (CEST)
In-Reply-To: <s5hlhehn0ng.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jimmy <jimmy@spalge.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 15 2015 20:03, Takashi Iwai wrote:
> Also, removal of the ctl element is voluntarily done, that is, if a
> program aborts in the middle, it leaves the ctl element.  If we want
> the implementation with the user-space ctl element, it'd be better to
> have a support in kernel side to manage the life cycle of ctl element
> more safely.

I'm interested in this idea about the life cycle of ctl elements added
by userspace applications. (Of cource, interested in per-process volume
control for dmix PCM plugins, itself. Sorry to start another discussion
in this thread...)

My headache is 'struct snd_kcontrol.owner'. In kernel land, this member
is used to distinguish whether the control element is locked or not,
against its name.

This implementation cannot allows control elements to keep PID which has
added the control element. If a control element has lost the PID, snd
module cannot release it when a process with the PID closes ALSA ctl
character device.

Well, if adding members for owner's PID and lock state, and keep enough
backward-compatibility to userspace, we can achieve the idea, I think.


Regards

Takashi Sakamoto
