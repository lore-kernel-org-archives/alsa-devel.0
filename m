From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: HP Pavillion TX2000z - Headphonejack not working
Date: Thu, 11 Dec 2008 18:07:49 +0100
Message-ID: <d9690f190812110907w7fe7c0d4w4a71b4e0c36f3300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DBDA1037FD
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 18:07:51 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so1138460rne.21
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 09:07:50 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks.

Another problem now with HP and realtek AC861VD.

The headphone-jack is not working.

Known issue?

THX

\Klaus


QUOTE:

--------------------------

drivers 1.0.18a

HP Pavillion tx2000z,
Realtek AC861VD,
Alsa version 1.0.18a.
Running Ubuntu Studio Intrepid 8.10
Kernel 2.6.27-9-generic

options snd-hda-intel model=hp

kqian@kkqian:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC861VD Analog [ALC861VD Analog]
Subdevices: 1/1
Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC861VD Digital [ALC861VD Digital]
Subdevices: 1/1
Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 6: Si3054 Modem [Si3054 Modem]
Subdevices: 1/1
Subdevice #0: subdevice #0
kqian@kkqian:~$ cat /proc/asound/card0/codec#* | grep Codec
Codec: Realtek ALC861-VD
Codec: Motorola Si3054

Oh, I should also add, headphones do not show up in volume control.
I have checked the switches, as well as the main interface. The only things
that are there are:

Master,
PCM,
Front,
Front Mic,
Front Mic Boost,
Microphone,
Mic Boost,
Speaker,
Capture,
IEC958,
IEC958 Default PCM,
Caller ID,
Off-hook,
Input Source,

All of them are checked, and none of them are muted.
