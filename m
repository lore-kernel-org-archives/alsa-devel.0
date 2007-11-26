From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 08:49:35 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
References: <474A763E.7090001@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA182476C
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 08:49:36 +0100 (CET)
In-Reply-To: <474A763E.7090001@cs.helsinki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki Lindholm <holindho@cs.helsinki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Heikki Lindholm wrote:

> Hello,
> 
> Some years ago there was some talk about UST support in Linux, but the 
> support never happened. With the hrtimers patch (and I'm not quite sure 
> if even earlier?) CLOCK_MONOTONIC would seem like a fairly good UST time 
> source. What I'd like to see, is a selectable clock for ALSA 
> timestamping, e.g. something like snd_sw_params_clock(..., clockid_t 
> clk). Would this seem plausible? I don't know that much about ALSA 
> internals, so, no idea whether different clocks on different 
> pcms/whatever would quickly turn into an unmanageable mess.

We are aware about this extension and I already proposed an 
implementation. I hope to implement it soon. Timestamps are not used in 
driver internally.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
