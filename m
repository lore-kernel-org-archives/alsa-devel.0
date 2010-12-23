From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH v7 01/12] media: Media device node
	support
Date: Wed, 22 Dec 2010 19:34:54 -0800
Message-ID: <20101223033454.GC14692@suse.de>
References: <1292844995-7900-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1292844995-7900-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7721F247A2
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 04:34:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292844995-7900-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 12:36:24PM +0100, Laurent Pinchart wrote:
> +/*
> + * Flag to mark the media_devnode struct as registered. Drivers must not touch
> + * this flag directly, it will be set and cleared by media_devnode_register and
> + * media_devnode_unregister.
> + */
> +#define MEDIA_FLAG_REGISTERED	0

It's a define, not a flag, or anything that any driver could touch.

And if you don't want anyone to touch the thing, then make it private
and unable to be touched by anyone else.  Otherwise it will be
touched...

thanks,

greg k-h
