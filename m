From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Sun, 03 Oct 2010 13:50:50 +0200
Message-ID: <4CA86E1A.30405@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de> <4CA5BF35.2030108@showlabor.de>
	<4CA60C5B.6010809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 852DB103849
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 13:50:53 +0200 (CEST)
In-Reply-To: <4CA60C5B.6010809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Dear Clemens, dear Daniel,

thanks for your feedback!

Am 01.10.2010 18:29, schrieb Clemens Ladisch:
>
> Add an else to the inner if in retire_playback_sync_urb, and log the
> value of f.
>
> The value received in this function should be the desired sample
> frequency, relative to the USB frame rate.  There are different formats
> (therefore we have three functions); maybe the FTU uses a fourth one.
>
>    

Trying to log the value of f reveals that retire_playback_sync_urb() 
doesn't seem to be called at all. What does that mean?

Am 03.10.2010 12:02, schrieb Daniel Mack:
> How is this device clocked? It could be the PLL can't get a valid link
> to its clock source and hence "jumps" once in awhile to compensate the
> drift. Is there any possibility to sync the device to some sort o
> digital input?
>    

The device should be clocked internally. But it has an option to be 
clocked externally at least in Windows. I don't know how this is handled 
in Alsa's USB audio driver. (Could you please tell me?)
Some time ago I logged (via usbmon) the USB packets switching the device 
on in Windows. Could these logs be useful?
Either way, I'll try to connect it to another SPDIF device and look for 
differences.

> If the clicks you hear are very regular, it could also be that some
> kind of buffer boundary is not handled properly. Do you have access to
> an USB hardware analyzer to check whether the dropout is in fact part of
> the USB data stream?
>
>    

The clicks are absolutely regular. Unfortunately, I don't have access to 
an USB hardware analyzer. Is there anything else I can do?

Kind regards,

Felix
