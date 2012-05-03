From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Thu, 03 May 2012 16:13:16 +0200
Message-ID: <4FA2927C.1010501@ladisch.de>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
	<CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 4DCA6104472
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 16:09:11 +0200 (CEST)
In-Reply-To: <CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
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
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> I've even done some measurements using jack_iodelay. At 96 kHz I get a
> total round trip latency of 17.5 ms. According to the jack_iodelay
> manpage this corresponds (if I get it right) to an hardware
> input/output latency of the device of ~584 frames (6.1 ms).

USB playback also adds further latency by queueing the packets; the
number of packets can be seen under "URBs" in /proc/asound/card?/stream0.
(There are 1000/8000 packets per second at full/high speed.)


Regards,
Clemens
