From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Small Regression in midi for M-Audio Fast Track
 Ultra.
Date: Mon, 18 Apr 2011 11:29:12 +0200
Message-ID: <4DAC0468.4000705@showlabor.de>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
	<4DAC0158.6090400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id B044A1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 11:29:13 +0200 (CEST)
In-Reply-To: <4DAC0158.6090400@ladisch.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens,

for your quick reply.

Am 18.04.2011 11:16, schrieb Clemens Ladisch:
>
> Try replacing the comment with:
> 			{
> 				.iface = 3,
> 				.type = QUIRK_MIDI_STANDARD_INTERFACE
> 			},
>

I already tried that yesterday. It didn't change anything.

Remember, on my 2.6.32 kernel the MIDI part of that device will be 
recognized without any quirk for the FTU. If I remove all FTU related 
patches from current alsa-driver/alsa-kernel  (over the Ubuntu 
2.6.35-28-generic kernel) the device will not be recognized as a MIDI 
interface.

Regards,

Felix
