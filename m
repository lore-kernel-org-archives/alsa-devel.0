From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [pulseaudio-discuss] pulseaudio eats 19% CPU power
 in Fedora 12
Date: Mon, 19 Apr 2010 16:48:34 +0200
Message-ID: <20100419144832.GC1048@tango.0pointer.de>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
	<4BCBE81F.6090606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D2F12475D
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 16:49:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BCBE81F.6090606@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Cc: "Fu, Michael" <michael.fu@intel.com>, alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, "Bu, Long" <long.bu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 19.04.10 13:20, Shuang He (shuang.he@intel.com) wrote:

Please stop the cross-posting.
> 

>         current latency: 444.25 ms
>         requested latency: 31.25 ms

So, this is interesting: the client requested 30ms (which is needlessly
low, but that's another question), but the server ended up providing
only 444 ms! That is incredibly high and points to the fact that PA
probably ran into quite a few dropouts before this, presumably due to
incorrect timing or suchlike, and hence bumped up the minimal latency
all the time, and bumped down the sleeping time, hence eincreasing the
CPU load. Almost certainly your audio driver is at fault here.

Check syslog for any comments about that.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
