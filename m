From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 19:07:43 +0800
Message-ID: <20130614110742.GD9206@MrMyself>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
 <20130614095917.GG1403@sirena.org.uk>
 <20130614100838.GC9206@MrMyself>
 <20130614105118.GI1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A03261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:13:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130614105118.GI1403@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2013 at 11:51:18AM +0100, Mark Brown wrote:
> Don't just quote commit IDs, use the subject lines as well so humans can
> read your e-mails.  The commit you're referring to moves some code out
> of set_bias_level() into runtime PM.

I'm sorry, I'll obey the rule from now on.

> So, if that's the case why are you changing this...  it may be that what
> you need to do is to write a better commit message so it's clear why
> you're making the change, your message just described what the code
> change does but not why it's being done in that way.

You're right. I'll revise it.

> That said the general concept is that runtime PM would be powering on
> the device for digital operation (eg, for the GPIOs) and then
> set_bias_level() powering up the analogue portions of the device.

Understood. But I just tested the set_bias_level() way to handle BIAS,
it prompts "wm8962 0-001a: DC servo timed out" when I start to play a
wav file. There should be still some parts of code not right.
So I'm gonna just revise the comment to continue the resume() methods.
It should be appropriate since pm_suspend() is handling bias-off in
the current code.

If you still can't accept it, I will then trace the code next week.
It's Friday night here, and I'm starving now :(

Thank you,
Nicolin Chen
