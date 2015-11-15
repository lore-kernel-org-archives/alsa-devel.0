From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Sound: Usb: Misc: ua101: replace
	le16_to_cpu() with	usb_endpoint_maxp()
Date: Sun, 15 Nov 2015 14:54:28 +0100
Message-ID: <56488E94.1030609@ladisch.de>
References: <1447536690-25173-1-git-send-email-thrust73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DCA2A26062B
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 14:55:25 +0100 (CET)
In-Reply-To: <1447536690-25173-1-git-send-email-thrust73@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: Cheah Kok Cheong <thrust73@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Cheah Kok Cheong wrote:
> Commit 939f325f4a0f ("usb: add usb_endpoint_maxp() macro")
>
> And commit 29cc88979a88 ("USB: use usb_endpoint_maxp()
> instead of le16_to_cpu()")

These sentences no verb.

> Patched against
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

This does not belong into the commit message.

> Signed-off-by: Cheah Kok Cheong <thrust73@gmail.com>

Otherwise:
Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/usb/misc/ua101.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
> index 9581089..c19a5dd 100644
> --- a/sound/usb/misc/ua101.c
> +++ b/sound/usb/misc/ua101.c
> @@ -1037,7 +1037,7 @@ static int detect_usb_format(struct ua101 *ua)
>  		return -ENXIO;
>  	}
>  	ua->capture.usb_pipe = usb_rcvisocpipe(ua->dev, usb_endpoint_num(epd));
> -	ua->capture.max_packet_bytes = le16_to_cpu(epd->wMaxPacketSize);
> +	ua->capture.max_packet_bytes = usb_endpoint_maxp(epd);
>
>  	epd = &ua->intf[INTF_PLAYBACK]->altsetting[1].endpoint[0].desc;
>  	if (!usb_endpoint_is_isoc_out(epd)) {
> @@ -1045,7 +1045,7 @@ static int detect_usb_format(struct ua101 *ua)
>  		return -ENXIO;
>  	}
>  	ua->playback.usb_pipe = usb_sndisocpipe(ua->dev, usb_endpoint_num(epd));
> -	ua->playback.max_packet_bytes = le16_to_cpu(epd->wMaxPacketSize);
> +	ua->playback.max_packet_bytes = usb_endpoint_maxp(epd);
>  	return 0;
>  }
