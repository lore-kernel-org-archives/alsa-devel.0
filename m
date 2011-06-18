From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix breakage with
	incorrect codec pointer
Date: Sat, 18 Jun 2011 15:41:02 +0100
Message-ID: <20110618144102.GB15674@opensource.wolfsonmicro.com>
References: <1308322347-13512-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4DFB77AA.8060803@ti.com>
	<20110617160153.GA11241@opensource.wolfsonmicro.com>
	<20110618141046.GA4065@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CBA810381F
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jun 2011 16:41:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110618141046.GA4065@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 18, 2011 at 03:10:46PM +0100, Dimitris Papastamos wrote:

> Yes that's true.  That was a quick fix to temporarily take care of this
> problem.

With something like this I think it's probably as well to just revert
the original commit until we've got things sorted out, having the
feature sort of implemented but totally unusuble is probably worse than
not having it at all.
