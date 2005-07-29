From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
Date: Fri, 29 Jul 2005 08:52:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507290849050.8400__15404.4387549677$1122620006$gmane$org@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>
 <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 41BFB173
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 08:52:48 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thorsten Knabe <linux@thorsten-knabe.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jul 2005, Thorsten Knabe wrote:

> On Tue, 26 Jul 2005, Adrian Bunk wrote:
> 
> > This patch schedules obsolete OSS drivers (with ALSA drivers that
> > support the same hardware) for removal.
> 
> Hello Adrian.
> 
> I'm the maintainer of the OSS AD1816 sound driver. I'm aware of two 
> problems of the ALSA AD1816 driver, that do not show up with the OSS 
> driver:
> - According to my own experience and user reports audio is choppy with 
>   some VoIP Softphones like gnophone at least when used with the ALSA 
>   OSS emulation layer, whereas the OSS driver is crystal clear.
> - Users reported, that on some HP Kayak systems the on-board AD1816A was 
>   not properly detected by the ALSA driver or was detected, but there 
>   was no audio output. I'm not sure if the problem is still present in 
>   the current ALSA driver, as I do not own such a system.
> 
> Maybe the OSS driver should stay in the kernel, until those problems are 
> fixed in the ALSA driver.

The problem is that nobody reported us mentioned problems. We have no 
bug-report regarding the AD1816A driver. Perhaps, it would be a good idea 
to add a notice to the help file and/or driver that the ALSA driver should 
be tested and bugs reported to the ALSA bug-tracking-system.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
