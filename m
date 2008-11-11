From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Tue, 11 Nov 2008 12:21:30 +0100
Message-ID: <49196ABA.6000903@powercraft.nl>
References: <4916FAB7.7050206@powercraft.nl>
	<s5hhc6ezo3g.wl%tiwai@suse.de>	<491953A4.8070509@powercraft.nl>
	<s5hljvqr1jr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0811111151260.13649@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node01.cambriumhosting.nl (node01.cambriumhosting.nl
	[217.19.16.162]) by alsa0.perex.cz (Postfix) with ESMTP id E95F4245C2
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:21:38 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0811111151260.13649@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 11 Nov 2008, Takashi Iwai wrote:
> 
>>> Almost all devices can be managed with udev rules, that is where the
>>> system is designed for, there are also alsa rules in there, if they
>>> don't work what is wrong then? is it an alsa issue, or udev, what are
>>> the dependencies when alsa uses hardware. How are the /dev/snd/* devices
>>> used and what is the /proc/asound/* for ?
>> The card index mechanism in ALSA was introduced much before udev
>> was born.  It's just a legacy mechanism, but it's hard to kill without
>> breaking the running system, unfortunately.
> 
> Note that you can identify your card via the text identification (check 
> /proc/asound/cards to get it in []). You can set this identification in 
> the module insert time and use for example 'hw:Intel' in your apps without 
> bothering with indexes.
> 
> The missing part is the modification of this text identification using
> sysfs at runtime for udev. Some time ago, I was trying to add this setup 
> to /sys/class/sound, but the sysfs core code was not prepared for this 
> change. I'll try to check the situation again.
> 
> 					Jaroslav

I wish it was as simple as using the [identification ]. The [id..] is
not reliable for one usb port, as you can below I just unplugged some
usb audio devices and plugged it in again. The [id] does not match the
same usb location port anymore, so breaking the
user->unique-usb-port-audio-device connection.

Being able to set the id with udev would be an possible solution.

cat /proc/asound/cards (first)
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

cat /proc/asound/cards (second)
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf7db8000 irq 16
 1 [pcsp           ]: PC-Speaker - pcsp
                      Internal PC-Speaker at port 0x61
 3 [default        ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.3, full speed
 4 [default_1      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.2, full speed
 5 [default_2      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.4, full speed
 6 [default_3      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-4.1, full speed

Also the limitation of [0-7] devices is kind of unclear does it
something to do with limitations of timers?

Best regards,

Jelle
