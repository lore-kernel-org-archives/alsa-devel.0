From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Thu, 17 Feb 2011 10:17:23 +0200
Message-ID: <20110217101723.b272f4e4.jhnikula@gmail.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
	<20110215102833.0727ef53.jhnikula@gmail.com>
	<8CD9B447BF02D2F-DE8-B4B6@web-mmc-d01.sysops.aol.com>
	<8CD9C6D5C822217-13C8-4CCF@web-mmc-d06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 986D010388B
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 09:16:52 +0100 (CET)
Received: by eyg24 with SMTP id 24so1160063eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 00:16:52 -0800 (PST)
In-Reply-To: <8CD9C6D5C822217-13C8-4CCF@web-mmc-d06.sysops.aol.com>
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

On Wed, 16 Feb 2011 22:53:25 -0500
ylin@mail.com wrote:

> > > Even Peter told that those channel switching patches in 2.6.32 
> should
> > > fix the playback case only, worth to check just in case are those
> > fixes
> > > in your kernel tree.
> >
> > Those fixes are not in our kernel, I will apply them and re-test.
> 
> We applied those 2 patches, but still have channel swapping issue from 
> capture audio.
> 
Thanks, this is very good information and seems to indicate the same
problem must be in upstream also as I don't recall that there were any
other swapping related fixes than those that fix the playback case.

-- 
Jarkko
