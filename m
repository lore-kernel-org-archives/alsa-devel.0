From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: PulseAudio and softvol
Date: Wed, 15 May 2013 15:25:44 +0530
Message-ID: <1368611744.6590.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id D38A02608D3
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 11:55:45 +0200 (CEST)
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
Cc: pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hello,
A number of users have intermittently(?) been hitting a crash in
alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
reproduce this reliably, so can't find an easy way to debug/fix.

However, this raises a tangential question - why do we need softvol to
be plugged for 'front' at all? David explained to me that this is to
guarantee the existence of a PCM control. Perhaps I don't fully
understand this, because I'm unconvinced by the reason. Could someone
explain/refute?

This is especially bad for us, from PulseAudio's perspective, because we
aren't getting a zero-copy path.

Cheers,
Arun

[1] https://bugzilla.redhat.com/show_bug.cgi?id=953352
[2] https://bugs.freedesktop.org/show_bug.cgi?id=64299
