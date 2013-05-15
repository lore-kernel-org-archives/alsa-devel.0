From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PulseAudio and softvol
Date: Wed, 15 May 2013 12:26:51 +0200
Message-ID: <519362EB.7050603@perex.cz>
References: <1368611744.6590.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 51BAF2610C4
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 12:26:53 +0200 (CEST)
In-Reply-To: <1368611744.6590.8.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Date 15.5.2013 11:55, Arun Raghavan wrote:
> Hello,
> A number of users have intermittently(?) been hitting a crash in
> alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
> reproduce this reliably, so can't find an easy way to debug/fix.

The problem is that the offsets are not in sync in this case [1]:

src_offset = 38560
dst_offset = 38568
frames = 16374

Could you reproduce this bug in any way? At least snd_pcm_dump() before
the failing snd_pcm_mmap_commit() call might help to determine what was
the status before the assert() was entered.

> However, this raises a tangential question - why do we need softvol to
> be plugged for 'front' at all? David explained to me that this is to
> guarantee the existence of a PCM control. Perhaps I don't fully
> understand this, because I'm unconvinced by the reason. Could someone
> explain/refute?
> 
> This is especially bad for us, from PulseAudio's perspective, because we
> aren't getting a zero-copy path.

If the softvol is set to 0dB (no attenuation or gain), then the ring
buffer pointers are moved without any sample processing, so the
zero-copy functionality is kept.

					Jaroslav

> 
> Cheers,
> Arun
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=953352
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=64299

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
