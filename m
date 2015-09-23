From: Daniel Mack <daniel@zonque.org>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Wed, 23 Sep 2015 08:44:13 +0200
Message-ID: <56024A3D.8050709@zonque.org>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
 <560039B6.2000204@zonque.org>
 <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
 <560138E2.3020300@zonque.org>
 <CAGPstWshz0t8SCu_+DcKBF93JxDjaTiNxxJk-MU6iP_Xp8nyAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D88FA2604A3
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 08:44:12 +0200 (CEST)
In-Reply-To: <CAGPstWshz0t8SCu_+DcKBF93JxDjaTiNxxJk-MU6iP_Xp8nyAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sypwex@gmail.com
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <cladisch@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On 09/22/2015 09:03 PM, sypwex wrote:
> On Tue, Sep 22, 2015 at 2:17 PM, Daniel Mack <daniel@zonque.org> wrote:
>>
>> Yes, this device only offers HID and DFU (for firmware updates), so
>> you'll have to parse the HID data it produces.
>>
> 
> Ok, but device looks like powered off - no flashes on tap and LED
> display is blank. When I firstly attach USB cable all buttons flashes
> but then it looks like switched off.

Everything from that point on is under control of the host software.

> On windows when I plug in the device, LED display offers to start up
> in MIDI mode (SHIFT+F1) - is it controlled by driver or this is
> behavior of firmware?

I've personally never used this device, so I can't tell you what they
do. You need to sniff the USB traffic the Windows software issues to the
device and find out which HID controls they touch in order to set LEDs
and issue display commands. IOW: you need to re-engineer the HID
mapping. That's tedious, but doable.


HTH,
Daniel
