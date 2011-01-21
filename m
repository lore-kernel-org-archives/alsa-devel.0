From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: soc-cache: Add trace event for
 snd_soc_cache_sync()
Date: Fri, 21 Jan 2011 16:47:33 +0000
Message-ID: <1295628453.3348.306.camel@odin>
References: <1295623742-7988-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 850FD103AF8
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 17:47:37 +0100 (CET)
Received: by wyi11 with SMTP id 11so1984941wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 08:47:37 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-21 at 15:29 +0000, Dimitris Papastamos wrote:
> This patch makes it easy to see when the syncing process begins and
> ends.  You can also enable the snd_soc_reg_write tracepoint to see
> which registers are being synced.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  include/trace/events/asoc.h |   25 +++++++++++++++++++++++++
>  sound/soc/soc-cache.c       |   10 ++++++++++
>  2 files changed, 35 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
