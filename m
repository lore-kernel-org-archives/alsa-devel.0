From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Where do amidi MIDI port names come from ?
Date: Mon, 22 Jan 2018 16:29:24 +0100
Message-ID: <46809c91-d41b-3b94-aadf-5289bfadb404@ladisch.de>
References: <1516632532.3556.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D78266E07
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 16:27:07 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 104D45580EE2
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 16:27:05 +0100 (CET)
In-Reply-To: <1516632532.3556.14.camel@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Happy wrote:
> For example a MIDISport 4x4 shows "Midiman" at lsusb (the same for each
> one if there is more than one device. This comes from the idVendor,
> idProduct in the device descriptor)

The name shown for these items does not come from the device; lsusb has
an internal database that maps the idVendor/idProduct values to names.

> But "MIDISPORT 4x4 Anniv MIDI 1 to 4" by amidi -l for the device.
> Thus wonder where amidi (ALSA) gets the product/portname from.

The snd-usb-audio driver gets these names from the device descriptors
(iManufacturer/iProduct).  Some devices do not have these, so the
entries in quirks-table.h can override them.  There are no devices that
specify port names (AFAIK), so the driver has a hardcoded list for some
devices in the port_info array in midi.c, and uses 1/2/... for the rest.


Regards,
Clemens
