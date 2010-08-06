From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK,
 LRCLK rates setting
Date: Fri, 6 Aug 2010 12:17:51 +0100
Message-ID: <20100806111750.GE398@rakim.wolfsonmicro.main>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054999-18243-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim2g4=j0TdYZb7QCbyZVJvhxMsCFa4yFokJCu1W@mail.gmail.com>
	<AANLkTikQ2Mb=7mKghxJep-h4m2Myi3kF1ugKQHrjf1_y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4351310399E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 13:17:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikQ2Mb=7mKghxJep-h4m2Myi3kF1ugKQHrjf1_y@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 06, 2010 at 03:02:49PM +0900, Seungwhan Youn wrote:

> I see, if Mark's opinion is same as before, I think I can try to make
> another patch for it. :)

I will look at this myself, the major blocker on doing so had been that
for many kernel releases it was not possible to use the IISv4 interface
since the support for the IISv4 main clock didn't get merged so every
time I spent any time on this it was all consumed implementing that and
resubmitting changes for that.  That appears to be sorted in at least
2.6.34 so I can now run tests much more easily.
