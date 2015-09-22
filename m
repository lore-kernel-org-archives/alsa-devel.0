From: sypwex <sypwex@gmail.com>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Tue, 22 Sep 2015 22:03:59 +0300
Message-ID: <CAGPstWshz0t8SCu_+DcKBF93JxDjaTiNxxJk-MU6iP_Xp8nyAg@mail.gmail.com>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
 <560039B6.2000204@zonque.org>
 <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
 <560138E2.3020300@zonque.org>
Reply-To: sypwex@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3B926511F
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 21:04:01 +0200 (CEST)
Received: by iofb144 with SMTP id b144so24160879iof.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 12:04:00 -0700 (PDT)
In-Reply-To: <560138E2.3020300@zonque.org>
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

On Tue, Sep 22, 2015 at 2:17 PM, Daniel Mack <daniel@zonque.org> wrote:
>
> Yes, this device only offers HID and DFU (for firmware updates), so
> you'll have to parse the HID data it produces.
>

Ok, but device looks like powered off - no flashes on tap and LED
display is blank. When I firstly attach USB cable all buttons flashes
but then it looks like switched off.

On windows when I plug in the device, LED display offers to start up
in MIDI mode (SHIFT+F1) - is it controlled by driver or this is
behavior of firmware?

Thanks,
Aleksey.
