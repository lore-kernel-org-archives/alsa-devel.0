From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Tue, 11 Nov 2008 11:57:29 +0100
Message-ID: <49196519.1070903@powercraft.nl>
References: <4916FAB7.7050206@powercraft.nl>
	<s5hhc6ezo3g.wl%tiwai@suse.de>	<491953A4.8070509@powercraft.nl>
	<s5hljvqr1jr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node01.cambriumhosting.nl (node01.cambriumhosting.nl
	[217.19.16.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BF511037FB
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 11:57:39 +0100 (CET)
In-Reply-To: <s5hljvqr1jr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 11 Nov 2008 10:43:00 +0100,
> Jelle de Jong wrote:
>> Takashi Iwai wrote:
>>> At Sun, 09 Nov 2008 15:59:03 +0100,
>>> Jelle de Jong wrote:
>>>> Hello everybody,
>>>>
>>>> I am trying to use udev to get fixed device names depending on the
>>>> location of the device on the usb bus. The udev rules seems to be
>>>> working fine, however i cant get dmix to work with the udev rules using
>>>> only hw dies work. If i remove the udev rules the dmixer works fine.
>>>>
>>>> Can somebody look at the attachment, and maybe do some testing, i would
>>>> highly appreciate it.
>>> Swapping the card numbers with udev might have a problem because
>>> the driver itself remembers the card index, and this number isn't
>>> swapped -- thus you get inconsistency between the device file and
>>> the internal index number.
>>>
>>> BTW, if you just would like to keep the fixed device index for a
>>> certain usb device path, try my old patch below.
>>> It adds devpath option to snd-usb-audio, and you can specify the
>>> usb device path string ("usb-$BUSNAME-$DEVPATH").
>>>
>>>
>>> Takashi
>> Thank you Takashi for thanking the time to answer the question. I don't
>> understand. If udev created the card numbers in the first place,
>> swapping them should not make a difference?
> 
> udev just renames a file.
> But, the index number is stored in the driver itself, and it can be
> read via an API function.
> 
>> and why does the audio work
>> fine with only hw:x and not when using dmix:x.
> 
> Unless you change the device file name, it works.
> Or, use an id string instead of an index number.  The id string is
> found in /proc/asound/cards as [xxx].
> Or, you can simply set up the slots option of snd module or set up
> the index option of each module.  See ALSA-Configuration.txt.
> 
>> How is the internal index
>> number created?
> 
> Either via a module / kernel boot option, or created dynamically
> via the driver.
> 
>> Can I control this index with udev? did I forget
>> something in my udev rules?
> 
> No.  As mentioned, your udev rule just renames the file.
> 
>> Custom compiling sound modules is no option, it will break
>> maintainability of the system in every way, sorry for this not being an
>> sustainable option.
> 
> IMO, changing udev rule could be more fragile than a custom module...
> 
>> Almost all devices can be managed with udev rules, that is where the
>> system is designed for, there are also alsa rules in there, if they
>> don't work what is wrong then? is it an alsa issue, or udev, what are
>> the dependencies when alsa uses hardware. How are the /dev/snd/* devices
>> used and what is the /proc/asound/* for ?
> 
> The card index mechanism in ALSA was introduced much before udev
> was born.  It's just a legacy mechanism, but it's hard to kill without
> breaking the running system, unfortunately.
> 
> Takashi

When reading the explanations I understand that we are kind of dealing
with a legacy issue. Is it possible to add some features to alsa to
still get what I need to be able to always use a fixed usb port for
audio for one user. For example if i take the content of ../cards it is
capable of showing the usb path. If I can use this in my .asoundrc all
problems go away, and no need for udev rules to rename devices. This
same system is used input devices for Xorg with /dev/input/by-path/

cat /proc/asound/cards

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf7db8000 irq 16
 1 [pcsp           ]: PC-Speaker - pcsp
                      Internal PC-Speaker at port 0x61
 2 [Em28xx Audio   ]: Empia Em28xx AudEm28xx Audio - Em28xx Audio
                      Empia Em28xx Audio
 3 [default        ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.1, full speed
 4 [default_1      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.2, full speed
 5 [default_2      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.3, full speed
 6 [default_3      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.4, full speed

Would it be possible to create something like the below:

echo 'pcm.!default {
   type plug
   slave.pcm dmixer
}
pcm.dmixer {
   type dmix
   ipc_key 1024
   slave.pcm hw:path:usb-0000:00:1d.7-4.1
}
ctl.dmixer {
   type hw
   card path:usb-0000:00:1d.7-4.1
}
pcm.dsp {
    type plug
    slave.pcm dmixer
}
ctl.mixer {
    type hw
    card path:usb-0000:00:1d.7-4.1
}' | tee /home/user0/.asoundrc
chmod 600 /home/user0/.asoundrc
chown user0:user0 /home/user0/.asoundrc

Thanks in advance,

Jelle
