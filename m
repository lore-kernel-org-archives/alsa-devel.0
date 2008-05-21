From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Moving sound/* to drivers/ ?
Date: Wed, 21 May 2008 23:54:03 +0200
Message-ID: <20080521215403.GD15136@uranus.ravnborg.org>
References: <s5hzlqjz74d.wl%tiwai@suse.de>
	<alpine.LFD.1.10.0805211431370.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 469D324581
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 23:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805211431370.3081@woody.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> 
> Me personally, I've been more irritated by include/asm-xyz vs arch/xyz. It 
> would be so nice if all the arch-specific changes woudl always show up 
> under arch/ (both from a statistics standpoint, and just because then a 
> diffstat really shows arch-specific stuff really obviously, and sorts all 
> the arch-specific stuff together).

Something like:
include/asm-$ARCH/ => arch/$ARCH/include/asm/*
?

I can cook up something simple so kbuild will try both so we can
move the archs that do symlinks later than the rest.

I really like to keep the 'asm' directory so we can kill the asm symlink.

	Sam
