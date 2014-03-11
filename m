From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
	support to quirks-table
Date: Tue, 11 Mar 2014 02:30:39 -0700
Message-ID: <7174D7E6-D9B4-4A6C-863F-135B78618519@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
 <531EC9CC.4060203@ladisch.de>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cyrusharmon.org (unknown [206.125.171.163])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1622610B7
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 10:30:38 +0100 (CET)
In-Reply-To: <531EC9CC.4060203@ladisch.de>
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


On Mar 11, 2014, at 1:31 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Cyrus Harmon wrote:
>> On Mar 10, 2014, at 8:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>> In theory, kernel 3.11 and later should support this device without
>>> a quirk entry.  I guess it actually does not?
>> =

>> no, the stock kernel doesn=92t support this device.
> =

> Strange; in theory, the driver should be able to pick up these
> descriptors.
> =

> Are there any error messages in the system log when you plug it in or
> reload the unpatch snd-usb-audio driver?

Here=92s what I get with the unpatched kernel:

Mar 11 02:25:11 cbox kernel: [   82.426640] usb 2-1.6: new high-speed USB d=
evice number 4 using ehci-pci
Mar 11 02:25:12 cbox kernel: [   82.515364] usb 2-1.6: New USB device found=
, idVendor=3D0499, idProduct=3D150e
Mar 11 02:25:12 cbox kernel: [   82.515368] usb 2-1.6: New USB device strin=
gs: Mfr=3D1, Product=3D2, SerialNumber=3D0
Mar 11 02:25:12 cbox kernel: [   82.515370] usb 2-1.6: Product: Steinberg U=
R44
Mar 11 02:25:12 cbox kernel: [   82.515372] usb 2-1.6: Manufacturer: Yamaha=
 Corporation
Mar 11 02:25:12 cbox kernel: [   82.518134] snd-usb-audio: probe of 2-1.6:1=
.0 failed with error -5
Mar 11 02:25:12 cbox kernel: [   82.523317] snd-usb-audio: probe of 2-1.6:1=
.1 failed with error -5
Mar 11 02:25:12 cbox mtp-probe: checking bus 2, device 4: "/sys/devices/pci=
0000:00/0000:00:1d.0/usb2/2-1/2-1.6"
Mar 11 02:25:12 cbox mtp-probe: bus: 2, device: 4 was not an MTP device

thanks for taking a look,

Cyrus

> =

> =

> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
