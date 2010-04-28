From: Keith Chew <keith.chew@gmail.com>
Subject: Re: PCM multi A/V Sync bug on SMP system
Date: Thu, 29 Apr 2010 08:12:33 +1200
Message-ID: <y2l20f65d531004281312ja49b333eha47fd0cb9c5b0e01@mail.gmail.com>
References: <n2i20f65d531004242207zde83c421gac35d243420dcaff@mail.gmail.com>
	<m2z20f65d531004271228gc2ab0716na68845e9b262a839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 93E3224559
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 22:12:35 +0200 (CEST)
Received: by ywh6 with SMTP id 6so7746918ywh.16
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 13:12:34 -0700 (PDT)
In-Reply-To: <m2z20f65d531004271228gc2ab0716na68845e9b262a839@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I would like to help out in fixing this, but need a little bit of
> guidance from the experts here. Have I identified the problem
> correctly? Ie interaction between "multi" and "dmix" on a 5.1 channel
> card giving timing issues on an SMP system? If it is unlikely, I will
> investigate other areas.

Ok, I don't seem to be getting much help from this mailing list, so I
have dug deeper into the code, and found the problem. In
pcm_dmix_i386.c, we have:

				if (!strncmp(line, "processor", 9))
					smp++;

I have commented out the smp++, so that it thinks that I am on a uni
processor. Voila, so AV sync issues!

My question now is what are the implications of this change? Looking
at pcm_dmix_i386.h, it uses locks on an SMP system, but exclude them
if not SMP. Do we still need this lock, even if I am on a dual core,
ie 1 processor 2 cores?

I have CC'ed the author of the file, Jaroslav Kysela.

Regards
Keith
