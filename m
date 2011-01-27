From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add subsequence information to
 seq_notify callbacks
Date: Thu, 27 Jan 2011 12:03:28 +0000
Message-ID: <1296129808.3376.27.camel@odin>
References: <1296078116-28867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDC0103AAA
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 13:03:37 +0100 (CET)
Received: by wyi11 with SMTP id 11so1945578wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 04:03:36 -0800 (PST)
In-Reply-To: <1296078116-28867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-26 at 21:41 +0000, Mark Brown wrote:
> Allows drivers to distinguish which subsequence is being notified when
> they get called back.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc-dapm.h |    2 +-
>  include/sound/soc.h      |    2 +-
>  sound/soc/soc-dapm.c     |    5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
