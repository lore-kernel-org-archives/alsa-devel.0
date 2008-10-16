From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Remove
	snd_soc_dapm_connect_input()
Date: Thu, 16 Oct 2008 13:12:45 +0100
Message-ID: <20081016121244.GB5753@rakim.wolfsonmicro.main>
References: <1224151207-5496-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1224151207-5496-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hmyh43kpi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 839C210381A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 14:13:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmyh43kpi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2008 at 12:20:25PM +0200, Takashi Iwai wrote:

> My stand-point is that we should have removed it *before* the merge
> window if we must remove.  If not, let's postpone.

> Either removing or not, this can't be a big issue.
> But, I simply don't like the API change now.

I saw.  I wasn't expecting you to submit these to Linus but since I saw
that you were queuing things for 2.6.29 already and thought that it was
as well to send the changes now while I remembered.
