From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] MAINTAINERS: update git tree for sound
	entries
Date: Fri, 3 May 2019 10:18:56 +0900
Message-ID: <20190503011855.GA30162@workstation>
References: <20190502172700.215737-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB337F80720
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 03:19:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190502172700.215737-1-zwisler@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ross Zwisler <zwisler@chromium.org>
Cc: alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, May 02, 2019 at 11:27:00AM -0600, Ross Zwisler wrote:
> Several sound related entries in MAINTAINERS refer to the old git tree
> at "git://git.alsa-project.org/alsa-kernel.git".  This is no longer used
> for development, and Takashi Iwai's kernel.org tree is used instead.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  MAINTAINERS | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

This is a good catch.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b5480..d373d976a9317 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3351,7 +3351,7 @@ F:	include/uapi/linux/bsg.h
>  BT87X AUDIO DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	Documentation/sound/cards/bt87x.rst
>  F:	sound/pci/bt87x.c
> @@ -3404,7 +3404,7 @@ F:	drivers/scsi/FlashPoint.*
>  C-MEDIA CMI8788 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/pci/oxygen/
>  
> @@ -5696,7 +5696,7 @@ F:	drivers/edac/qcom_edac.c
>  EDIROL UA-101/UA-1000 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/usb/misc/ua101.c
>  
> @@ -6036,7 +6036,7 @@ F:	include/linux/f75375s.h
>  FIREWIRE AUDIO DRIVERS
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/firewire/
>  
> @@ -11593,7 +11593,7 @@ F:	Documentation/devicetree/bindings/opp/
>  OPL4 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/drivers/opl4/
>  
> @@ -14490,7 +14490,6 @@ M:	Takashi Iwai <tiwai@suse.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  W:	http://www.alsa-project.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> -T:	git git://git.alsa-project.org/alsa-kernel.git
>  Q:	http://patchwork.kernel.org/project/alsa-devel/list/
>  S:	Maintained
>  F:	Documentation/sound/
> @@ -16100,7 +16099,7 @@ F:	drivers/usb/storage/
>  USB MIDI DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -T:	git git://git.alsa-project.org/alsa-kernel.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  S:	Maintained
>  F:	sound/usb/midi.*
>  
> -- 
> 2.21.0.593.g511ec345e18-goog

Regards

Takashi Sakamoto
