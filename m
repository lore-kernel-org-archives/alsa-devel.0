From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usage of snd_seq_set_client_event_filter
Date: Tue, 10 Jul 2012 22:04:19 +0200
Message-ID: <4FFC8AC3.6020902@ladisch.de>
References: <CAB+dmjiXDs7u20T8HJJZAv47o-61kZStL2+=ZX5zLjBsH7VPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 16342244F1
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 22:05:00 +0200 (CEST)
In-Reply-To: <CAB+dmjiXDs7u20T8HJJZAv47o-61kZStL2+=ZX5zLjBsH7VPdQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kaspar Bumke <kaspar.bumke@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kaspar Bumke wrote:
> I was trying to use snd_seq_set_client_event_filter in my application but I
> can't seem to get it to work correctly.
>
> I have attached a small test program which can be compiled with "g++ -o
> test test.cpp -lasound".  My alsa-lib is at 1.0.25. It should simple print
> the note number for any noteOn events.
>
> I was under the impression that the way I have used it only noteOn events
> would get through but it seems that only the first noteOn event I send it
> gets through. I have been sending events using VMPK.

Any filtered-out events gets rejected with an error, which gets reported
back to the sending application.  If that application does nothing to
handle the error, all further attempts to send events will get the same
error because the event being rejected is still in the output buffer.

This behaviour makes event filters pretty much useless.
Just ignore any events you don't want.


Regards,
Clemens
