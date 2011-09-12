From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/4] USB: Add endpoint usage definitions to
	ch9.h
Date: Mon, 12 Sep 2011 19:13:32 +0200
Message-ID: <CACTFLAM1bFzURnh-fqgqxU+HWvtW76ktc4-UN2BDFa_HLQ5ENQ@mail.gmail.com>
References: <1315846453-5036-1-git-send-email-zonque@gmail.com>
	<1315846453-5036-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 82F39103910
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 19:15:18 +0200 (CEST)
Received: by pzk1 with SMTP id 1so7213340pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 10:15:15 -0700 (PDT)
In-Reply-To: <1315846453-5036-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 6:54 PM, Daniel Mack <zonque@gmail.com> wrote:
> The endpoint usage field is described in the USB 2.0 specification,
> chapter 9.6.6.
>
> Also, move the sync type fields block down by some lines to reflect the
> fact that these are also stuffed in bmAttributes.

Greg - can we merge this through the ALSA tree?


Daniel


> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Takashi Iwai <tiwai@suse.de>
> ---
> =A0include/linux/usb/ch9.h | =A0 17 +++++++++++------
> =A01 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
> index 0fd3fbd..f302535 100644
> --- a/include/linux/usb/ch9.h
> +++ b/include/linux/usb/ch9.h
> @@ -377,12 +377,6 @@ struct usb_endpoint_descriptor {
> =A0#define USB_ENDPOINT_NUMBER_MASK =A0 =A0 =A0 0x0f =A0 =A0/* in bEndpoi=
ntAddress */
> =A0#define USB_ENDPOINT_DIR_MASK =A0 =A0 =A0 =A0 =A00x80
>
> -#define USB_ENDPOINT_SYNCTYPE =A0 =A0 =A0 =A0 =A00x0c
> -#define USB_ENDPOINT_SYNC_NONE =A0 =A0 =A0 =A0 (0 << 2)
> -#define USB_ENDPOINT_SYNC_ASYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> -#define USB_ENDPOINT_SYNC_ADAPTIVE =A0 =A0 (2 << 2)
> -#define USB_ENDPOINT_SYNC_SYNC =A0 =A0 =A0 =A0 (3 << 2)
> -
> =A0#define USB_ENDPOINT_XFERTYPE_MASK =A0 =A0 0x03 =A0 =A0/* in bmAttribu=
tes */
> =A0#define USB_ENDPOINT_XFER_CONTROL =A0 =A0 =A00
> =A0#define USB_ENDPOINT_XFER_ISOC =A0 =A0 =A0 =A0 1
> @@ -390,6 +384,17 @@ struct usb_endpoint_descriptor {
> =A0#define USB_ENDPOINT_XFER_INT =A0 =A0 =A0 =A0 =A03
> =A0#define USB_ENDPOINT_MAX_ADJUSTABLE =A0 =A00x80
>
> +#define USB_ENDPOINT_SYNCTYPE =A0 =A0 =A0 =A0 =A00x0c
> +#define USB_ENDPOINT_SYNC_NONE =A0 =A0 =A0 =A0 (0 << 2)
> +#define USB_ENDPOINT_SYNC_ASYNC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define USB_ENDPOINT_SYNC_ADAPTIVE =A0 =A0 (2 << 2)
> +#define USB_ENDPOINT_SYNC_SYNC =A0 =A0 =A0 =A0 (3 << 2)
> +
> +#define USB_ENDPOINT_USAGE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
> +#define USB_ENDPOINT_USAGE_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> +#define USB_ENDPOINT_USAGE_FEEDBACK =A0 =A00x10
> +#define USB_ENDPOINT_USAGE_IMPLICIT_FB 0x20 =A0 =A0/* Implicit feedback =
Data endpoint */
> +
> =A0/*--------------------------------------------------------------------=
-----*/
>
> =A0/**
> --
> 1.7.5.4
>
>
