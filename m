From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Tue, 30 Nov 2010 16:26:55 +0100
Message-ID: <4CF517BF.4020706@ladisch.de>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>	<4CEED787.9050504@gmail.com>	<AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>	<s5hfwukp4k4.wl%tiwai@suse.de>
	<AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 97E26244CB
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 16:24:52 +0100 (CET)
In-Reply-To: <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> Unfortunately I am sending this email from gmail, so I'm not sure
> about line formatting, yikes.

Long lines are wrapped.

> +		/*
> +		 * We have to make sure that the USB core looks
> +		 * again at interface 6 by calling usb_set_interface() on it.
> +		 */
> +		usb_set_interface(umidi->dev, 6, 0);

Why?  Is this another duplicate endpoint number?

> +		memcpy(&endpoints[0], quirk->data,
> +			sizeof(struct snd_usb_midi_endpoint_info));

I think you should be able to call snd_usbmidi_detect_per_port_endpoints
here.

> +/* DIGIDESIGN MBOX 2 */
> +{
> +       /* Damien Zammit <damien.zammit@gmail.com> */

This usually goes into the commit log.

> +       USB_DEVICE(0x0dba, 0x3000),

The entries are supposed to be ordered by their IDs.

> +                         * but now we will try sending
> capture/playback enable magic
> +                         *
> +                         * 80 bb 00 = 24bit mode - S24_3BE
> +                         * 44 ac 00 = 16bit mode?

Why the question mark?

> +                        //enablemagic[0]=0x44;
> +                        //enablemagic[1]=0xac;
> +                        //enablemagic[2]=0x00;

Why is this commented out?

> +#define MBOX2_SET_48K_SPDIF            0
> +#define MBOX2_SET_44K_SPDIF            1
> +#define MBOX2_SET_48K_ANALOG           2
> +#define MBOX2_SET_44K_ANALOG           3

In theory, this should be some control instead of a module parameter.

> +static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
> +                                        int iface, int altno)

This function isn't consistently indented with tabs.


Regards,
Clemens
