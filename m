From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/14] ASoC: Update Poodle to current ASoC
	API
Date: Tue, 29 Jul 2008 14:47:13 +0100
Message-ID: <20080729134713.GA32229@rakim.wolfsonmicro.main>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h7ib4dd6v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDB531038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 15:47:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7ib4dd6v.wl%tiwai@suse.de>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 29, 2008 at 03:36:56PM +0200, Takashi Iwai wrote:

> All others are for the next kernel, right?

Actually, "Export dapm_reg_event() fully" should probably be pushed in
too but it's not so urgent.

There's no urgent reason to hold the drivers out of mainline but that'd
bypass -next.

The core changes should definitely wait for next.
