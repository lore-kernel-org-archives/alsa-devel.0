From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio dying on jackd xruns
Date: Wed, 02 Feb 2011 18:33:04 +0100
Message-ID: <4D499550.2070508@ladisch.de>
References: <AANLkTinc02yXS=axf5wCQMq3e+nhiJj_ZaHmjk-bcorS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 33A8A2474D
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 18:32:57 +0100 (CET)
In-Reply-To: <AANLkTinc02yXS=axf5wCQMq3e+nhiJj_ZaHmjk-bcorS@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rods Bobavich <rodnisms@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rods Bobavich wrote:
> So I start jackd and it runs fine for a while. Then ALSA crashes and
> triggers an xrun. Jackd continues to do its merry thing - minus the part
> about spitting info out to my soundcard...
> 
> At first I thought this was a Jackd issue but when I looked deeper it seems
> to be ALSA. Once this happens I cannot restart jackd and resume an audio
> session. In fact, I cannot even rmmod snd-usb-audio. Sometimes I cannot
> lsusb. So it looks like something is getting seriously hosed!

Looks like a bug in the USB controller driver, probably triggered by some
unexpected behaviour of your USB controller.

When this happens, are there any error messages in the system log?


Regards,
Clemens
