From: Milan Oravec <moravec@ukf.sk>
Subject: Re: SoundBlaterX G5
Date: Sun, 15 Jan 2017 13:59:18 +0100
Message-ID: <54f8d240-bc89-31da-157b-032f0ffe1143@ukf.sk>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
 <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmail2.ukf.sk (inmail2.ukf.sk [193.87.12.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 0830B2654AD
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 13:59:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by inmail2.ukf.sk (Postfix) with ESMTP id A6ADBFC838
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 13:59:26 +0100 (CET)
Received: from inmail2.ukf.sk ([127.0.0.1])
 by localhost (inmail2.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-YGtDT5nlMw for <alsa-devel@alsa-project.org>;
 Sun, 15 Jan 2017 13:59:22 +0100 (CET)
Received: from posta.ukf.sk (posta.ukf.sk [193.87.12.33])
 by inmail2.ukf.sk (Postfix) with ESMTPS id D852BFC835
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 13:59:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by posta.ukf.sk (Postfix) with ESMTP id 1E1E824300A
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 13:59:23 +0100 (CET)
Received: from posta.ukf.sk ([127.0.0.1])
 by localhost (posta.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jy8afOcIZG1X for <alsa-devel@alsa-project.org>;
 Sun, 15 Jan 2017 13:59:19 +0100 (CET)
Received: from [192.168.15.252] (unknown [5.22.154.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by posta.ukf.sk (Postfix) with ESMTP id 1C8BF242F41
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 13:59:19 +0100 (CET)
In-Reply-To: <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
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

I can change value of this switch with alsamixer, but 96k is claimed 
maximum. Can I force 192k sample rate with some module parameter? What 
can I try?

Thank you very much!

Kind regards,

Milan

Here is alsa-info output:

  http://www.alsa-project.org/db/?f=e806ab89935bc35b616ef74f8033dfab6c3240c6

and

migo@migo_lenovo:~$ pacmd list-sinks
1 sink(s) available.
   * index: 0
	name: 
<alsa_output.usb-Creative_Technology_Ltd_Sound_BlasterX_G5_2800534752X-00.analog-stereo>
	driver: <module-alsa-card.c>
	flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY 
DYNAMIC_LATENCY
	state: SUSPENDED
	suspend cause: IDLE
	priority: 9049
	volume: front-left: 58369 /  89% / -3,02 dB,   front-right: 58369 / 
89% / -3,02 dB
	        balance 0,00
	base volume: 65536 / 100% / 0,00 dB
	volume steps: 65537
	muted: no
	current latency: 0,00 ms
	max request: 0 KiB
	max rewind: 0 KiB
	monitor source: 0
	sample spec: s24le 2ch 96000Hz
	channel map: front-left,front-right
	             Stereo
	used by: 0
	linked by: 0
	configured latency: 0,00 ms; range is 0,50 .. 1820,44 ms
	card: 0 
<alsa_card.usb-Creative_Technology_Ltd_Sound_BlasterX_G5_2800534752X-00>
	module: 6
	properties:
		alsa.resolution_bits = "24"
		device.api = "alsa"
		device.class = "sound"
		alsa.class = "generic"
		alsa.subclass = "generic-mix"
		alsa.name = "USB Audio"
		alsa.id = "USB Audio"
		alsa.subdevice = "0"
		alsa.subdevice_name = "subdevice #0"
		alsa.device = "0"
		alsa.card = "0"
		alsa.card_name = "Sound BlasterX G5"
		alsa.long_card_name = "Creative Technology Ltd Sound BlasterX G5 at 
usb-0000:00:1d.7-3.1, high speed"
		alsa.driver_name = "snd_usb_audio"
		device.bus_path = "pci-0000:00:1d.7-usb-0:3.1:1.0"
		sysfs.path = 
"/devices/pci0000:00/0000:00:1d.7/usb2/2-3/2-3.1/2-3.1:1.0/sound/card0"
		udev.id = "usb-Creative_Technology_Ltd_Sound_BlasterX_G5_2800534752X-00"
		device.bus = "usb"
		device.vendor.id = "041e"
		device.vendor.name = "Creative Technology, Ltd"
		device.product.id = "3243"
		device.product.name = "Sound BlasterX G5"
		device.serial = "Creative_Technology_Ltd_Sound_BlasterX_G5_2800534752X"
		device.string = "front:0"
		device.buffering.buffer_size = "1048572"
		device.buffering.fragment_size = "524286"
		device.access_mode = "mmap+timer"
		device.profile.name = "analog-stereo"
		device.profile.description = "Analog Stereo"
		device.description = "Sound BlasterX G5 Analog Stereo"
		alsa.mixer_name = "USB Mixer"
		alsa.components = "USB041e:3243"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-usb"
	ports:
		analog-output-speaker: Speakers (priority 10000, latency offset 0 
usec, available: unknown)
			properties:
				device.icon_name = "audio-speakers"
	active port: <analog-output-speaker>



s pozdravom

Milan Oravec

CIKT UKF Nitra
mobil: +421907670270
email: moravec@ukf.sk

--------------------------------------------------------------------

Tuto spravu nepreveril ziadny antivirus - nebolo treba...

On 15.01.2017 11:29, Clemens Ladisch wrote:
> Milan Oravec wrote:
>> http://www.alsa-project.org/db/?f=74ca49f354e9a100ebf7ba9fe9f6eb82c019f3ef
>>
>> The device is 192K/24 capable under OSX but only when is DSP clock
>> source set to direct stereo, this may be the problem in linux.
>
> There is a mixer control named "Speaker Clock Source".  Doesn't it work?
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
