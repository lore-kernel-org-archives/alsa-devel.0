From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Tue, 27 Apr 2010 16:07:36 +0200
Message-ID: <20100427140735.GD30804@buzzloop.caiaq.de>
References: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
	<4B8CD6A0.40204@freemail.gr>
	<20100302183542.GU28972@buzzloop.caiaq.de>
	<4BD6E564.5050100@freemail.gr> <4BD6E737.8030805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EFC2924350
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 16:07:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BD6E737.8030805@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 05:31:35PM +0400, The Source wrote:
> Perhaps I should've posted my problem in this thread earlier. Here's the 
> summary:
> Creative X-Fi Notebook stopped working after upgrading from 1.0.22.1 to 
> 1.0.23 (worked just fine before).
> dmesg gives the following:
> 
> usb 8-2: new full speed USB device using uhci_hcd and address 2
> usb 8-2: New USB device found, idVendor=041e, idProduct=30d2
> usb 8-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 8-2: Product: SB X-Fi Notebook
> usb 8-2: Manufacturer: Creative Technology Ltd
> usb 8-2: configuration #1 chosen from 1 choice
> input: Creative Technology Ltd SB X-Fi Notebook as 
> /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.3/input/input11
> generic-usb 0003:041E:30D2.0002: input,hidraw1: USB HID v1.11 Device 
> [Creative Technology Ltd SB X-Fi Notebook] on usb-0000:00:1d.2-2/input3
> input: Creative Technology Ltd SB X-Fi Notebook as 
> /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.4/input/input12
> generic-usb 0003:041E:30D2.0003: input,hidraw2: USB HID v1.11 Keyboard 
> [Creative Technology Ltd SB X-Fi Notebook] on usb-0000:00:1d.2-2/input4
> ALSA pcm.c:174: 2:1:1: endpoint lacks sample rate attribute bit, cannot 
> set.
> ALSA pcm.c:174: 2:2:1: endpoint lacks sample rate attribute bit, cannot 
> set.

And you say this is a regression from earlier versions? Would you be
able to bisect this problem?

Daniel
