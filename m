From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] ASoC: Add
	ADAU1701 codec driver
Date: Fri, 10 Jun 2011 13:43:05 -0400
Message-ID: <BANLkTimLAfEj+tgNMWjTsanccgfEt9UW1g@mail.gmail.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AA852103C49
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:43:26 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1921952fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 10:43:25 -0700 (PDT)
In-Reply-To: <1307726331-28618-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 13:18, Lars-Peter Clausen wrote:
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");

did you actually rewrite this thing from scratch ?  seems like you
should keep Cliff as the author in git/MODULE_AUTHOR, and then add
your name to the s-o-b list and this macro.

friendly git commits can easily be cherry picked from my tree for asoc stuff:
http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=summary
(see the "trunk" branch)
-mike
