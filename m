From: "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-devel] [PATCH] ALSA: firewire: fix a memory leak bug
Date: Thu, 08 Aug 2019 18:04:03 +0900
Message-ID: <ce36089b-7061-4cd1-8262-eb3393c753af@www.fastmail.com>
References: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: open list <linux-kernel@vger.kernel.org>, "moderated list:FIREWIRE AUDIO DRIVERS" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Aug 8, 2019, at 14:53, Wenwen Wang wrote:
> In iso_packets_buffer_init(), 'b->packets' is allocated through
> kmalloc_array(). Then, the aligned packet size is checked. If it is
> larger than PAGE_SIZE, -EINVAL will be returned to indicate the error.
> However, the allocated 'b->packets' is not deallocated on this path,
> leading to a memory leak.
> 
> To fix the above issue, free 'b->packets' before returning the error code.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  sound/firewire/packets-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

And this bug exists till its first commit for v2.6.39.

Fixes: 31ef9134eb52 ("ALSA: add LaCie FireWire Speakers/Griffin FireWave Surround driver")
Cc: <stable@vger.kernel.org> # v2.6.39+


Thanks

Takashi Sakamoto
