From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Sat, 25 Apr 2015 21:01:25 +0900
Message-ID: <553B8215.1060603@sakamocchi.jp>
References: <CAJ0eYfW4iatW+L+d+Y-9CAACfZVq7V=a575iRy9tTJ0SMjwXXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C2D2614FF
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 14:01:30 +0200 (CEST)
In-Reply-To: <CAJ0eYfW4iatW+L+d+Y-9CAACfZVq7V=a575iRy9tTJ0SMjwXXQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Apr 24 2015 21:27, Mike Ood wrote:
> Takashi Sakamoto wrote:
> 
>>> % cat /proc/asound/card2/firewire/clock
>>> Sampling rate: 44100
>>> Clock Source: External (MSU-dest: 7)
>>
>> According to this output, the internal clock of your device is set to
>> synchronize to external source such as S/PDIF or word clock.
> 
> Oops. Let me boot my Windows7 again, and see..
> https://spinorlab.wordpress.com/2015/04/24/orpheus-and-its-sync-source/
> (see orpheussyncsource.jpg)
> 
> The control program by PrismSound tells that the Sync Source is Local,
> which means it is a Master and System is sync'ed to Orpheus's
> local clock.
> 
> http://www.prismsound.com/music_recording/products_subs/orpheus/online_manual/index.html
> (Contents -> Orpheus hardware -> Synchronization)
> (Contents -> Orpheus software -> Orpheus Control Panel)
> 
> Funny?

Not funny, but headache. It's a customization by hardware vendor, I
mentioned. (in this case, by PrismSound Ltd.)

BridgeCo AG (currently ArchWave AG) produced DM1000/DM1100/DM1500
chipset with BeBoB firmware. PrismSound Ltd. utilized the chipset and
firmware for streaming functionality of your Orpheus.

BeBoB firmware gives common ways to control itself, while the hadware
vendor added their own cusomization against it. I don't know exactly the
reason because there're few information about your device.

> I am not sure, but I think I gave it correctly to Local Sync Source.

Actually, it's not synchronized in an aspect of streaming protocol
because DMxxx chipset and BeBoB can transfer continuous packets in its
streaming.

>> because libffado implements loose
>> checker of packet discontinuity.
> 
> I do not understand techinical details, but the sound was
> perfect even with 192kHz/24bit audio using libffado.

Ditto. libffado works with such broken stream by ignoring its packet
index. I guess that you've continued to use your device with
uns-ynchronized state for several years because no one reports it.

> So if it's only a
> #define TIMER_SOMETHING value_anything
> type of things...

I cannot understand what you mean.

>> Currently, libffado has a bug to fail to switch clock
>> source for usual BeBoB driver.
>> So we have no way to set the source of clock correctly.
>> I've tried to fix it but get stuck deeply into
>> ffado's fault and given up.
> 
> As for me, clock source settings, etc.,
> which is written into its EEPROM when powered off,
> can be occasionally set via the control program
> by PrismSound either on Windows/OS X,
> only when it becomes necessary.

Unless fully understanding specifications about your device, you cannot
make firm statement about it, I think. The drivers installed in Windows
or OS X can set the synchronization when plugging-in.


Regards

Takashi Sakamoto
