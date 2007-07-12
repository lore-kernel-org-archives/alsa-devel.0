From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Using speaker-test for sound cards which dont
 support mmap
Date: Thu, 12 Jul 2007 09:13:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0707120911080.7300@tm8103.perex-int.cz>
References: <61445c750707110940x6da830e3o48221ad6adbb7bcd@mail.gmail.com>
	<1184224136.8682.1199761053@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BF43A24360
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 09:13:41 +0200 (CEST)
In-Reply-To: <1184224136.8682.1199761053@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jul 2007, Clemens Ladisch wrote:

> >From the point of view of userspace applications, all sound cards
> support mmap.

It's not really true. Some drivers might not support mmap, but the mmap 
access can be partly "emulated" in alsa-lib using standard read/write 
mechanism.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
