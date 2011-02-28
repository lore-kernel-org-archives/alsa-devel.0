From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem when using silence 'trick'
Date: Mon, 28 Feb 2011 09:34:14 +0100
Message-ID: <4D6B5E06.3040906@ladisch.de>
References: <4D6612A0.9000106@ischo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9BFC51037EE
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 09:33:05 +0100 (CET)
In-Reply-To: <4D6612A0.9000106@ischo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Ischo <bryan@ischo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bryan Ischo wrote:
> [...] when I use the "default" device with my silence
> technique, I have no problem playing multiple audio streams
> simultaneously by opening the "default" device multiple times and
> simultaneously playing streams into the different devices.  BUT,
> whenever I cannot deliver audio fast enough to a stream, and the silence
> trick takes over and the stream plays some silence - boom, the device
> goes silent forever.

I tried to reproduce this with mplayer (which uses the same technique),
but couldn't.

Have a look at mplayer's ALSA output driver here:
<http://git.ffmpeg.org/?p=mplayer;a=blob;hb=master;f=libao2/ao_alsa.c>
It regularly calls get_delay() before writing samples, and there uses
snd_pcm_forward() to catch up if an underrun has occurred.

> My apologies for sending this to the wrong mailing list.  When I read
> that alsa-devel was for "work on ... an ALSA application", I assumed
> that this was any application; but now I realize that it is probably for
> official ALSA tools, not general third party applications that are not
> associated with the ALSA project.

This list is correct for questions about the ALSA API.


Regards,
Clemens
