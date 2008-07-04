From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix warning from strict_strtoul()
Date: Fri, 4 Jul 2008 20:57:54 +0100
Message-ID: <20080704195753.GA20719@sirena.org.uk>
References: <1215183674-13038-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h3amplm8f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 96D2724ADF
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 21:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3amplm8f.wl%tiwai@suse.de>
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

On Fri, Jul 04, 2008 at 05:09:36PM +0200, Takashi Iwai wrote:
> (BTW, at the next time, a bit more patch description would be helpful.
>  For example, in this case, it's actually not about warning but the
>  behavior of strict_strtoul() that resets the value, if I understand
>  correctly.)

It is a warning fix - I was passing the wrong type of variable to
strict_strtoul(), though on most architectures int and long are the same
in memory so the behaviour before and after the change is identical.
The fix is to pass a temporary variable of the correct type in and then
assign the result to pop_time rather than passing pop_time in directly.
