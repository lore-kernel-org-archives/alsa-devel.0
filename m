From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 3/8] mfd: arizona: Add support for
	WM8998 and WM1814
Date: Mon, 04 May 2015 12:44:14 +0200
Message-ID: <1430736254.23580.2.camel@tiscali.nl>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-4-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430560731.2187.70.camel@x220>
 <20150504091119.GA32076@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net
 [194.109.24.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C1F82604B8
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 12:44:18 +0200 (CEST)
In-Reply-To: <20150504091119.GA32076@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, myungjoo.ham@samsung.com, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Richard Fitzgerald schreef op ma 04-05-2015 om 10:11 [+0100]:
> Yes, I've noticed that these tests are wrong and I'm working on a patch for
> it.

Glad to hear I wasn't misreading that Makefile.

> It's another one of those cases where more lines needs patching to fix
> it than the 3 lines this WM8998 patch adds, and also fixing it potentially
> breaks the build because of dependencies that were accidentally working
> because they never got compiled out. So I'd prefer not to half-fix it in
> these WM8998 patches it's better to let the code settle and then fix it properly.

I see. Unless that fix takes very long to land, I won't be bothering you
about this again.

Thanks,


Paul Bolle
