From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Tue, 11 Nov 2008 10:43:00 +0100
Message-ID: <491953A4.8070509@powercraft.nl>
References: <4916FAB7.7050206@powercraft.nl> <s5hhc6ezo3g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node01.cambriumhosting.nl (node01.cambriumhosting.nl
	[217.19.16.162]) by alsa0.perex.cz (Postfix) with ESMTP id DA41D24580
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 10:43:08 +0100 (CET)
In-Reply-To: <s5hhc6ezo3g.wl%tiwai@suse.de>
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
> At Sun, 09 Nov 2008 15:59:03 +0100,
> Jelle de Jong wrote:
>> Hello everybody,
>>
>> I am trying to use udev to get fixed device names depending on the
>> location of the device on the usb bus. The udev rules seems to be
>> working fine, however i cant get dmix to work with the udev rules using
>> only hw dies work. If i remove the udev rules the dmixer works fine.
>>
>> Can somebody look at the attachment, and maybe do some testing, i would
>> highly appreciate it.
> 
> Swapping the card numbers with udev might have a problem because
> the driver itself remembers the card index, and this number isn't
> swapped -- thus you get inconsistency between the device file and
> the internal index number.
> 
> BTW, if you just would like to keep the fixed device index for a
> certain usb device path, try my old patch below.
> It adds devpath option to snd-usb-audio, and you can specify the
> usb device path string ("usb-$BUSNAME-$DEVPATH").
> 
> 
> Takashi

Thank you Takashi for thanking the time to answer the question. I don't
understand. If udev created the card numbers in the first place,
swapping them should not make a difference? and why does the audio work
fine with only hw:x and not when using dmix:x. How is the internal index
number created? Can I control this index with udev? did I forget
something in my udev rules?

Custom compiling sound modules is no option, it will break
maintainability of the system in every way, sorry for this not being an
sustainable option.

Almost all devices can be managed with udev rules, that is where the
system is designed for, there are also alsa rules in there, if they
don't work what is wrong then? is it an alsa issue, or udev, what are
the dependencies when alsa uses hardware. How are the /dev/snd/* devices
used and what is the /proc/asound/* for ?

Would it be possible to test my udev rules that I posted, they are not
difficult and don't change your system just add the file do some testing
then remove the file when done...

I can also sent some usb audio devices to some developers to do some
testing.

Any help is appreciated.

Best regards,

Jelle
