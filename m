From: sypwex <sypwex@gmail.com>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Thu, 24 Sep 2015 12:04:50 +0300
Message-ID: <CAGPstWvo0EZ5=Nv_LiUSyLD_i4VJxkmBeKFdp0AYB4xHnBA3=Q@mail.gmail.com>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
 <560039B6.2000204@zonque.org>
 <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
 <560138E2.3020300@zonque.org>
 <CAGPstWshz0t8SCu_+DcKBF93JxDjaTiNxxJk-MU6iP_Xp8nyAg@mail.gmail.com>
 <56024A3D.8050709@zonque.org>
Reply-To: sypwex@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 93E3226047C
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 11:04:51 +0200 (CEST)
Received: by ioii196 with SMTP id i196so70095625ioi.3
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 02:04:50 -0700 (PDT)
In-Reply-To: <56024A3D.8050709@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <cladisch@googlemail.com>, sypwex@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2015 at 9:44 AM, Daniel Mack <daniel@zonque.org> wrote:
> On 09/22/2015 09:03 PM, sypwex wrote:
>> On Tue, Sep 22, 2015 at 2:17 PM, Daniel Mack <daniel@zonque.org> wrote:
>>>
>>> Yes, this device only offers HID and DFU (for firmware updates), so
>>> you'll have to parse the HID data it produces.
>>>
>>
>> Ok, but device looks like powered off - no flashes on tap and LED
>> display is blank. When I firstly attach USB cable all buttons flashes
>> but then it looks like switched off.
>
> Everything from that point on is under control of the host software.
>
>> On windows when I plug in the device, LED display offers to start up
>> in MIDI mode (SHIFT+F1) - is it controlled by driver or this is
>> behavior of firmware?
>
> I've personally never used this device, so I can't tell you what they
> do. You need to sniff the USB traffic the Windows software issues to the
> device and find out which HID controls they touch in order to set LEDs
> and issue display commands. IOW: you need to re-engineer the HID
> mapping. That's tedious, but doable.
>
>
> HTH,
> Daniel
>

Thanks Daniel!

Looks like I got the idea. I'll try it next week.

Cheers!
