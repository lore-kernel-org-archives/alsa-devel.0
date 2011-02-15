From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 15 Feb 2011 10:28:33 +0200
Message-ID: <20110215102833.0727ef53.jhnikula@gmail.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 135F9103851
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 09:28:13 +0100 (CET)
Received: by ewy19 with SMTP id 19so2542052ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 00:28:12 -0800 (PST)
In-Reply-To: <8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
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

On Mon, 14 Feb 2011 12:58:35 -0500
ylin@mail.com wrote:

> 
> > I have not experienced with channel swapping during capture..
> > It would help, if I know:
> > what is your kernel version
> > Source of the recording (digimic, HS, main mic, etc)
> 
> We are using 2.6.32.  The source of the recording is using Analog Mic.  
> The Left Main mic is always on, and Right Sub mic can be either on or 
> off when this occurs.  We are not using AUX or digimic.
> 
I was thinking is this 2.6.32 derived completely from Vanilla version or
only partially? I think I've seen some case where the kernel was forked
earlier and got upgraded to the upstream version only partially.

Even Peter told that those channel switching patches in 2.6.32 should
fix the playback case only, worth to check just in case are those fixes
in your kernel tree.

-- 
Jarkko
