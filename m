From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Sun, 3 Oct 2010 14:00:45 +0200
Message-ID: <20101003120045.GF10432@buzzloop.caiaq.de>
References: <4C9DC7A1.8050001@showlabor.de> <4CA5BF35.2030108@showlabor.de>
	<4CA60C5B.6010809@ladisch.de> <4CA86E1A.30405@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 13A58103859
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 14:00:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA86E1A.30405@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 03, 2010 at 01:50:50PM +0200, Felix Homann wrote:
> Am 03.10.2010 12:02, schrieb Daniel Mack:
> >How is this device clocked? It could be the PLL can't get a valid link
> >to its clock source and hence "jumps" once in awhile to compensate the
> >drift. Is there any possibility to sync the device to some sort o
> >digital input?
> 
> The device should be clocked internally. But it has an option to be
> clocked externally at least in Windows. I don't know how this is
> handled in Alsa's USB audio driver. (Could you please tell me?)

I assume the device implements UAC in version 1? In this case, clock
switching is not part of the standard and will most probably need
special handling in the driver (vendor specific requests).

For UAC2 though, there is a way to descrbibe avaliable clock sources,
switches etc.

> Some time ago I logged (via usbmon) the USB packets switching the
> device on in Windows. Could these logs be useful?

Switching the clock source you mean? Sure - code to generate these
packets should be placed in handlers for a device-specific mixer
control.

> Either way, I'll try to connect it to another SPDIF device and look
> for differences.

The idea of wrng clocking is just an assumption though. Maybe it is
totally unrelated. It's just that we had similar issues with PLLs going
nuts on missing sync input.

> >If the clicks you hear are very regular, it could also be that some
> >kind of buffer boundary is not handled properly. Do you have access to
> >an USB hardware analyzer to check whether the dropout is in fact part of
> >the USB data stream?
> >
> 
> The clicks are absolutely regular. Unfortunately, I don't have
> access to an USB hardware analyzer. Is there anything else I can do?

Unless you touched critical parts of the PCM data generating code, it is
unlikely that the dropouts are part of the USB data stream. A proper USB
dump is still very helpful, though.

Daniel
