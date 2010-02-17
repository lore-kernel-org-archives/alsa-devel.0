From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 17 Feb 2010 16:35:15 +0100
Message-ID: <20100217153515.GB6891@tango.0pointer.de>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B0F4103892
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 16:35:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 09.02.10 06:59, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> why do PA insist to use one period per buffer when only those ISA drivers
> and intel8x0 have periods_min =1 , the most common HDA driver and most sound
> cards have periods_min =2 ?

PA actually doesn't insist. We just try to minimize wakeups and hence
pick the lowest value we can get. Which means 2 frags on most devices
and 1 on very few others.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
