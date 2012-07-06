From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: then there was "overrun" occue every time once
 trigger the audio recording
Date: Fri, 06 Jul 2012 09:17:29 +0200
Message-ID: <4FF69109.4060705@ladisch.de>
References: <DBBC59900F0EF340B9938F193FB1A3453625BABA@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D9CA6243B1
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 09:17:31 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7767D2101C
	for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2012 03:17:30 -0400 (EDT)
Received: from [10.1.2.65] (unknown [94.101.37.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 184B38E01F7
	for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2012 03:17:29 -0400 (EDT)
In-Reply-To: <DBBC59900F0EF340B9938F193FB1A3453625BABA@SC-VEXCH4.marvell.com>
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
List-Id: alsa-devel@alsa-project.org

(please configure your mailer to wrap lines)

Zhen Fu wrote:
> When I use arecord command, then there was "overrun" occue every time
> once trigger the audio recording.  I have no clue of alsa driver when
> and how handler xrun. In other words, how to understand function
> snd_pcm_update_hw_ptr0 in pcm_lib.c.

It behaves pretty much the same for playback and capture, so I refer
the honourable gentleman to the reply I gave some moments ago.

If you want a more specific answer, it might be a good idea not to
keep the hardware and your driver source code a secret.


Regards,
Clemens
