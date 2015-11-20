From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] ALSA: dice: constrain PCM
 substreams to current sampling transfer frequency
Date: Fri, 20 Nov 2015 13:11:24 +0900
Message-ID: <564E9D6C.7060408@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8qbe6pm.wl-tiwai@suse.de> <564D4360.8050503@sakamocchi.jp>
 <s5hziyab8ak.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id DC8322605C3
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 05:11:27 +0100 (CET)
In-Reply-To: <s5hziyab8ak.wl-tiwai@suse.de>
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

Hi,

On Nov 19 2015 19:19, Takashi Iwai wrote:
> More specifically, although this patchset can be seen as a "bug fix",
> the bug you're trying to address isn't clear.  And then, what impact
> this patchset has for users isn't described enough.  If there is no
> usage change, it should be mentioned clearly.  If any usage change is
> expected, it must be written.

I have frequently got private messages from owners of dice-based models
since below patchset was merged to mainline, .

[alsa-devel] [PATCH 00/15 v5] ALSA: Enhancement for existed FireWire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085142.html

Some of them addressed that ALSA dice driver fails to handle their
models. Their experiences are not the same. The summary:
 * detecting packet discontinuity at starting streaming
 * ETIMEOUT at starting streaming
 * ETIMEOUT at probing snd-dice
 * no sound even if streaming

This patchset is my solution for the issues. In my understanging, the
packet discontinuity means that clock generator is not phase-locked, and
it costs higher for some models to change the state of clock. The
ETIMEOUT means that the driver receive no notification till timeout, and
implies the occurence of bus-resets. A part of reasons of no-sound issue
is a mismatch of data channel formation in AMDTP packet, and implies
failure in probe processing. All of them indicate that it easily occurs
to fail to change the state of clock. For the detail, I hope readers to
read comments in this patchset.

As a result of applying this patchset, userspace applications cannot
start PCM substreams at sampling rates except for current sampling
transfer frequency. Instead, they gain stability to start PCM substreams
and to probe Dice-based models.

At a glance, it looks the backwards or the regressions. But I believe we
should not ignore hardware design, as a device driver developer.


Regards

Takashi Sakamoto
