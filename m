From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sun, 13 Feb 2011 12:20:39 +0200
Message-ID: <20110213122039.96935351.jhnikula@gmail.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
	<20110213112501.c23c3548.jhnikula@gmail.com>
	<CF32F28EDF8D20468EEDCBE4975DA0274A46C9@008-AM1MPN1-027.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 463BE245A3
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 11:20:42 +0100 (CET)
Received: by bwz10 with SMTP id 10so4664198bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 02:20:41 -0800 (PST)
In-Reply-To: <CF32F28EDF8D20468EEDCBE4975DA0274A46C9@008-AM1MPN1-027.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, ylin@mail.com
List-Id: alsa-devel@alsa-project.org

On Sun, 13 Feb 2011 09:48:00 +0000
<peter.ujfalusi@nokia.com> wrote:

> > > We are using a customized TI OMAP3 with TWL4030, similar to OMAP3EVM
> > > board.  We noticed occasionally (after bring up few hours) the mic
> > > channel  audio is swapped.  Has anyone seen similar problem? Any
> > > suggestion where the problem might be?
> > >
> > Is this with recent kernels? There were this channel swapping problem
> > before but it got fixed by Eero Nurkkala for the 2.6.32 kernel by
> > following commits:
> 
> This is something different.
> The channel swapping/shifting issue was affecting the playback
> stream only.
> 
Hmm.. could be. Also IRCC before the swapping was quite frequent.
Especially during the stream startup time but I think also sometimes
while playback was running? This is infrequent but happens anyway.

-- 
Jarkko
