From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 19:13:21 +0900
Message-ID: <553A1741.9020705@sakamocchi.jp>
References: <CAJ0eYfXCX_0C-v0cGOwieDDCOn6q4Mt9JvBG7CxA51yOrALSpw@mail.gmail.com>
 <5539FECC.8050609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FDF7260554
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:13:39 +0200 (CEST)
In-Reply-To: <5539FECC.8050609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 23 2015 21:13, Mike Ood wrote:
> % cat /proc/asound/card2/firewire/clock
> Sampling rate: 44100
> Clock Source: External (MSU-dest: 7)

According to this output, the internal clock of your device is set to
synchronize to external source such as S/PDIF or word clock.

If your device is implemented with no customization of the setting and
you didn't give any external sources to your device, the device is not
synchronized.
(If you give it correctly, please inform it to us.)

I think this is a cause of this issue.
 * Your device lost synchronization.
 * Transfers streaming packets with discontinuity.
 * Then snd-bebob driver (in fact snd-firewire-lib) cannot continue.

On Apr 24 2015 17:29, Clemens Ladisch wrote:
>> this is just after % aplay -D plughw:2,0 test.wav
>> ...
>> [  110.580310] firewire_core 0000:08:00.0: created device fw1: GUID 00119800010001f9, S400
>> [  113.660273] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
>> [  128.010593] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
>> [  133.416998] snd-bebob fw1.0: Detect discontinuity of CIP: 00 08
>> [  136.275142] snd-bebob fw1.0: Detect discontinuity of CIP: 50 70
>> [  137.654178] snd-bebob fw1.0: Detect discontinuity of CIP: 70 90
> 
> This means that some packet to be received from the device is (or
> appears to be) missing.  In theory, this is supposed to happen only when
> noise on the cable has corrupted the signal, but this might be a problem
> with this device's firmware.
> 
> Does this device (with this cable) work in Windows or OS X?

libffado also supports this device and I guess you can start streaming
with jackd and firewire backend because libffado implements loose
checker of packet discontinuity.

Currently, libffado has a bug to fail to switch clock source for usual
BeBoB driver. So we have no way to set the source of clock correctly.
I've tried to fix it but get stuck deeply into ffado's fault and given up.

For our information:
http://subversion.ffado.org/wiki/AvcModels/PrismSoundOrpheus


Regards

Takashi Sakamoto
