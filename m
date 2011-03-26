From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: soc-cache: Ignore
 !codec->writable_register() during syncing
Date: Sat, 26 Mar 2011 17:29:41 +0000
Message-ID: <20110326172941.GA3535@opensource.wolfsonmicro.com>
References: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1300974319-14423-3-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D57210381E
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 18:29:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300974319-14423-3-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 24, 2011 at 01:45:19PM +0000, Dimitris Papastamos wrote:
> When syncing the cache, if the driver has given us a writable_register()
> callback, use it to not sync any non-writable registers.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Thinking about this again I'm actually thinking we should really be
warning if we ever find a need to sync a non-writable register - given
that we suppress writes of the default value this'd mean that we'd have
had to have written to the register at some point in the past which
means that something messed up somewhere.
