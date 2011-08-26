From: Cyril Hrubis <metan.lists@gmail.com>
Subject: Re: TASCAM US-122mkII
Date: Fri, 26 Aug 2011 18:24:36 +0200
Message-ID: <20110826162436.GA21385@yumi>
References: <20110819100156.GA31665@yumi>
	<CACTFLANmONgmCtPKFpofJGQ72a5BSbZHkj5+e=yGfDrynDPrQA@mail.gmail.com>
	<20110819113727.GA9522@yumi>
	<CACTFLAPnWpq7AQ3KZakqkLRV7CtgDG-fXM77T9NLK5o90hfxzA@mail.gmail.com>
	<1313759213.3673.40.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0430410384F
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 18:24:36 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2766005fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 09:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313759213.3673.40.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!
But still there are some good news. I've examined the pcb a bit and the
USB interface is ISP1583 connected to the ATmega162 which is driving DA
converters. So at least there is a documentation for the USB chip.  And
there seems to be ISP header for ATmega programming. And the ATmega code
may be ripped of their firmware update binaries. Looks like I'll have
some fun.

-- 
Cyril Hrubis
