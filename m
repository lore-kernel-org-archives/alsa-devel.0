From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [LAD] How to get correct midi timings from ALSA
 using the library only
Date: Wed, 25 Jul 2007 10:24:58 +0200
Message-ID: <1185351898.28416.1201921883@webmail.messagingengine.com>
References: <46A5BFDF.4040906@gmail.com>
	<1185272655.7458.1201738081@webmail.messagingengine.com>
	<46A69F4D.7050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B816F1038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 10:24:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A69F4D.7050002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Carlo Florendo <subscribermail@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Carlo Florendo wrote:
> Clemens Ladisch wrote:
> >> However, I wish to be able to make the sequencer or player work without the 
> >> use of the ALSA queue nor the workaround in (2).
> > 
> > Why?
> 
> Because the queue output and draining, AFAICS, is implemented in a blocking 
> manner.

When non-blocking mode is set (see snd_seq_nonblock()),
snd_seq_drain_output() does not block but writes only as many events to
the kernel buffer as fit inside (or returns -EAGAIN if the kernel buffer
is completely full).


Regards,
Clemens
