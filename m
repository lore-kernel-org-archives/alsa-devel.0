From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] Report errors from
	snd_soc_dapm_set_endpoint()
Date: Tue, 26 Feb 2008 14:26:05 +0000
Message-ID: <20080226142604.GA8321@rakim.wolfsonmicro.main>
References: <1204026175-13316-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hpruju854.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4710824357
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 15:26:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hpruju854.wl%tiwai@suse.de>
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

On Tue, Feb 26, 2008 at 03:03:51PM +0100, Takashi Iwai wrote:

> Applied to HG tree.  Thanks.
> Other two patches were alredy on HG tree.
> Should these be pushed to 2.6.25?

At least

   ASoC: Fix TLV320AIC3X PLL divider table for 64 kHz rate

ought to go upstream since it's a bug fix.  The other two should be safe
and worthwhile but it depends on your approach to -rc.
