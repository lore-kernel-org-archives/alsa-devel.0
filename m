From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH v2 1/1] ALSA: usb-audio: Add custom mixer
 status quirks for RME CC devices
Date: Fri, 5 Oct 2018 00:00:31 +0300
Message-ID: <99b2ea2f-00e6-52d5-ee39-1125736b0d7e@sonarnerd.net>
References: <20181004191743.20100-1-jussi@sonarnerd.net>
 <20181004191743.20100-2-jussi@sonarnerd.net> <s5hefd5lacy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 1569F267737
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 23:00:32 +0200 (CEST)
In-Reply-To: <s5hefd5lacy.wl-tiwai@suse.de>
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

On 04.10.2018 23:34, Takashi Iwai wrote:
> Rather include <linux/math64.h>, and put in the appropriate order.

Sorry, I had a bit of hard time finding the function in first place, but 
what is the appropriate order?

> Since you're calling in the same pattern, it's better to consider to
> provide a helper to call snd_usb_ctl_msg() with the given type (and
> shows the error there).  The helper can take snd_usb_lock_shutdown()
> and unlock in it, so it'll simplify a lot.

In first case I'm calling GET_STATUS1 and the lock surrounds that. In 
the second case I'm calling both GET_STATUS1 and GET_CURRENT_FREQ and 
the lock surrounds both calls togher. I didn't completely understand how 
to achieve this with the helper, unless you meant through some extra 
argument and control path inside?


	- Jussi
