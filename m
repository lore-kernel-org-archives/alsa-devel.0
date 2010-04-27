From: Keith Chew <keith.chew@gmail.com>
Subject: Re: PCM multi A/V Sync bug on SMP system
Date: Wed, 28 Apr 2010 07:28:59 +1200
Message-ID: <m2z20f65d531004271228gc2ab0716na68845e9b262a839@mail.gmail.com>
References: <n2i20f65d531004242207zde83c421gac35d243420dcaff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E7510383E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 21:29:01 +0200 (CEST)
Received: by iwn27 with SMTP id 27so6694995iwn.5
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 12:29:00 -0700 (PDT)
In-Reply-To: <n2i20f65d531004242207zde83c421gac35d243420dcaff@mail.gmail.com>
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

>
> Please advise how can I track down this problem in code, happy to make
> changes and test.
>

After further investigation on the soucecode, it appears that the
default surround51 for the driver ca0106, uses "multi" to the 3
devices/outputs on the card. So "multi" does work fine on an SMP
system. The timing problems are only introduced when "multi" is
combined with "dmix" for 5.1 channels.

I would like to help out in fixing this, but need a little bit of
guidance from the experts here. Have I identified the problem
correctly? Ie interaction between "multi" and "dmix" on a 5.1 channel
card giving timing issues on an SMP system? If it is unlikely, I will
investigate other areas.

Regards
Keith
