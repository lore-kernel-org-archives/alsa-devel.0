From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: crash with assertion (?)
Date: Fri, 10 Sep 2010 09:06:16 +0200
Message-ID: <4C89D8E8.2080305@ladisch.de>
References: <4C8662AD.1040607@iem.at>
	<4C8670FD.5020906@ladisch.de>	<4C874C1E.8040007@iem.at>	<AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>	<4C88AC51.9030803@iem.at>
	<AANLkTi=DVhWmzSvSDQW8+_vzCCDPp+aquy8LcTEFq0xY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D10962446A
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:05:53 +0200 (CEST)
In-Reply-To: <AANLkTi=DVhWmzSvSDQW8+_vzCCDPp+aquy8LcTEFq0xY@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Yes, I can reprodued the assertion with a patched intel8x0 driver inside
> virtualbox
> since there is no error when using the emulated ac97 controller and codec
> which support 8000Hz<->48000Hz

How exactly did you patch it?

> Rule 7 (0xb7773aa0): RATE=44100 -> NONE PERIOD_SIZE=64 PERIOD_TIME=(166
> 1438)
> 
> alsatest: interval_inline.h:52: snd_interval_single: Assertion
> `!snd_interval_empty(i)' failed.

This looks like a definite bug.


Regards,
Clemens
