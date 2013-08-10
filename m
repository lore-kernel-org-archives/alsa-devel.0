From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] usb-audio: Fix invalid volume resolution for Logitech
 HD Webcam C525
Date: Sat, 10 Aug 2013 22:39:52 +0400
Message-ID: <520688F8.7090808@cogentembedded.com>
References: <alpine.LNX.2.02.1308091232400.26590@pcqnt1.phys.spbu.ru> <5205F7B2.7030505@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <5205F7B2.7030505@yandex.ru>
Sender: stable-owner@vger.kernel.org
To: "Maksim A. Boyko" <maksboyko@yandex.ru>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, stable@vger.kernel.org, maksim.a.boyko@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello.

On 08/10/2013 12:20 PM, Maksim A. Boyko wrote:

> Add the volume control quirk for avoiding the kernel warning
> for the Logitech HD Webcam C525
> as in the similar commit 36691e1be6ec551eef4a5225f126a281f8c051c2

    Please also specify that commit's summary line in parens.

> for the Logitech HD Webcam C310.

> Reported-by: Maksim Boyko <maksim.a.boyko@gmail.com>
> Tested-by: Maksim Boyko <maksim.a.boyko@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.10.5+
> Signed-off-by: Maksim Boyko <maksim.a.boyko@gmail.com>
> --
>   sound/usb/mixer.c |    1 +
>   1 file changed, 1 insertion(+)
>
> --- linux-3.10.5-orig/sound/usb/mixer.c    2013-08-04 12:51:49.000000000
> +0400
> +++ linux-3.10.5/sound/usb/mixer.c    2013-08-06 21:12:42.274197287
> +0400
> @@ -888,6 +888,7 @@ static void volume_control_quirks(struct
>       case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
>       case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
>       case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
> +    case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
>       case USB_ID(0x046d, 0x0991):
>       /* Most audio usb devices lie about volume resolution.
>        * Most Logitech webcams have res = 384.
>
>
> --
> WBR, Maksim

> P.S. Please, use this patch due to it should have correct tab symbols.

    Unfortunately, it seems to have a space added before each line starting 
with space.

WBR, Sergei
