From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 02/16] ALSA: line6: Fix memory leak at
	probe error path
Date: Sun, 25 Jan 2015 02:06:19 -0600
Message-ID: <CAEUsAPYHwhty=c68s81Vs4WoNtGw=gymi-Ys3diJdBKrnStHhQ@mail.gmail.com>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
 <1422033203-23254-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f41.google.com (mail-qg0-f41.google.com
 [209.85.192.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C0E9260417
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 11:01:18 +0100 (CET)
Received: by mail-qg0-f41.google.com with SMTP id q108so3514921qgd.0
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 02:01:15 -0800 (PST)
In-Reply-To: <1422033203-23254-3-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2015 at 11:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -507,10 +507,32 @@ int line6_probe(struct usb_interface *interface,
>         int interface_number;
>         int ret;
>
> +       ret = snd_card_new(line6->ifcdev,
> +                          SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
> +                          THIS_MODULE, 0, &card);

The `ifcdev' member has not been initialized yet.  You need something
like the following squashed in:

>8------------------------------------------------------8<
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2eed6fb..25d6b0f 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -507,6 +507,11 @@ int line6_probe(struct usb_interface *interface,
        int interface_number;
        int ret;

+       /* store basic data: */
+       line6->properties = properties;
+       line6->usbdev = usbdev;
+       line6->ifcdev = &interface->dev;
+
        ret = snd_card_new(line6->ifcdev,
                           SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
                           THIS_MODULE, 0, &card);
@@ -548,11 +553,6 @@ int line6_probe(struct usb_interface *interface,
                goto error;
        }

-       /* store basic data: */
-       line6->properties = properties;
-       line6->usbdev = usbdev;
-       line6->ifcdev = &interface->dev;
-
        line6_get_interval(line6);

        if (properties->capabilities & LINE6_CAP_CONTROL) {
