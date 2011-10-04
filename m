From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Avoid writing to WM8971_RESET
	in wm8971_resume
Date: Tue, 4 Oct 2011 16:04:04 +0100
Message-ID: <20111004150403.GI6934@opensource.wolfsonmicro.com>
References: <1317685462.3640.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FD50103856
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:05:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317685462.3640.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Kenneth Kiraly <kiraly@lab126.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 07:44:22AM +0800, Axel Lin wrote:

> While reading the code, I don't understand why we need to do (in wm8971_resume):
> 
> for (i = 0; i < ARRAY_SIZE(wm8971_reg); i++) {
>         if (i + 1 == WM8971_RESET)
>                 continue;
> 
> My understanding is that we want to avoid writing to WM8971_RESET on resume.

Yeah, this looks like a leftover from some older code which omitted
register zero from the cache for some small memory savings.  Now things
are using the standard cache code rather than custom cache code this
is buggy.

Applied, thanks.
