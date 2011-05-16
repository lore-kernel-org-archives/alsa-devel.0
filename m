From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Mon, 16 May 2011 12:55:05 +1000
Message-ID: <BANLkTiksbKfS5QdOobDn=2=o3EwrcYXMtA@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>
	<BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>
	<BANLkTimuaynDA+0wq9kqwizL5kp+b+AuLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 51DA0103822
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 04:55:06 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1209838eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 19:55:06 -0700 (PDT)
In-Reply-To: <BANLkTimuaynDA+0wq9kqwizL5kp+b+AuLA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, May 16, 2011 at 7:30 AM, Daniel Mack <zonque@gmail.com> wrote:

> On Sun, May 15, 2011 at 10:43 PM, Daniel Mack <zonque@gmail.com> wrote:
> > On Sun, May 15, 2011 at 7:54 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> >> So I reverted  7b6717e and... Nope. still no midi ports.
> >>
> >>
> >> Kernel messages are:
> >>
> >> [  131.484053] usb 3-1: new high speed USB device using ehci_hcd and
> address
> >> 3
> >> [  131.617753] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoint
> 0x7
> >> has invalid maxpacket 8
> >> [  131.617760] usb 3-1: config 1 interface 3 altsetting 0 bulk endpoint
> 0x87
> >> has invalid maxpacket 8
> >> [  131.618750] usb 3-1: New USB device found, idVendor=0763,
> idProduct=2080
> >> [  131.618754] usb 3-1: New USB device strings: Mfr=1, Product=2,
> >> SerialNumber=0
> >> [  131.618756] usb 3-1: Product: Fast Track Ultra
> >> [  131.618758] usb 3-1: Manufacturer: M-Audio
> >> [  132.767312] usbcore: registered new interface driver snd-usb-audio
> >>
> >> And amidi -l reports
> >>
> >> nevyn@cetacea:~/linux$ amidi -l
>
> Attached is a patch that adds some debug output. If you could apply
> that and report what the kernel logs during the probe of the device,
> that would be appreciated.
>
>
> Nothing is leaping out at me after building with he patch above...

[ 1025.380150] usb 4-1: new high speed USB device using ehci_hcd and address
4
[ 1025.513756] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint 0x7
has invalid maxpacket 8
[ 1025.513771] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint 0x87
has invalid maxpacket 8
[ 1025.514863] usb 4-1: New USB device found, idVendor=0763, idProduct=2080
[ 1025.514873] usb 4-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[ 1025.514881] usb 4-1: Product: Fast Track Ultra
[ 1025.514886] usb 4-1: Manufacturer: M-Audio
[ 1025.751285] usbcore: registered new interface driver snd-usb-audio


Grant
