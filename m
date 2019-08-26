From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] ALSA: usb-audio: Add Hiby R3 to quirks for
 native DSD support
Date: Mon, 26 Aug 2019 20:10:28 +0300
Message-ID: <021132df-8deb-b9f0-2d9e-e934f92c6c7a@sonarnerd.net>
References: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CDF0F80143
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 19:10:35 +0200 (CEST)
In-Reply-To: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ilya.pshonkin@netforce.ua
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Manuel Reinhardt <manuel.rhdt@gmail.com>, Takashi Iwai <tiwai@suse.com>, Richard Fontana <rfontana@redhat.com>, Sudokamikaze <sudokamikaze@protonmail.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

> +	/* ESS Sabre based USB DACs */
> +	case USB_ID(0xc502, 0x0051): /* Hiby R3 */
> +		if (fp->altsetting == 4)
> +			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
> +		break;

Do you know who's vendor id is this? ESS Sabre is a DAC chip with I2S 
input, I'm not aware of any product from ESS under Sabre brand that 
would include USB interface. (?) So likely the USB interface is sourced 
from somewhere else...

It is good to check with "lsusb -vvv" if the device flags DSD altsetting 
as raw. Then you know it'll work with the auto-detection code and 
doesn't break so easily if firmware update changes altsettings (not 
uncommon to happen).


	- Jussi
