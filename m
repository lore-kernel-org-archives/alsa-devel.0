From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/3] ALSA: usb-audio: fix Amanero
 Combo384 quirk on big-endian hosts
Date: Tue, 30 May 2017 10:29:53 +0200
Message-ID: <20170530082953.GJ18869@localhost>
References: <20170512123439.14994-1-johan@kernel.org>
 <20170512123439.14994-2-johan@kernel.org>
 <7d6e1d60-0259-8cb5-565e-0627608537a8@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 452B0266AA1
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 10:29:52 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id m18so8141730lfj.0
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 01:29:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7d6e1d60-0259-8cb5-565e-0627608537a8@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 30, 2017 at 02:40:09AM +0300, Jussi Laako wrote:
> On 12.05.2017 15:34, Johan Hovold wrote:
> > Add missing endianness conversion when using the USB device-descriptor
> > bcdDevice field when applying the Amanero Combo384 (endianness!) quirk.
> > 
> > Fixes: 3eff682d765b ("ALSA: usb-audio: Support both DSD LE/BE Amanero firmware versions")
> > Cc: Jussi Laako <jussi@sonarnerd.net>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >   sound/usb/quirks.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> > index 01eff6ce6401..d7b0b0a3a2db 100644
> > --- a/sound/usb/quirks.c
> > +++ b/sound/usb/quirks.c
> > @@ -1364,7 +1364,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
> >   	/* Amanero Combo384 USB interface with native DSD support */
> >   	case USB_ID(0x16d0, 0x071a):
> >   		if (fp->altsetting == 2) {
> > -			switch (chip->dev->descriptor.bcdDevice) {
> > +			switch (le16_to_cpu(chip->dev->descriptor.bcdDevice)) {
> >   			case 0x199:
> >   				return SNDRV_PCM_FMTBIT_DSD_U32_LE;
> >   			case 0x19b:
> > 
> 
> 
> Sorry for the delay... Looks good to me, tested to work OK.

Thanks for testing. Patch is in Linus' tree now.

Johan
