From: Daniel Mack <daniel@zonque.org>
Subject: Re: BUG: Edirol UA-1000 failed parsing interface
Date: Mon, 06 Oct 2014 11:41:04 +0200
Message-ID: <543263B0.4030404@zonque.org>
References: <1215173971.300117484.1412441706066.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 218BE260533
 for <Alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 11:41:06 +0200 (CEST)
In-Reply-To: <1215173971.300117484.1412441706066.JavaMail.root@spooler2-g27.priv.proxad.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shal@free.fr, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/04/2014 06:55 PM, shal@free.fr wrote:
> I have a Edirol UA-1000 that is supported by Linux using the
> snd-ua101 module.

...

> The "cat /sys/kernel/debug/usb/devices" for my sound card : 
> http://pastebin.com/j4ab9ekZ

Shows:

  P:  Vendor=0582 ProdID=0044 Rev= 1.07

> So I found that the problem is in the quirk.c In the function
> create_auto_pcm_quirk() There is a check : /* * Most Roland/Yamaha
> audio streaming interfaces have more or less * standard descriptors,
> but older devices might lack descriptors, and * future ones might
> change, so ensure that we fail silently if the * interface doesn't
> look exactly right. */
> 
> /* must have a non-zero altsetting for streaming */ if
> (iface->num_altsetting < 2) return -ENODEV;
> 
> 
> And the iface->num_altsetting value for my card is 1. So The function
> return an ENODEV. So the caller function snd_usb_audio_probe return
> an -EIO
> 
> In dmesg:
> 
> [ 2747.573923] snd-usb-audio: probe of 2-1.3:1.0 failed with error

Your device should not be handled by the generic snd-usb-audio but by
the ua101 driver. Are you sure you have CONFIG_SND_USB_UA101 set in your
kernel config? What else does dmesg show when you plug in the card?


Daniel
