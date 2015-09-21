From: Daniel Mack <daniel@zonque.org>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Mon, 21 Sep 2015 19:09:10 +0200
Message-ID: <560039B6.2000204@zonque.org>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 276F4261551
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 19:09:12 +0200 (CEST)
In-Reply-To: <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sypwex@gmail.com, Clemens Ladisch <cladisch@googlemail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, daniel@caiaq.de
List-Id: alsa-devel@alsa-project.org

On 09/19/2015 11:20 AM, sypwex wrote:
> ow, sorry! I not mentioned that there is no PID of Maschine Mikro
> (0x1110) in caiaq device list
> _https://github.com/torvalds/linux/blob/v4.2/sound/usb/caiaq/device.h_
> 
> yes there is some endless dump from usbhid but I don't know how to deal
> with it
> $sudo usbhid-dump --entity=all --address=1:15
> http://pastebin.com/raw.php?i=KC96ERSV (300KiB)
> 
> ok, I've tried to extend the driver and end up with following doodad
> https://github.com/krasnobaev/linux/commits/feature/caiaq-mmikro-1
> for every commit I've generated dmesg log
> _http://pastebin.com/raw.php?i=pJzdAyf4_

Maschine Mikro is a class compliant USB device which implements a
completely different protocol compared to the old devices. The
snd-usb-caiaq driver is unsuitable of handling and of the details
exposed by device, so this approach is definitely a dead end.

What does 'lsusb -v' show when you plug in the device?


Thanks,
Daniel
