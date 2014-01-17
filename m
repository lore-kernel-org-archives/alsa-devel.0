From: siddharth <siddharth@greenearthnetwork.in>
Subject: Re: ProVideo PV 918A - audi o device created but
	cannot capture sound
Date: Fri, 17 Jan 2014 14:33:58 +0530
Message-ID: <57064bdb1c580b864c735a01d0d4bdea@imap.greenearthnetwork.in>
References: <loom.20140117T085941-825@post.gmane.org>
 <52D8EE31.4000304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from media.ostv.in (media.ostv.in [69.175.58.122])
 by alsa0.perex.cz (Postfix) with ESMTP id F3BA8261A7B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 10:06:40 +0100 (CET)
In-Reply-To: <52D8EE31.4000304@ladisch.de>
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

On 17-01-2014 14:17, Clemens Ladisch wrote:
> siddharth wrote:
>> modprobe snd-bt87x load_all=1 digital_rate=48000 enable=1
> 
> You are telling the driver that the tuner chip has a digital output 
> that
> runs at 48 kHz, and this it is connected to the digital input pin of 
> the
> Bt878 chip.
> 
>> but am unable to capture sound.
> 
> Do you actually know that your hardware is constructed that way?
> 
> How exactly did you try to capture?  From which device?  (see "arecord 
> -l")
> 
> 
> Regards,
> Clemens

I tried loading the module without the digital_rate param as well but to 
no avail.
Am not sure how the card hardware is constructed :( I just tried the 
digital_rate param after reading in the dmesg that it may work :)

But as soon as I load the module, the sound setting panel in gnome shows 
8 audio input devices. a video and a radio input device for each input 
(there are 4 hardware a/v inputs to the card)

arecord -l shows the following:
card 1: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: Bt878_1 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x 
Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: Bt878_1 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

....and so on till card 4.

For capturing, I used vlc alsa://hw:1,1 I also tried 1,0, 2,0 2,1 etc.
Even the sound setting app in gnome does not show any input, which it 
shows by a flickering equaliser for the native sound card of the 
machine.

regards
Siddharth
