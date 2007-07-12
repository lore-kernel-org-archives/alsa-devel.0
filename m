From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Using speaker-test for sound cards which dont
 support mmap
Date: Thu, 12 Jul 2007 09:08:56 +0200
Message-ID: <1184224136.8682.1199761053@webmail.messagingengine.com>
References: <61445c750707110940x6da830e3o48221ad6adbb7bcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4693424360
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 09:08:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750707110940x6da830e3o48221ad6adbb7bcd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> Is it possible to use speaker-test for sound cards which do not support
> mmap?

If a sound card does not support DMA, the driver has to copy the samples
from ALSA's buffer to the hardware with some other mechanism.  However,
there is always the ALSA buffer that can be mmap()ed to userspace.

>From the point of view of userspace applications, all sound cards
support mmap.


Regards,
Clemens
