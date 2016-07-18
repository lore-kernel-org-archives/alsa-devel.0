From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: usb-audio: Fix quirks code is not
	called
Date: Mon, 18 Jul 2016 14:35:05 +0900
Message-ID: <578C6A89.6000008@sakamocchi.jp>
References: <20160717161615.2399-1-k@oikw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id CC160265721
 for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2016 07:35:10 +0200 (CEST)
In-Reply-To: <20160717161615.2399-1-k@oikw.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kazuki Oikawa <k@oikw.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, nekomatu+linux@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 18 2016 01:16, Kazuki Oikawa wrote:
> snd_usb_{set_interface,ctl_msg}_quirk checks chip->usb_id to need
> calling a quirks code. But existed code path that not calling
> dev_set_drvdata in usb_audio_probe.
> 
> Signed-off-by: Kazuki Oikawa <k@oikw.org>
> Fixes: 79289e24194a ("ALSA: usb-audio: Refer to chip->usb_id for quirks and MIDI creation")
> ---
>  sound/usb/card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 3fc63583a537..2d493501b7f6 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -552,7 +552,6 @@ static int usb_audio_probe(struct usb_interface *intf,
>  				goto __error;
>  			}
>  			chip = usb_chip[i];
> -			dev_set_drvdata(&dev->dev, chip);
>  			atomic_inc(&chip->active); /* avoid autopm */
>  			break;
>  		}
> @@ -578,6 +577,7 @@ static int usb_audio_probe(struct usb_interface *intf,
>  			goto __error;
>  		}
>  	}
> +	dev_set_drvdata(&dev->dev, chip);
>  
>  	/*
>  	 * For devices with more than one control interface, we assume the

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Let me describe supplemental comments.

This bug affects all of USB devices which take USB subsystem to call an
implementation of struct usb_driver.probe() in snd-usb-audio
(=usb_audio_probe()) just one time. In this case, dev_set_drvdata() is
not called at first call of usb_audio_probe(), then dev_get_drvdata()
returns NULL.

As a result, some quirks are not handled. snd_usb_set_interface_quirk()
and snd_usb_set_interface_quirk() returns immediately without enough
operations. This brings regressions to some models.

As long as I asked to Mr.Oikawa in this morning, below models are affected.
 * Playback Design
 * TEAC
 * Marantz
 * Denon
 * Zoom R16/24

I tested with EMU 0404 USB. This model has no quirks related to above
functions, but it brings just one call of usb_audio_probe(). Then,
without this patch, I can see dev_get_drvdata() always returns NULL
whole lifetime of usb device instance.
(But even with this patch, in a call of snd_usb_audio_free(),
dev_get_drvdata() returns NULL before a call of dev_set_devdata(NULL),
against my expectation. I don't know why...)

This patch should go for 4.8 merge window.


Regards

Takashi Sakamoto
