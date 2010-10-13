From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Wed, 13 Oct 2010 09:47:13 +0200
Message-ID: <4CB56401.60508@showlabor.de>
References: <4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>	<4CAC89EA.8080207@ladisch.de>
	<4CACA471.2000504@showlabor.de>	<4CAD6AA2.4050205@ladisch.de>	<20101007081010.GZ7159@buzzloop.caiaq.de>	<4CADB077.3060907@showlabor.de>
	<4CAEB9AC.1060208@ladisch.de>	<20101012071831.GA7159@buzzloop.caiaq.de>	<4CB419D0.70808@showlabor.de>
	<20101012102600.GB7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id D18252444C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 09:47:17 +0200 (CEST)
In-Reply-To: <20101012102600.GB7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Am 12.10.2010 12:26, schrieb Daniel Mack:
>
> Thanks for testing!
>
>    

Thanks for *your* help on *my* problem!!!



>
> I attached a patch below, only compile-tested. Please also check the USB
> ID again, as I'm not sure whether you sent the right lsusb dump (the
> device name looks suspicious).
>    

Yes, it's been the right lsusb dump. The reported device name is a bit 
strange indeed. In /proc/asound it is listed as F8R which is is a bit 
more reasonable.


> If that doesn't work, try debugging the value returned by
> urb.c:snd_usb_audio_next_packet_size(). For your device, you should end
> up in the "subs->stream->implicit_feedback" branch.
>
>    

I've tested your patch. Unfortunately I don't get any sound. 
snd_usb_audio_next_packet_size() returns from the 
"subs->stream->implicit_feedback" branch. But the return value is always 
0. ('frames' is returned, not the  0 from the if (WARN_ONCE...) statement).

Any ideas how to proceed?

Thank you very much again,

Felix
