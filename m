From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: can't use dmixer
Date: Wed, 05 Dec 2007 09:30:58 +0100
Message-ID: <1196843458.10919.1224896537@webmail.messagingengine.com>
References: <18616081.324771196835836994.JavaMail.coremail@bj126app88.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 34E76244F9
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 09:31:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18616081.324771196835836994.JavaMail.coremail@bj126app88.126.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: feng_tian <feng_tian@126.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

feng_tian wrote:
> I have a problem with dmix of alsa. 
> I'm using alsa v1.0.11rc2 now.

It would be a good idea to update at least alsa-lib.

> And make it running on ATMEL AT91SAM9260EK board.

Which driver?

> ALSA lib pcm_direct.c:790:(snd_pcm_direct_initialize_slave) slave plugin does not support mmap interleaved or mmap noninterleaved access

Apparently, your driver, whichever one it is, does not support access
to its memory buffer.  This would be required for dmix to work.

The current ARM drivers in the ALSA tree seem to support mmap, so I
guess your driver needs to be extended to support it, too.


Regards,
Clemens
