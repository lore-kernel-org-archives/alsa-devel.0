From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Fireworks driver
Date: Fri, 17 Jun 2011 13:17:43 +0200
Message-ID: <4DFB37D7.5030204@ladisch.de>
References: <4DFAF3AC.3030506@nostar.net> <4DFAFF24.9000401@ladisch.de>
	<4DFB007E.9090805@nostar.net> <4DFB0643.7070700@ladisch.de>
	<4DFB1F0B.5010201@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 49753103824
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 13:14:42 +0200 (CEST)
In-Reply-To: <4DFB1F0B.5010201@nostar.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Doug McLain wrote:
> > > [nostar@iggy firewire]$ cat /proc/asound/cards
> > >  3 [AudioFire12    ]: Fireworks - AudioFire12
> > >                       Echo Digital Audio AudioFire12 v5.0, GUID 0014860fc44a84a6 at fw1.0, S400
>
> [nostar@iggy export]$ aplay -D plughw:AudioFire12 wg.wav
> aplay: main:660: audio open error: No such file or directory
> 
> [nostar@iggy export]$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 0: NVidia [HDA NVidia], device 1: ALC1200 Digital [ALC1200 Digital]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 0: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0

There is not PCM device for the AF12.

In theory, it shouldn't be possible for the driver to attach to the
device without having created the PCM device.  Are you sure that you
have the latest version of the driver?  Where exactly did you get it
from?  Please check that the fireworks.c file has 2275 lines, like this
one:
http://git.alsa-project.org/?p=alsa-kprivate.git;a=blob;hb=fireworks;f=sound/firewire/fireworks.c


Regards,
Clemens
