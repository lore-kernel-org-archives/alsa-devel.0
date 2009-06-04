From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Thu, 4 Jun 2009 04:55:53 -0400
Message-ID: <8bd0f97a0906040155g21386acdtc41b9945de276fbb@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<4A2782FE.3080103@gmail.com>
	<8bd0f97a0906040122r2e4ca8feo69e6afb06140cef3@mail.gmail.com>
	<4A278889.7060107@gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04257C91@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f206.google.com (mail-gx0-f206.google.com
	[209.85.217.206])
	by alsa0.perex.cz (Postfix) with ESMTP id B34681037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:55:54 +0200 (CEST)
Received: by gxk2 with SMTP id 2so1043893gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 01:55:53 -0700 (PDT)
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04257C91@chinexm1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 4, 2009 at 04:50, Cai, Cliff wrote:
> Could you point it out,I don't know much about the changes of alsa in
> recent months.

he is talking about this commit:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=faab5a32f4d0784d6bde57963267be0453be3546

which presumably makes the second change of your patch obsolete.
which leaves the first change and i think Mark is still awaiting an
explanation for it as it appears to be unrelated to the latter change.
-mike
