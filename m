From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Wed, 05 Nov 2014 10:16:28 -0800
Message-ID: <545A697C.5070800@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
 <545895AD.7020004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 684F42606E7
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 19:16:32 +0100 (CET)
Received: from aspen.bobobeach.com (localhost [127.0.0.1])
 by aspen.bobobeach.com (Postfix) with ESMTP id 8A35310165
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:18:47 -0800 (PST)
Received: from [192.168.1.224] (adsl-172-11-236-93.dsl.pltn13.sbcglobal.net
 [172.11.236.93])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by aspen.bobobeach.com (Postfix) with ESMTPSA id 31FC410148
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 10:18:47 -0800 (PST)
In-Reply-To: <545895AD.7020004@ladisch.de>
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


Hi Clemens,

When I try that, I see the following in the dmesg log:

[    2.963091] usb 3-3.2: New USB device found, idVendor=0499, 
idProduct=150e
[    2.963093] usb 3-3.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    2.963094] usb 3-3.2: Product: Steinberg UR44
[    2.963095] usb 3-3.2: Manufacturer: Yamaha Corporation
[    2.963988] nvidia 0000:01:00.0: irq 31 for MSI/MSI-X
[    2.964094] snd-usb-audio 3-3.2:1.0: checking PCM interface
[    2.964104] snd-usb-audio: probe of 3-3.2:1.0 failed with error -5
[    2.966339] snd-usb-audio 3-3.2:1.1: checking PCM interface
[    2.966341] snd-usb-audio 3-3.2:1.1: altsets found
[    2.966342] snd-usb-audio 3-3.2:1.1: endpoint found
[    2.966343] snd-usb-audio 3-3.2:1.1: iso found
[    2.966344] snd-usb-audio 3-3.2:1.1: descriptors found
[    2.968544] usb 3-3.2:1.0: checking PCM interface
[    2.968546] usb 3-3.2:1.2: checking PCM interface
[    2.968547] usb 3-3.2:1.2: altsets found
[    2.968547] usb 3-3.2:1.2: endpoint found
[    2.968548] usb 3-3.2:1.2: iso found
[    2.968549] usb 3-3.2:1.2: descriptors found
[    2.970657] usb 3-3.2:1.3: checking PCM interface
[    2.970666] usb 3-3.2:1.4: checking PCM interface
[    2.970930] snd-usb-audio: probe of 3-3.2:1.1 failed with error -5
[    2.974643] systemd-udevd[569]: Failed to apply ACL on 
/dev/snd/pcmC3D0p: No such file or directory
[    2.974694] systemd-udevd[568]: error opening 
ATTR{/sys/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.1/sound/card3/controlC3/../uev
ent} for writing: No such file or directory
[    2.974710] systemd-udevd[571]: Failed to apply ACL on 
/dev/snd/midiC3D0: No such file or directory
[    2.974779] systemd-udevd[568]: Failed to apply ACL on 
/dev/snd/controlC3: No such file or directory
[    2.975019] systemd-udevd[570]: Failed to apply ACL on 
/dev/snd/pcmC3D0c: No such file or directory


Thanks,

Cyrus



On 11/04/2014 01:00 AM, Clemens Ladisch wrote:
> Cyrus Harmon wrote:
>> On Mar 11, 2014, at 1:31 AM, Clemens Ladisch wrote:
>>> Strange; in theory, the driver should be able to pick up these
>>> descriptors.
>>>
>>> Are there any error messages in the system log when you plug it in or
>>> reload the unpatch snd-usb-audio driver?
>> Mar 11 02:25:11 cbox kernel: [   82.426640] usb 2-1.6: new high-speed USB device number 4 using ehci-pci
>> Mar 11 02:25:12 cbox kernel: [   82.515364] usb 2-1.6: New USB device found, idVendor=0499, idProduct=150e
>> Mar 11 02:25:12 cbox kernel: [   82.515368] usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> Mar 11 02:25:12 cbox kernel: [   82.515370] usb 2-1.6: Product: Steinberg UR44
>> Mar 11 02:25:12 cbox kernel: [   82.515372] usb 2-1.6: Manufacturer: Yamaha Corporation
>> Mar 11 02:25:12 cbox kernel: [   82.518134] snd-usb-audio: probe of 2-1.6:1.0 failed with error -5
>> Mar 11 02:25:12 cbox kernel: [   82.523317] snd-usb-audio: probe of 2-1.6:1.1 failed with error -5
> Please try the patch below to get more information in the log.
>
>
> Regards,
> Clemens
>
>
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -196,19 +196,23 @@
>   	 * future ones might change, so ensure that we fail silently if the
>   	 * interface doesn't look exactly right.
>   	 */
> +	dev_info(&iface->dev, "checking PCM interface\n");
>
>   	/* must have a non-zero altsetting for streaming */
>   	if (iface->num_altsetting < 2)
>   		return -ENODEV;
> +	dev_info(&iface->dev, "altsets found\n");
>   	alts = &iface->altsetting[1];
>   	altsd = get_iface_desc(alts);
>
>   	/* must have an isochronous endpoint for streaming */
>   	if (altsd->bNumEndpoints < 1)
>   		return -ENODEV;
> +	dev_info(&iface->dev, "endpoint found\n");
>   	epd = get_endpoint(alts, 0);
>   	if (!usb_endpoint_xfer_isoc(epd))
>   		return -ENODEV;
> +	dev_info(&iface->dev, "iso found\n");
>
>   	/* must have format descriptors */
>   	ashd = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
> @@ -219,6 +223,7 @@
>   	    !fmtd || fmtd->bLength < 8)
>   		return -ENODEV;
>
> +	dev_info(&iface->dev, "descriptors found\n");
>   	return create_standard_audio_quirk(chip, iface, driver, NULL);
>   }
>
