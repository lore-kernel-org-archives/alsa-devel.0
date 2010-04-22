From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 4/4] snd-maestro3: Make hardware volume
 buttons an input device
Date: Thu, 22 Apr 2010 09:57:42 +0200
Message-ID: <4BD00176.3000904@redhat.com>
References: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
	<1271862249-22612-4-git-send-email-hdegoede@redhat.com>
	<20100421160551.GB6861@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id AED8410380E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 09:56:10 +0200 (CEST)
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3M7u9ls020420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 03:56:09 -0400
Received: from localhost.localdomain (vpn1-4-140.ams2.redhat.com [10.36.4.140])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o3M7u78o017739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2010 03:56:08 -0400
In-Reply-To: <20100421160551.GB6861@sci.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 04/21/2010 06:05 PM, Ville Syrj=E4l=E4 wrote:
> On Wed, Apr 21, 2010 at 11:04:09AM -0400, Hans de Goede wrote:
>> While working on the sound suspend / resume problems with my laptop
>> I noticed that the hardware volume handling code in essence just detects
>> key presses, and then does some hardcoded modification of the master vol=
ume
>> based on which key is pressed.
>>
>> This made me think that clearly the right thing to do here is just report
>> these keypresses to userspace as keypresses using an input device and let
>> userspace decide what to with them.
>>
>> This patch does this, getting rid of the ugly direct ac97 writes from
>> the tasklet, the ac97lock and the need for using a tasklet in general.
>>
>> As an added bonus the keys now work identical to volume keys on a (usb)
>> keyboard with multimedia keys, providing visual feedback of the volume
>> level change, and a better range of the volume control (with a properly
>> configured desktop environment).
>
> I like it. The maestro2 code is nearly identical. Any chance you'd
> give it the same treatment?

Yes, I already noticed it was nearly identical, but I didn't work
on it as I have no hardware to test any changes ...

> I should be able to dig up a few laptops to
> test both drivers if necessary.

I'll do an identical patch for the meastro2, if you could test that that wo=
uld
be great.

>
> <snip>
>> @@ -2524,6 +2494,42 @@ static int m3_resume(struct pci_dev *pci)
>>   }
>>   #endif /* CONFIG_PM */
>>
>> +#ifdef CONFIG_INPUT
>> +static int __devinit snd_m3_input_register(struct snd_m3 *chip)
>> +{
>> +	struct input_dev *input_dev;
>> +	int err;
>> +
>> +	input_dev =3D input_allocate_device();
>> +	if (!input_dev)
>> +		return -ENOMEM;
>> +
>> +	snprintf(chip->phys, sizeof(chip->phys), "pci-%s/input0",
>> +		 pci_name(chip->pci));
>
> What's the proper format of phys? I see gameport stuff uses
> pci%s/gameport0, ir stuff uses pci-%s/ir0. I can't immediately find any
> other pci input things.
>

I've no idea, I took the pci-%s/ part from other pci drivers registering
input devices and the input0 part is based on doing:
cat /sys/class/input/input?/phys

On my system which yields a string ending in input0 for almost all
input devices.

>> +
>> +	input_dev->name =3D chip->card->driver;
>> +	input_dev->phys =3D chip->phys;
>> +	input_dev->id.bustype =3D BUS_PCI;
>> +	input_dev->id.vendor  =3D chip->pci->vendor;
>> +	input_dev->id.product =3D chip->pci->device;
>> +	input_dev->dev.parent =3D&chip->pci->dev;
>> +
>> +	input_dev->evbit[0] =3D BIT_MASK(EV_KEY);
>> +	input_dev->keybit[BIT_WORD(KEY_MUTE)] |=3D BIT_MASK(KEY_MUTE);
>> +	input_dev->keybit[BIT_WORD(KEY_VOLUMEDOWN)] |=3D BIT_MASK(KEY_VOLUMEDO=
WN);
>> +	input_dev->keybit[BIT_WORD(KEY_VOLUMEUP)] |=3D BIT_MASK(KEY_VOLUMEUP);
>
> __set_bit() perhaps

Ah yes, good one.

>
>> +
>> +	err =3D input_register_device(input_dev);
>> +	if (err) {
>> +		input_dev->dev.parent =3D NULL;
>
> Is this nullification needed?
>

I copy pasted this from gspca's input handling code, as I'm
familiar with the gspca code, but looking at what
input_free_device actually does: no.

I'll respin the patch with these 2 issues fixed and repost it
+ an identical one for the es1968 driver.

>> +		input_free_device(input_dev);
>> +	} else {
>> +		chip->input_dev =3D input_dev;
>> +	}
>> +
>> +	return err;
>> +}
>> +#endif /* CONFIG_INPUT */
>>
>>   /*
>>    */
>

Regards,

Hans
