From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC] ALSA: usb-audio: add front jack
	channel selector for EMU0204
Date: Fri, 12 Jul 2013 16:24:44 +0300
Message-ID: <CA+E=qVdOc7eGD7eH1FaAZ8_kWjWBbN+JSs2CTPOwfwvoRVmUiQ@mail.gmail.com>
References: <1373572671-3851-1-git-send-email-anarsoul@gmail.com>
 <s5h1u742atq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 717FA2659F5
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 15:25:05 +0200 (CEST)
Received: by mail-oa0-f41.google.com with SMTP id n10so12968332oag.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 06:25:04 -0700 (PDT)
In-Reply-To: <s5h1u742atq.wl%tiwai@suse.de>
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
Cc: Yury Bushmelev <jay@jay-tech.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2013 at 3:59 PM, Takashi Iwai <tiwai@suse.de> wrote:

> > Control request looks like generic UAC_SET_CUR request, but with a bit
> weird values,
> > valid values are { 0x01, 0x01} and { 0x01, 0x02 }, and there's no such
> control type ATM.
> > I'm not well familiar with UAC so any suggestins how to get rid of
> custom control req are welcome!
>
> snd_usb_ctl_msg() call should be rewritten not to pass magic numbers
> but use constants, e.g.
>   0x01 = UAC_SET_CUR,
>   0x21 = USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT
> ...
>

OK, but how to interpret wIndex and wValue values?


> And, in this case, it'd be more natural to implement as an enum
> control instead of a switch.
>

OK


>
>
> thanks,
>
> Takashi
>
>
Thanks for review!

Regards
Vasily
