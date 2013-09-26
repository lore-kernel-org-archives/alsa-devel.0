From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] Cannot load snd-usb-audio on 3.12-rc2
Date: Thu, 26 Sep 2013 10:10:43 +0200
Message-ID: <5243EC03.7050600@canonical.com>
References: <20130923234107.GA4876@xanatos> <5241B520.7010803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <5241B520.7010803@gmail.com>
Sender: linux-sound-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/24/2013 05:52 PM, Daniel Mack wrote:
> Hi Sarah,
> 
> On 24.09.2013 01:41, Sarah Sharp wrote:
>> The snd-usb-audio driver no longer loads properly on 3.12-rc2 when I
>> plug in my USB headset.  It worked fine on 3.11-rc4 (not sure about
>> vanilla 3.11).
>>
>> Trying to manually load the driver fails:
>>
>> sarah@xanatos:~$ sudo modprobe snd-usb-audio
>> FATAL: Error inserting snd_usb_audio
>> (/lib/modules/3.12.0-rc2/kernel/sound/usb/snd-usb-audio.ko): Invalid argument
>>
>> dmesg shows:
>>
>> [   44.231668] snd_usb_audio: `-2' invalid for parameter `index'
> 
> That's really strange. I just tested on an ARM board where I currently
> run 3.12-rc2 as well, and I can load the module without problems. Also,
> sound/usb/card.c (where the params are declared) hasn't seen an update
> in 3.12.
> 
> I suspect your OS is passing "index=-2" from something like
> /etc/modprobe.d/* or cmdline settings. Could you investigate in that
> direction?

Ubuntu has passed

options snd-usb-audio index=-2

...since ages. It is, AFAIK, a very valid way of trying to make "some
other card" be card 0.
This is because card 0 is the default in some apps which are not using
PulseAudio, so it's mostly there for historical reasons.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
