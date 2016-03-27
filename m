From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: dice: fix a fatal bug when no
 sound card is registered
Date: Mon, 28 Mar 2016 08:14:51 +0900
Message-ID: <56F8696B.8000704@sakamocchi.jp>
References: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 188CC2619D7
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 01:14:55 +0200 (CEST)
In-Reply-To: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 26 2016 21:05, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset is for Linux 4.6-rc2.
> 
> ALSA dice driver causes kernel NULL pointer dereference in a case that
> no sound card instance is registered and unit is going to be removed.
> This is observed when dice-based units are connected to Linux system and
> disconnected within 2 seconds, thus it's rare.
> 
> Additionally, even if the bug is fixed, the driver dumps warnings for
> most dice-based models which supports a pair of isochronous streams.
> This can occur regardless of the former bug. Users can see this for
> unsupported dice-based models.
> 
> This patchset fixes these bugs.

I realized that this patchset is not proper to Linux 4.6-rc2. The stream
data is confirmed to initialized in unit probe callback, and safely
released when releasing private data. I worked on the other branch and
had a confusion. So please drop this.

However, current ALSA dice driver has a bug not to release stream data
when releasing private data. This causes memory leak and should be fixed
in 4.6-rc2. I'll post a patch for the bug soon.

(I'd like to get the reason I often realize such mistakes just after
getting up in the morning, the beginning of a day, sign...)


Regards

Takashi Sakamoto

> Takashi Sakamoto (2):
>   ALSA: dice: fix NULL pointer dereference at remove units when sound
>     card is not registered
>   ALSA: firewire-lib: skip releasing stream data when it's not
>     initialized
> 
>  sound/firewire/amdtp-stream.c     |  4 ++++
>  sound/firewire/dice/dice-stream.c | 14 ++++----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
