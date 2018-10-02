From: =?UTF-8?B?VGhvbWFzIEdsw6TDn2xl?= <thomas@coldfix.de>
Subject: Re: alsactl monitor spins at 100% cpu after unplugging
 USB headphones
Date: Tue, 2 Oct 2018 12:48:45 +0200
Message-ID: <d0947e3e-4746-8f8d-ce5e-b9a623e89238@coldfix.de>
References: <b240e23c-6be9-fd53-e62a-8ef65e5a9070@coldfix.de>
 <fbc30e1a-87b2-b22a-c3c6-dd7a424d2b75@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coldfix.de (coldfix.de [37.120.171.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC342676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 12:48:45 +0200 (CEST)
In-Reply-To: <fbc30e1a-87b2-b22a-c3c6-dd7a424d2b75@sakamocchi.jp>
Content-Language: en-US-large
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Sakamoto wrote on 10/2/18 11:01 AM:
> Thank you for this report and I can regenerate this problem.
>
> $ strace alsactl monitor
> ...
> (disconnect my sound device)
> poll([{fd=3, events=POLLIN|POLLERR|POLLNVAL}, {fd=4,
> events=POLLIN|POLLERR|POLLNVAL}, {fd=5,
> events=POLLIN|POLLERR|POLLNVAL}], 3, -1) = 1 ([{fd=5,
> revents=POLLERR|POLLNVAL}])
> poll([{fd=3, events=POLLIN|POLLERR|POLLNVAL}, {fd=4,
> events=POLLIN|POLLERR|POLLNVAL}, {fd=5,
> events=POLLIN|POLLERR|POLLNVAL}], 3, -1) = 1 ([{fd=5,
> revents=POLLERR|POLLNVAL}])
> ...
>
> This is a bug of alsactl due to handling return code of poll(2) system
> call[1].
>
> In an operation to ALSA control character devices, when handled device
> is disconnected, a call of poll(2) returns positive value to notify
> events with 'EPOLLERR | EPOLLNVAL'[2].
>
> Soon I'll post a patch to improve this behaviour of alsactl.

Thank you a lot, this is great news!

Cheers, Thomas


>
>> I'm sorry if this is not the right place to report this issue or if the
>> problem is already, I couldn't find anything about it.
>>
>>
>> Below is the output from alsa-info.sh:
>>
>> with headphones:
>>
>> http://www.alsa-project.org/db/?f=0dfc632e3adafb8bc78a182e0a225bcb13bea9fa
>>
>>
>> after unplugging:
>>
>> http://www.alsa-project.org/db/?f=41dbf0735fdd7cd2416a6b4a602505715d25b44f
>>
>>
>> Please let me know if you need further info.
>
> You did enough good. Thank you and wait for a while till I'll fix it.
>
> [1]
> http://git.alsa-project.org/?p=alsa-utils.git;a=blob;f=alsactl/monitor.c;hb=HEAD#l120
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/core/init.c?h=for-next#n347
>
>
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
