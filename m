From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.6
Date: Thu, 2 Aug 2012 18:58:08 +0100
Message-ID: <20120802175807.GH4537@opensource.wolfsonmicro.com>
References: <20120802160212.GB4537@opensource.wolfsonmicro.com>
 <s5hwr1hqnhx.wl%tiwai@suse.de> <s5htxwlqna2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD0CC265D83
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 19:58:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htxwlqna2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 02, 2012 at 06:19:49PM +0200, Takashi Iwai wrote:

> BTW, your fix commit 98d3088e534a2a6 obsoletes the "fixes" for setting
> bogus value to codec->control_data, right?

> I see three such commits:
> d0e3cce9144eb8bff0852531aadbe221addaa2d5
> 58f598ff0bb0c030e026a0738450c6a46248f6a8
> e13ab2aac7a273a890d18bb482849610be178bc5

I remember those commit IDs well but I think you were thinking of some
others. :P I'm going to revert them for 3.7 but didn't want to rebase
them right now.
