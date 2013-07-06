From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [usb-audio] VIA/Audinst HUD-mx2: One of two PCM
 device is available for playback
Date: Sat, 06 Jul 2013 20:21:09 +0900
Message-ID: <51D7FDA5.3080006@sakamocchi.jp>
References: <51D3662A.9010708@sakamocchi.jp> <51D55B01.2090705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 638D5264EF3
 for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2013 13:21:15 +0200 (CEST)
In-Reply-To: <51D55B01.2090705@ladisch.de>
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

Thanks Clemens,

 > This device has multiple alternate settings for PCM and AC-3 playback.
 > The driver creates multiple devices for those because it has no other
 > mechanism to distinguish them.

I want to ask further question about this.

Can we realize whether the PCM device for AC-3 stream (hw:0,0) works or 
not from the output of lsusb? The sound card has several outputs 
(headphone, line, S/PDIF) and I don't know only hw:0,1 connects to all 
of them or not.

 > Entires like these in ~/.asoundrc or /etc/asound.conf:
 >
 >    defaults.pcm.card 0
 >    defaults.pcm.device 1

But the device is connected by USB. The card ID differs depending on the 
user's system. If the other sound card is identified as "card 0", this 
setting is applied to it, not to the target device.

Can we write additional information to identify this sound card in these 
line?

 > I'd guess the driver could be changed to enumerate alternate settings
 > in two steps, first for PCM formats, then for others.

This is a better solution. But I have a little knowledgement about USB 
Audio Class and it's implementation to ALSA.


Regards

Takashi Sakamoto

(Jun 04 2013 20:22), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> This sound card has two PCM devices. If the sound card is realized "card
>> 0", there are "hw:0,0" and "hw:0,1". But former seems not to generate
>> sound and latter seems to generate.
>
> This device has multiple alternate settings for PCM and AC-3 playback.
> The driver creates multiple devices for those because it has no other
> mechanism to distinguish them.
>
> The AC-3 setting happens to be listed first in the descriptors.
>
>> 2. are there some ways to use hw:0,1 as a default?
>
> Entires like these in ~/.asoundrc or /etc/asound.conf:
>
>    defaults.pcm.card 0
>    defaults.pcm.device 1
>
>
> I'd guess the driver could be changed to enumerate alternate settings in
> two steps, first for PCM formats, then for others.
>
>
> Regards,
> Clemens
