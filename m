From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/16] ASoC: wm2000: remove unused #include
 <linux/version.h>
Date: Thu, 8 Apr 2010 15:19:03 +0100
Message-ID: <20100408141903.GF30647@rakim.wolfsonmicro.main>
References: <1270727408-1672-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12E8A103818
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 16:19:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270727408-1672-1-git-send-email-weiyi.huang@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 07:50:08PM +0800, Huang Weiyi wrote:
> Remove unused #include <linux/version.h>('s) in
>   sound/soc/codecs/wm2000.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Applied.  Rather than continually posting these patches it would seem a
lot better if you were to instead patch checkpatch.pl to warn on use of
this header.  There's no reason to use it in the bulk of kernel code and
it'd be a lot less work to catch these things automatically.
