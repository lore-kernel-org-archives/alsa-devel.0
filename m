From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: soc-cache: Add trace event for
 snd_soc_cache_sync()
Date: Fri, 21 Jan 2011 18:34:46 +0000
Message-ID: <20110121183446.GF22414@opensource.wolfsonmicro.com>
References: <1295623742-7988-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B62D103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:34:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295623742-7988-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 03:29:02PM +0000, Dimitris Papastamos wrote:
> This patch makes it easy to see when the syncing process begins and
> ends.  You can also enable the snd_soc_reg_write tracepoint to see
> which registers are being synced.

Applied, thanks.
