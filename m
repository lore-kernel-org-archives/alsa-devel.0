From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
	3/3: adding directories)
Date: Fri, 26 Sep 2008 09:09:12 -0500
Message-ID: <200809260909.12794.geoffrey@pager.net>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.30])
	by alsa0.perex.cz (Postfix) with SMTP id 0B5192414F
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:10:42 +0200 (CEST)
Received: from mail.pager.net (lrs-ad1.longragesystems.local [192.168.1.254])
	by barracuda.pager.net (Spam Firewall) with ESMTP id 4569A10608F
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 09:10:18 -0500 (CDT)
Received: from mail.pager.net (lrs-ad1.longragesystems.local [192.168.1.254])
	by barracuda.pager.net with ESMTP id FP2fhYuLet9Artje for
	<alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 09:10:18 -0500 (CDT)
In-Reply-To: <20080926125035.GB15493@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Friday 26 September 2008 07:50:36 am Mark Brown wrote:
> On Fri, Sep 26, 2008 at 11:24:10AM +0200, Sedji Gaouaou wrote:
> > This last patch contains the board specific files.
> > I have not changed playpaq_wm8510.c, and I did few changes on
> > eti_b1_wm8731.c.

> It'd also be good to see acks from Frank and Geoffrey since I can't test
> any of this.

I can't test this out right away, as I'm not working on the AVR32 project 
right now.  I'll try to give it a whirl next week.

> Thanks for doing this work - it looks good, unifying the support for the
> AT91 and AVR32 platforms is a substantial win and it's good to see Atmel
> contributing this support.

Thanks from me, as well.

---
Geoffrey
