From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sun, 21 Oct 2012 15:38:50 +0200
Message-ID: <1350826730.5300.2.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
 <1350743458.25322.16.camel@didier-laptop> <5082CE0E.1010701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id EDA5B265134
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 15:38:54 +0200 (CEST)
In-Reply-To: <5082CE0E.1010701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On sam., 2012-10-20 at 18:15 +0200, Clemens Ladisch wrote:
> Didier 'Ptitjes' Villevalois wrote:
> >                 .vendor_name = "Reloop",
> >                 .product_name = "Play",
> 
> These aren't needed except when they are wrong in the descriptor.

In fact there is nothing appearing when I do lsusb, even when I specify
them in the quirk. Is this not related ?

> >                                 .data = &(const struct audioformat) {
> >                                         .formats = SNDRV_PCM_FMTBIT_S24_3LE,
> >                                         .channels = 4,
> >                                         .iface = 1,
> >                                         .altsetting = 1,
> >                                         .altset_idx = 1,
> >                                         .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
> >                                         .endpoint = 0x01,
> 
> You might as well set ep_attr to USB_ENDPOINT_SYNC_ADAPTIVE.

Oki. I'll do that.

Didier.
