From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire-lib: remove
	rx_blocks_for_midi quirk
Date: Wed, 26 Nov 2014 23:22:09 +0900
Message-ID: <5475E211.3040106@sakamocchi.jp>
References: <5474FA18.7000501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 053282652C3
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 15:22:14 +0100 (CET)
In-Reply-To: <5474FA18.7000501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

On Nov 26 2014 06:52, Clemens Ladisch wrote:
> There are several devices that expect to receive MIDI data only in the
> first eight data blocks of a packet.  If the driver restricts the data
> rate to the allowed rate (as mandated by the specification, but not yet
> implemented by this driver), this happens naturally.  Therefore, there
> is no reason to ever try to use more data packets with any device.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
>  sound/firewire/amdtp.c                      |   10 +++++++---
>  sound/firewire/amdtp.h                      |    3 ---
>  sound/firewire/bebob/bebob_stream.c         |    7 -------
>  sound/firewire/fireworks/fireworks_stream.c |    5 -----
>  4 files changed, 7 insertions(+), 18 deletions(-)

Can I ask your opinion about applying this patch to devices with
non-blocking mode? At least, your comment of this patch is for blocking
mode (the fixed number of data blocks in a packet).


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
