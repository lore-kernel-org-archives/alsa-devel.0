From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC updates for 2.6.28
Date: Thu, 30 Oct 2008 13:20:08 +0000
Message-ID: <20081030132007.GA8304@rakim.wolfsonmicro.main>
References: <20081030123649.GA7682@rakim.wolfsonmicro.main>
	<s5htzauz0kh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F26102440B
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 14:20:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htzauz0kh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 02:15:10PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > These patches contain a few updates for 2.6.28.  The fix for mono
> > controls is very important, the other two changes less so.

> Are they also for stable (2.6.27 or earlier) kernels?
> If so, you can put 'Cc: stable@kernel.org', so that stable kernel guys
> will take it automatically when merged to the upstream.

No, the only one that affects anything before 2.6.28 is the WM9713 one.
