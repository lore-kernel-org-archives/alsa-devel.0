From: Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: xhci: Not enough bandwidth for new device state
Date: Thu, 1 Mar 2018 19:33:12 +0100
Message-ID: <20180301183311.GA12535@waldemar-brodkorb.de>
References: <20180228210753.GA3131@waldemar-brodkorb.de>
 <20180301070757.GY12535@waldemar-brodkorb.de>
 <ac4654e7-819d-29d5-d1c0-9f377ee8be83@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D5A267B73
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:33:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ac4654e7-819d-29d5-d1c0-9f377ee8be83@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,
Clemens Ladisch wrote,

> Waldemar Brodkorb wrote:
> >> [  547.352746] usb 3-5.2: 3:1: usb_set_interface failed (-28)
> >> [  548.352865] usb 3-5.3: Not enough bandwidth for new device state.
> >> [  548.352868] usb 3-5.3: Not enough bandwidth for altsetting 1
> >>
> >> I have connected a 7-Port USB 3.0 Hub to my machine.
> >> I have 6 different Headsets and USB Soundcards connected to the HUB.
> >>
> >> As soon as I start a C++ application which opens all ALSA devices
> >> I get these errors and the USB stopps working correctly.
> >>
> >> I think the maximum count of USB sound devices, which behave stable
> >> is three or four.
> >>
> >> Is this some miscalculation of the Linux kernel regarding the USB
> >> bandwidth usage? How I can determine how much bandwidth the USB
> >> sound card driver preallocates?
> >>
> >> Or are five USB soundcards really too much for an USB 3.0 bus?
> >
> > There is no webcam involved, which usually uses MaxPacketsize of 1024,
> > so why I get the overallocation?
> 
> AFAIK on xHCI controllers, the kernel and the controller's firmware
> must work together to handle this.
> 
> It's possible that a USB 2.0 hub might work better.
> 
> Try asking on the linux-usb list.

Indeed todays tests have shown that just simply disabling
xhci in the BIOS of the machines and just using ehci driver works
perfectly well in our usecase.

best regards
 Waldemar
