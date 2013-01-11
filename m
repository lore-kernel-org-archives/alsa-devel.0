From: Jens Axboe <axboe@kernel.dk>
Subject: Re: Oops in sound/usb/pcm.c:match_endpoint_audioformats() in current
 -git
Date: Fri, 11 Jan 2013 08:47:25 +0100
Message-ID: <50EFC38D.80306@kernel.dk>
References: <50EE7A94.60409@kernel.dk> <s5hobgx72zf.wl%tiwai@suse.de> <50EEB8D2.2030702@kernel.dk> <s5hsj696tgw.wl%tiwai@suse.de> <alpine.LNX.2.00.1301102038560.1321@xoschi> <s5hehhskcya.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hehhskcya.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Eldad Zack <eldad@fogrefinery.com>, perex@perex.cz, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2013-01-10 21:19, Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: usb-audio: Fix NULL dereference by access to
>  non-existing substream
> 
> The commit [0d9741c0: ALSA: usb-audio: sync ep init fix for
> audioformat mismatch] introduced the correction of parameters to be
> set for sync EP.  But since the new code assumes that the sync EP is
> always paired with the data EP of another direction, it triggers Oops
> when a device only with a single direction is used.
> 
> This patch adds a proper check of sync EP type and the presence of the
> paired substream for avoiding the crash.
> 
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Confirmed, it works. You can add my tested-by too. Thanks Takashi!

-- 
Jens Axboe
