From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Mbox II DigiDisign
Date: Fri, 23 Nov 2007 15:03:55 +0100
Message-ID: <1195826635.20484.1222880525@webmail.messagingengine.com>
References: <20071122101505.50AAE1AB2E8@smtp1-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3B6BF2467A
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 15:03:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071122101505.50AAE1AB2E8@smtp1-g19.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rmgls@free.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

rmgls@free.fr wrote:
> on jeudi 22 novembre 2007 Clemens Ladisch" <cladisch@fastmail.net wrote:
> >> aplay plays nothing and reports: (alsa-lib pcm error).
> 
> > What exactly does it report?
> 
> it reports
> 
> segfault!

Does this also happen when you run "aplay -D plughw coq.wav"?

> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xb7cfb6b0 (LWP 21167)]
> 0xb7f0389c in ?? () from /usr/lib/libasound.so.2
> (gdb) bt
> #0  0xb7f0389c in ?? () from /usr/lib/libasound.so.2
> #1  0x00038007 in ?? ()
> ...
> 
> if needed i'll build a non stripped aplay.

That would be helpful.


Regards,
Clemens
