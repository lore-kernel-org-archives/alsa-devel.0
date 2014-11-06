From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Wed, 05 Nov 2014 21:47:00 -0800
Message-ID: <545B0B54.5080609@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>	<545895AD.7020004@ladisch.de>
 <545A697C.5070800@bobobeach.com> <545A93E3.7020906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F0D26506E
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 06:47:03 +0100 (CET)
In-Reply-To: <545A93E3.7020906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Here's what I get with the new (and old) patch(es):

[    2.869556] usb 3-3.2: new high-speed USB device number 6 using xhci_hcd
[    2.970810] usb 3-3.2: New USB device found, idVendor=0499, 
idProduct=150e
[    2.970813] usb 3-3.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    2.970814] usb 3-3.2: Product: Steinberg UR44
[    2.970815] usb 3-3.2: Manufacturer: Yamaha Corporation
[    2.973563] snd-usb-audio 3-3.2:1.0: checking PCM interface
[    2.973565] snd-usb-audio 3-3.2:1.0: quirk return code: -19
[    2.973566] snd-usb-audio 3-3.2:1.0: probe failed
[    2.973574] snd-usb-audio: probe of 3-3.2:1.0 failed with error -5
[    2.974003] snd-usb-audio 3-3.2:1.1: checking PCM interface
[    2.974005] snd-usb-audio 3-3.2:1.1: altsets found
[    2.974007] snd-usb-audio 3-3.2:1.1: endpoint found
[    2.974008] snd-usb-audio 3-3.2:1.1: iso found
[    2.974010] snd-usb-audio 3-3.2:1.1: descriptors found
[    2.976115] snd-usb-audio 3-3.2:1.1: first interface successful
[    2.976117] usb 3-3.2:1.0: checking PCM interface
[    2.976117] usb 3-3.2:1.2: checking PCM interface
[    2.976118] usb 3-3.2:1.2: altsets found
[    2.976119] usb 3-3.2:1.2: endpoint found
[    2.976120] usb 3-3.2:1.2: iso found
[    2.976120] usb 3-3.2:1.2: descriptors found
[    2.976641] usb 3-3.2: current rate 192000 is different from the 
runtime rate 48000
[    2.978137] snd-usb-audio 3-3.2:1.2: interface 2 successful
[    2.978140] usb 3-3.2:1.3: checking PCM interface
[    2.978148] snd-usb-audio 3-3.2:1.3: interface 3 successful
[    2.978150] usb 3-3.2:1.4: checking PCM interface
[    2.978155] snd-usb-audio 3-3.2:1.4: interface 4 successful
[    2.978157] snd-usb-audio 3-3.2:1.4: create_autodetect_quirks successful
[    2.978158] snd-usb-audio 3-3.2:1.1: quirk return code: 0
[    2.978159] snd-usb-audio 3-3.2:1.1: probe step 2
[    2.978334] snd-usb-audio 3-3.2:1.1: probe failed
[    2.978439] snd-usb-audio: probe of 3-3.2:1.1 failed with error -5
[    2.981241] systemd-udevd[510]: error opening 
ATTR{/sys/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.1/sound/
card3/controlC3/../uevent} for writing: No such file or directory
[    2.981342] systemd-udevd[511]: Failed to apply ACL on 
/dev/snd/pcmC3D0p: No such file or directory
[    2.981361] systemd-udevd[510]: Failed to apply ACL on 
/dev/snd/controlC3: No such file or directory
[    2.981420] systemd-udevd[547]: Failed to apply ACL on 
/dev/snd/midiC3D0: No such file or directory
[    2.981560] systemd-udevd[546]: Failed to apply ACL on 
/dev/snd/pcmC3D0c: No such file or directory

thanks for looking into this,

Cyrus

On 11/05/2014 01:17 PM, Clemens Ladisch wrote:
> Cyrus Harmon wrote:
>> [    2.964094] snd-usb-audio 3-3.2:1.0: checking PCM interface
>> [    2.964104] snd-usb-audio: probe of 3-3.2:1.0 failed with error -5
>> [    2.966339] snd-usb-audio 3-3.2:1.1: checking PCM interface
>> [    2.966341] snd-usb-audio 3-3.2:1.1: altsets found
>> [    2.966342] snd-usb-audio 3-3.2:1.1: endpoint found
>> [    2.966343] snd-usb-audio 3-3.2:1.1: iso found
>> [    2.966344] snd-usb-audio 3-3.2:1.1: descriptors found
>> [    2.968544] usb 3-3.2:1.0: checking PCM interface
>> [    2.968546] usb 3-3.2:1.2: checking PCM interface
>> [    2.968547] usb 3-3.2:1.2: altsets found
>> [    2.968547] usb 3-3.2:1.2: endpoint found
>> [    2.968548] usb 3-3.2:1.2: iso found
>> [    2.968549] usb 3-3.2:1.2: descriptors found
>> [    2.970657] usb 3-3.2:1.3: checking PCM interface
>> [    2.970666] usb 3-3.2:1.4: checking PCM interface
>> [    2.970930] snd-usb-audio: probe of 3-3.2:1.1 failed with error -5
> Strange; in theory, this cannot happen.
>
> Please add this patch and try again.
>
>
> Regards,
> Clemens
>
>
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -536,7 +536,9 @@ snd_usb_audio_probe(struct usb_device *dev,
>   	err = 1; /* continue */
>   	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
>   		/* need some special handlings */
> -		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
> +		err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk);
> +		dev_info(&intf->dev, "quirk return code: %d\n", err);
> +		if (err < 0)
>   			goto __error;
>   	}
>
> @@ -547,11 +549,13 @@ snd_usb_audio_probe(struct usb_device *dev,
>   			goto __error;
>   		}
>   	}
> +	dev_info(&intf->dev, "probe step 2\n");
>
>   	/* we are allowed to call snd_card_register() many times */
>   	if (snd_card_register(chip->card) < 0) {
>   		goto __error;
>   	}
> +	dev_info(&intf->dev, "probe step 3\n");
>
>   	usb_chip[chip->index] = chip;
>   	chip->num_interfaces++;
> @@ -560,6 +564,7 @@ snd_usb_audio_probe(struct usb_device *dev,
>   	return chip;
>
>    __error:
> +	dev_info(&intf->dev, "probe failed\n");
>   	if (chip) {
>   		if (!chip->num_interfaces)
>   			snd_card_free(chip->card);
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -367,6 +367,7 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
>   	err = create_autodetect_quirk(chip, iface, driver);
>   	if (err < 0)
>   		return err;
> +	dev_info(&iface->dev, "first interface successful\n");
>
>   	/*
>   	 * ALSA PCM playback/capture devices cannot be registered in two steps,
> @@ -385,9 +386,13 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
>
>   		err = create_autodetect_quirk(chip, iface, driver);
>   		if (err >= 0)
> +		{
>   			usb_driver_claim_interface(driver, iface, (void *)-1L);
> +			dev_info(&iface->dev, "interface %d successful\n", ifnum);
> +		}
>   	}
>
> +	dev_info(&iface->dev, "create_autodetect_quirks successful\n");
>   	return 0;
>   }
>
