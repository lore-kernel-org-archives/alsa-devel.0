From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Some questions about userspace control elements
Date: Thu, 05 Feb 2015 08:51:17 +0900
Message-ID: <54D2B075.4050005@sakamocchi.jp>
References: <54CE10D2.7090903@sakamocchi.jp> <54CE675A.80004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 940772605F5
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 00:51:24 +0100 (CET)
In-Reply-To: <54CE675A.80004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I find a curious issue about the userspace element. Could I ask you to
give some comments about

The code is this one line.

sound/core/control.c:1188
{{{
kctl.count = info->owner ? info->owner : 1;
}}}
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?id=6ccd93bdb989507717edb375d40534f1177822c5#n1188

In this code, the value in struct snd_ctl_elem_info.owner is assigned to
struct snd_kcontrol.count. The meaning of these two member is completely
different but assigned.

include/sound/control.h:67
{{{
struct snd_kcontrol {
...
unsigned int count;
...
};
}}}
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/sound/control.h?id=6ccd93bdb989507717edb375d40534f1177822c5#n67

include/uapi/sound/asound.h:851
{{{
struct snd_ctl_elem_info {
...
__kernel_pid_t owner;		/* owner's PID of this control */
...
};
};
}}}
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h?id=6ccd93bdb989507717edb375d40534f1177822c5#n851
(I wonder why the value with _kernel_pid type is exported to userspace...)

I guess that the reason is to limit the number of event generated when
the control element set is operated. Actually, my sample code reports
one event every time when operating the control element with 10 entries.
But I believe this is the different behaviour as the kernel control
elements do.

sound/core/control.c:257
{{{
kctl.count = ncontrol->count ? ncontrol->count : 1;
}}}
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?id=6ccd93bdb989507717edb375d40534f1177822c5#n257

For me, the behaviour of userspace control element is a bit strange. The
behaviour is legal as a control element?


Regards

Takashi Sakamoto
