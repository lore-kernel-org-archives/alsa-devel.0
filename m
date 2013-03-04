From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Mon, 4 Mar 2013 22:33:11 +0100
Message-ID: <20130304213311.GG4452@pvv.ntnu.no>
References: <20130302130403.GD4452@pvv.ntnu.no> <5131FAC1.30007@gmail.com>
 <20130303192922.GE4452@pvv.ntnu.no> <s5hlia3ilzx.wl%tiwai@suse.de>
 <5134781F.4050607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D28265160
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 22:33:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5134781F.4050607@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 04, 2013 at 11:31:59AM +0100, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > Torstein Hegge wrote:
> >> On Sat, Mar 02, 2013 at 02:12:33PM +0100, Daniel Mack wrote:
> >>> On 02.03.2013 14:04, Torstein Hegge wrote:
> >>>> The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> >>>> sampling frequency while the interface is active.
> 
> >>>> +	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
> >>>> +	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> 
> There are other CM6631-based devices.

Most CM6631 devices with sample rate change problems reported has one of those
two ids, as far as I can see. The Asus Xonar Essence One uses the CM6631, but
it is listed in the wiki as supported, without any comments about any such
issue. I don't know what vendor/product id the Emotiva XDA-2 reports. Did you
think of any device in particular?

> > If the reset of interface is needed only when *changing* SRC, we can
> > check the current rate against the previous rate and skip the reset?
> 
> Or, if we want to be more similar to what many Windows drivers do, reset
> the interface to altsetting zero before setting it again.

I see that is done other places in the usb module where the intention is
to reset the device. It doesn't seem to make any difference one way or
the other in this case. I'll do a reset to altsetting zero first in the
next version of this patch.

Thanks.

Torstein
