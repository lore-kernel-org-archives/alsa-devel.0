From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Mon, 03 Nov 2014 16:36:58 -0800
Message-ID: <54581FAA.6050703@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
 <531EC9CC.4060203@ladisch.de>
 <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id E6BC626056C
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 01:37:00 +0100 (CET)
Received: from aspen.bobobeach.com (localhost [127.0.0.1])
 by aspen.bobobeach.com (Postfix) with ESMTP id 9DE3610154
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:39:16 -0800 (PST)
Received: from [192.168.1.224] (adsl-172-11-236-93.dsl.pltn13.sbcglobal.net
 [172.11.236.93])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by aspen.bobobeach.com (Postfix) with ESMTPSA id 6B83610176
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:39:16 -0800 (PST)
In-Reply-To: <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
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


Well, it's 7 months on and I'm still using a patched kernel to access my =

UR44. Any chance of either seeing my original patch committed, or some =

suggestions on a more proper fix, if there's something with my original =

patch?

thanks,

Cyrus

On 03/17/2014 09:29 AM, Cyrus Harmon wrote:
> On Mar 11, 2014, at 1:31 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
>> Cyrus Harmon wrote:
>>> On Mar 10, 2014, at 8:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>>> In theory, kernel 3.11 and later should support this device without
>>>> a quirk entry.  I guess it actually does not?
>>> no, the stock kernel doesn=92t support this device.
>> Strange; in theory, the driver should be able to pick up these
>> descriptors.
>>
>> Are there any error messages in the system log when you plug it in or
>> reload the unpatch snd-usb-audio driver?
> Following up on this from last week, here=92s the error message I see wit=
h an unpatched kernel:
>
> Mar 11 02:25:11 cbox kernel: [   82.426640] usb 2-1.6: new high-speed USB=
 device number 4 using ehci-pci
> Mar 11 02:25:12 cbox kernel: [   82.515364] usb 2-1.6: New USB device fou=
nd, idVendor=3D0499, idProduct=3D150e
> Mar 11 02:25:12 cbox kernel: [   82.515368] usb 2-1.6: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> Mar 11 02:25:12 cbox kernel: [   82.515370] usb 2-1.6: Product: Steinberg=
 UR44
> Mar 11 02:25:12 cbox kernel: [   82.515372] usb 2-1.6: Manufacturer: Yama=
ha Corporation
> Mar 11 02:25:12 cbox kernel: [   82.518134] snd-usb-audio: probe of 2-1.6=
:1.0 failed with error -5
> Mar 11 02:25:12 cbox kernel: [   82.523317] snd-usb-audio: probe of 2-1.6=
:1.1 failed with error -5
> Mar 11 02:25:12 cbox mtp-probe: checking bus 2, device 4: "/sys/devices/p=
ci0000:00/0000:00:1d.0/usb2/2-1/2-1.6"
> Mar 11 02:25:12 cbox mtp-probe: bus: 2, device: 4 was not an MTP device
>
> Any suggestions for further debugging this?
>
> Also, from an earlier message,
>
> On Mar 10, 2014, at 8:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
>> This sounds as if the playback stream needs to be synchronized to the
>> recording stream
> Any pointers on where I might look to figure out how to do this?
>
> thanks again,
>
> Cyrus
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
