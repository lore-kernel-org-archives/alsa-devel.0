From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Thu, 03 May 2012 17:21:52 +0200
Message-ID: <4FA2A290.6010301@ladisch.de>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
	<CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
	<4FA2927C.1010501@ladisch.de>
	<CAFz=ag7fvr5+Pz0jePNZ+7xhXZ7n1Td4v3=ZZFQcb6Sqy+RQXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D5D5B10448A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 17:17:45 +0200 (CEST)
In-Reply-To: <CAFz=ag7fvr5+Pz0jePNZ+7xhXZ7n1Td4v3=ZZFQcb6Sqy+RQXw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> 2012/5/3 Clemens Ladisch <clemens@ladisch.de>:
>> USB playback also adds further latency by queueing the packets; the
>> number of packets can be seen under "URBs" in /proc/asound/card?/stream0.
>> (There are 1000/8000 packets per second at full/high speed.)
>
> I'm getting "URBs = 2 [ 5 6 ]"  for playback and  "URBs = 8 [ 8 8 8 8
> 8 8 8 8 ]" for capture with the "old" streaming logic. What does it
> mean?

The queue length is 5+6 = 11 packets; at high speed, that's
11 / 8 kHz = 1.4 ms.


Regards,
Clemens
