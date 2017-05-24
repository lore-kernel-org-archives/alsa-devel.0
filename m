From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RFC 00/11] ALSA: pcm: introduce copy_frame
 operation and SND_PCM_PROXY_DRIVER_SUPPORT
Date: Wed, 24 May 2017 23:19:06 +0900
Message-ID: <957eb033-50b4-c952-59fe-e2dc347a6bde@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
 <s5hr2zen4xj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 9FC5B26680F
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 16:19:10 +0200 (CEST)
In-Reply-To: <s5hr2zen4xj.wl-tiwai@suse.de>
Content-Language: en-US
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

Hi,

On May 24 2017 15:29, Takashi Iwai wrote:
> OK, I now understand your idea.  Actually the word "proxy" was
> misleading.  "proxy" implies the action, but PCM core can't know the
> action the caller intended.  From PCM core POV, it's merely an
> in-kernel buffer copy.  We don't need to invent new terms here (who is
> the client?).

Currently, I have no idea for the better term.

Data transmission is a kind of communication, thus there's a originator. 
I use the 'client' as the originator. Usually, userspace applications 
are the client, however in addressed issue in-kernel OSS/UAC1 drivers 
are the client. They perform as a proxy for their direct clients.

> Apart from that, basically your idea is:
> - Keep in-kernel buffer copy flag into substream->runtime.
> - The ops handles both copy and silence.
> - Move the whole transfer action to each driver instead of looping in
>    PCM core.
> 
> I find the first point is acceptable, from the current usage pattern,
> as there is little chance to mix up both user-space buffer and
> kernel-space buffer.

Practically, it's rarely for clients to request copy operation for 
source or destination on several memory spaces.

> Though, another side of coin is that, by embedding in runtime, you can
> easily overlook the in-kernel copy case, in comparison with passing
> via the argument.  So it's not always plus.

However, in current place, drivers with kernel/kernel copying is quite 
rare. At least, they're not major ones. Features for them should be 
selectable by configurations. In this point, such argument-oriented 
implementation is exaggerated for the features. It's not worth to change 
existent kernel APIs.

> The second point is as same as mine.
> 
> The potential problem is the third point.  It'd require a larger
> change, and it's error-prone, because you'll have to translate the
> passed pointer in each driver to morph it to different values, either
> the linear buffer pointer or the vector, in addition to the user-space
> and kernel-space check.
> 
> In the PCM core code, we did that in that way, but it's OK since it's
> done only there thus it's manageable.  However, forcing the complex
> cast in each driver implementation is better to avoid.
> 
> How to make each driver implementing less error-prone codes -- that's
> what we need to reconsider further.

I have no objection for your view. It's natural idea for software 
developers.

Essentially, it's not better idea to produce one callback function for 
two types of buffer access. Type casting is enough dangerous and make it 
hard to trace arguments, but current PCM core implementation heavily 
utilizes it. I can assume to add two callback operations to driver 
programming API; for interleaved buffer and non-interleaved buffer.


...but I'd like to postpone this discussion enough later (next week), 
because we have several patches worth to be merged[1][2][3]. 
Furthermore, patch 03-05 in this patchset are valuable as a refactoring 
(of course need to be revised), independent of the discussion. I suggest 
to put our priority to merging/reviewing them in this week, if you don't 
mind. After arranging code bases with better shape, we can continue the 
discussion with a calm mind.

There's no need to jump.

[1] [alsa-devel] [PATCH 0/7] ALSA: Fix/improve PCM ack callback
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120886.html
[2] [alsa-devel] [PATCH] ALSA: gus: remove unused local flag
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120967.html
[3] [alsa-devel] [PATCH] ALSA: sb: remove needless evaluation in 
implementation for copy callback
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120968.html


Thanks

Takashi Sakamoto
