From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: about sound/core/pcm_lib.c:1997: capture read
 error (DMA or IRQ trouble?)
Date: Wed, 26 Sep 2007 08:24:20 +0200
Message-ID: <1190787860.12924.1212641403@webmail.messagingengine.com>
References: <loom.20070926T031709-238@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 71B7F24131
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Sep 2007 08:24:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20070926T031709-238@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Akio <akioolin@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Akio write:
> after long time amr-wb codec loopback test. (above 90 hours)
> I got the following kernel message.  it comes from snd_pcm_lib_read1()
> function. 
> ALSA sound/core/pcm_lib.c:1997: capture read error (DMA or IRQ trouble?)

This error indicates that no interrupt has been received for ten
seconds.

I would have guessed that some 32-bit counter has overflowed, but at
48 kHz, a frame counter would overflow after slightly less than
25 hours.


HTH
Clemens
