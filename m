From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei BLOCKED
Date: Tue, 26 Apr 2011 09:54:23 +0200
Message-ID: <4DB67A2F.10008@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5709@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E14261037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 09:52:54 +0200 (CEST)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5709@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I have created two threads
> 
> 1)Thread 1 :  reads audio data from USB audio class hw:1,0   (Capture device : open in BLOCKING Mode )
> 2)Thread2 : writes audio data to playback device hw:0,0         (Playback device : open in BLOCKING Mode )
> 
> First snd_pcm_writei() is succesfull in Thread 2
> Thread2 gets stuck/blocked in second snd_pcm_writei() and does not returns.

Is the second device in the running state?

> SASKEN BUSINESS DISCLAIMER: This message may contain ...

*** DISCLAIMER ***
This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any disclaimers in those e-mails.
Additionally, disclaimers in those e-mails will incur legal processing
fees of $42 per line; you have agreed to this by reading this disclaimer.


Regards,
Clemens
