From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: snd-usb: tighten EP_FLAG_RUNNING
 checks
Date: Thu, 12 Jul 2012 16:29:12 +0200
Message-ID: <4FFEDF38.7060808@ladisch.de>
References: <1342099187-6978-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E5D0E2448A
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 16:29:15 +0200 (CEST)
In-Reply-To: <1342099187-6978-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, philipp@dreimann.net, joseph.salisbury@canonical.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> In endpoint.c, bail out earlier in case the stream is stopped.
> ...
> @@ -350,7 +350,8 @@ static void snd_complete_urb(struct urb *urb)
>  		     urb->status == -ENODEV ||		/* device removed */
>  		     urb->status == -ECONNRESET ||	/* unlinked */
>  		     urb->status == -ESHUTDOWN ||	/* device disabled */
> -		     ep->chip->shutdown))		/* device disconnected */
> +		     ep->chip->shutdown) ||		/* device disconnected */
> +		     !test_bit(EP_FLAG_RUNNING, &ep->flags))
>  		goto exit_clear;

Is this really needed?
The URBs will be unlinked at the same time.


Regards,
Clemens
