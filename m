From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sun, 13 Feb 2011 11:25:01 +0200
Message-ID: <20110213112501.c23c3548.jhnikula@gmail.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id EF3C024528
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 10:25:04 +0100 (CET)
Received: by bwz10 with SMTP id 10so4641581bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 01:25:04 -0800 (PST)
In-Reply-To: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ylin@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Feb 2011 11:16:42 -0500
ylin@mail.com wrote:

> We are using a customized TI OMAP3 with TWL4030, similar to OMAP3EVM 
> board.  We noticed occasionally (after bring up few hours) the mic 
> channel  audio is swapped.  Has anyone seen similar problem? Any 
> suggestion where the problem might be?
> 
Is this with recent kernels? There were this channel swapping problem
before but it got fixed by Eero Nurkkala for the 2.6.32 kernel by
following commits:

commit 9abea08e43c6cfc18399e42cbc6028d111532f61
"OMAP: McBSP: Provide functions for ASoC frame syncronization"
and
commit ca6e2ce08679c094878d7f39a0349a7db1d13675
"ASoC: Always syncronize audio transfers on frames"

-- 
Jarkko
