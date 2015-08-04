From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/2] ALSA: fireworks/firewire-lib: add
 support for recent firmware quirk
Date: Wed, 05 Aug 2015 03:33:52 +0900
Message-ID: <55C10590.4040202@sakamocchi.jp>
References: <1438645251-13252-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ED0D260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 20:34:01 +0200 (CEST)
In-Reply-To: <1438645251-13252-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: johannes.oertel@uni-due.de, alsa-devel@alsa-project.org, harryhaaren@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 04 2015 08:40, Takashi Sakamoto wrote:
> Some users have reported current ALSA Fireworks driver stops packet
> streaming due to detecting discontinuity.
> 
> [alsa-devel] ALSA snd-fireworks Echo AudioFire 2
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080379.html
> 
> [alsa-devel] AudioFire4 quirk
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/095697.html
> 
> As long as I investigate, this issue depends on firmware version installed
> in these devices. While, it's not clear that which version of firmwares for
> which model has this quirk. At least, firmware version 5.7.0, 5.7.3 and
> 5.8.0 for AudioFire2/AudioFire4/AudioFirePre8 have this quirk.
> 
> This patchset applies a solution for this issue, with my assumption that
> 'the same firmware binary has the same quirk'. These models, AudioFire8
> (since Jul 2009) and Gibson Robot Interface Pack (RIP) series uses the
> same firmware binary in driver package.
> 
> Takashi Sakamoto (2):
>   Revert "ALSA: fireworks: add support for AudioFire2 quirk"
>   ALSA: fireworks/firewire-lib: add support for recent firmware quirk
> 
>  sound/firewire/amdtp.c                      |  5 +++--
>  sound/firewire/amdtp.h                      |  2 ++
>  sound/firewire/fireworks/fireworks.c        | 10 ++++++++--
>  sound/firewire/fireworks/fireworks.h        |  2 +-
>  sound/firewire/fireworks/fireworks_stream.c | 12 +++++++++---
>  5 files changed, 23 insertions(+), 8 deletions(-)

I pushed 'fireworks3-quirk' branch to my repository. It's nice to test
with your models if you have a enough time.
https://github.com/takaswie/snd-firewire-improve/tree/fireworks3-quirk

In this repository, another developing line is running (amdtp-variants).
I have a plan to post a part of them in this kernel developing cycle.


Regards

Takashi Sakamoto
