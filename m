From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/6] sound/usb/caiaq/device.c: fix use of
	MODULE_SUPPORTED_DEVICES()
Date: Tue, 29 Jan 2013 07:33:53 +0800
Message-ID: <89689420-8f6b-4119-b728-fb40f78be7d7@email.android.com>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
 <1359412952-1680-5-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f48.google.com (mail-da0-f48.google.com
 [209.85.210.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C9A26036E
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 00:34:07 +0100 (CET)
Received: by mail-da0-f48.google.com with SMTP id k18so1491483dae.21
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 15:34:06 -0800 (PST)
In-Reply-To: <1359412952-1680-5-git-send-email-ospite@studenti.unina.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ospite@studenti.unina.it>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Antonio Ospite <ospite@studenti.unina.it> wrote:

>From: Antonio Ospite <ao2@amarulasolutions.com>
>
>It looks like MODULE_SUPPORTED_DEVICES() is not implemented yet, but
>still, having the entries in the list consistently separated by commas
>and with balanced parenthesis won't hurt.
>
>Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>

Acked-by: Daniel Mack <zonque@gmail.com>


Thanks!



>---
> sound/usb/caiaq/device.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
>index c828f81..e4d6dbb 100644
>--- a/sound/usb/caiaq/device.c
>+++ b/sound/usb/caiaq/device.c
>@@ -48,10 +48,10 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments,
>RigKontrol2},"
> 			 "{Native Instruments, Audio 8 DJ},"
> 			 "{Native Instruments, Traktor Audio 2},"
> 			 "{Native Instruments, Session I/O},"
>-			 "{Native Instruments, GuitarRig mobile}"
>-			 "{Native Instruments, Traktor Kontrol X1}"
>-			 "{Native Instruments, Traktor Kontrol S4}"
>-			 "{Native Instruments, Maschine Controller}");
>+			 "{Native Instruments, GuitarRig mobile},"
>+			 "{Native Instruments, Traktor Kontrol X1},"
>+			 "{Native Instruments, Traktor Kontrol S4},"
>+			 "{Native Instruments, Maschine Controller}}");
> 
> static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
>static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card
>*/
