From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: RME Fireface alsa driver
Date: Wed, 12 Dec 2018 05:43:44 +0900
Message-ID: <20181211204344.GA16818@workstation>
References: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 96227267BE2
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 21:43:53 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id n2so7188974pgm.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 12:43:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thet <parenthetical@halfshavedyaks.xyz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Dec 11, 2018 at 07:51:25PM +0000, thet wrote:
> I posted this a couple of weeks ago in the alsa users list but there was
> no response. I hope someone here can help.
> =

> I have a FF400 and I have been using ffado with it.
> =

> It came to my attention that there exists a ALSA driver for the FF400
> since the midi was working over alsa and midi is not supported in the
> ffado driver.
> =

> Also my system can see the FF400 in the sound control panel without jack
> or ffado running.
> =

> I am using Mint 19 cinnamon and the liquorix kernel. (though so far I
> have not noticed any difference between the liquorix kernel and the
> generic one except pre-empt performance).
>
> I would like to try using just the alsa driver and not ffado. Since I'm
> using the alsa midi support anyway it would be less total software to
> use the alsa driver for everything - assuming it supports everything I ne=
ed
> for serious music recording.
> =

> However I can't get any sound out of the FF400 using the ALSA driver -
> it works ok with FFADO though. Also the midi works - presumably using
> the alsa driver.
> =

> I have tried using alsa directly in the sound control panel, using the
> alsa output from audacious, and the alsa driver from jack.
> =

> I get an error about setting the frames/period/buffer size.
 =

Please share the 'error' with your command line. It's the most
important. Furthermore, please check kernel message with journalctl(1).

> The red light on the FF400 that shows no connection to a host stays on=A0=
 -
> even though the system can see it is present. This light goes off if I
> start ffado and jack, or if I start ffado mixer.
> =

> Is there a guide somewhere on how to set up the ALSA drivers for the FF40=
0?

I left the device already[2] and can't regenerate this issue, but in my
memory the device can generate sound when the red LED turns on. =



Some registers on Fireface 400 for configuration are write-only. To
avoid interrupting userspace software such as ffado stuffs, ALSA
fireface driver is programmed not to touch such registers. This means
that the driver requires some assists of userspace.

The red LED labeled 'HOST' is put off when writing a byte to a register =

In a case of Fireface 400, 0x'0000'8010'03fc is the register. But this
includes some settings for output signal of S/PDIF in coaxial interface.
You can set the register with linux-firewire-utils[1], for example.

$ ./firewire-request /dev/fw1 write 0x0000801003fc 0x1f
(The unit allows block request for 1 byte access.)

Or install 'libhinawa1' and 'gir1.2-hinawa-2.0' package and run below
script.

```
#!/usr/bin/python3

import gi
gi.require_version('Hinawa', '2.0')
from gi.repository import Hinawa

unit =3D Hinawa.FwUnit()
unit.open('/dev/fw1')
unit.listen()

req =3D Hinawa.FwReq()
req.append(0x1f)
req.write(unit, 0x0000801003fc, 0x1f)
```

[1] https://github.com/cladisch/linux-firewire-utils
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/1022=
61.html


Regards

Takashi Sakamoto
