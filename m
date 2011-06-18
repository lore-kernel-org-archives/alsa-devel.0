From: Doug McLain <doug@nostar.net>
Subject: Re: ALSA Fireworks driver
Date: Sat, 18 Jun 2011 17:18:53 -0400
Message-ID: <4DFD163D.9050408@nostar.net>
References: <4DFAF3AC.3030506@nostar.net> <4DFAFF24.9000401@ladisch.de>
	<4DFB007E.9090805@nostar.net> <4DFB0643.7070700@ladisch.de>
	<4DFB1F0B.5010201@nostar.net> <4DFB37D7.5030204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A37C024378
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jun 2011 23:20:04 +0200 (CEST)
Received: by iyn35 with SMTP id 35so1622605iyn.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2011 14:20:03 -0700 (PDT)
In-Reply-To: <4DFB37D7.5030204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aha! I had an older version that someone from the ffado list pointed me 
to.  I grabbed the .c and .h file from your link and built them (after 
defining CSR_IPCR and CSR_OPCR locally, my kernel-dev pkg doesnt have 
them) and now jack starts and I can record and play from ardour, but 
only at 44.1Khz, even though I start jackd with -r48000.  It looks like 
44.1Khz is the default setting the AF12 powers up at, and the alsa 
driver doesn't know how to change SR yet, is this the case?

I start the device up using ffado to force it into 48K, but then jack 
will no longer start using the alsa driver until I cycle power on the 
device.

The driver appears to work good in 44.1K though.  Aplay plays wav files 
using plughw, but not hw.

I also wonder if you can explain to me how to clone just that driver so 
I can keep up with it correctly using git pull.  I'm a little weak on 
git.  I just grabbed the .c and .h files manually and made my own 
Makefile for standalone module building.

Doug

On 06/17/2011 07:17 AM, Clemens Ladisch wrote:
> Doug McLain wrote:
>>>> [nostar@iggy firewire]$ cat /proc/asound/cards
>>>>   3 [AudioFire12    ]: Fireworks - AudioFire12
>>>>                        Echo Digital Audio AudioFire12 v5.0, GUID 0014860fc44a84a6 at fw1.0, S400
>>
>> [nostar@iggy export]$ aplay -D plughw:AudioFire12 wg.wav
>> aplay: main:660: audio open error: No such file or directory
>>
>> [nostar@iggy export]$ aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>> card 0: NVidia [HDA NVidia], device 1: ALC1200 Digital [ALC1200 Digital]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>> card 0: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>>     Subdevices: 1/1
>>     Subdevice #0: subdevice #0
>
> There is not PCM device for the AF12.
>
> In theory, it shouldn't be possible for the driver to attach to the
> device without having created the PCM device.  Are you sure that you
> have the latest version of the driver?  Where exactly did you get it
> from?  Please check that the fireworks.c file has 2275 lines, like this
> one:
> http://git.alsa-project.org/?p=alsa-kprivate.git;a=blob;hb=fireworks;f=sound/firewire/fireworks.c
>
>
> Regards,
> Clemens
