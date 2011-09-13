From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: Disable WM8996 CPVDD supply when
	not in use
Date: Tue, 13 Sep 2011 15:53:20 +0100
Message-ID: <1315925600.5157.10.camel@odin>
References: <1315846757-21084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1315846757-21084-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id B07A0103999
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 16:53:24 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 10so670318wwf.8
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 07:53:23 -0700 (PDT)
In-Reply-To: <1315846757-21084-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2011-09-12 at 17:59 +0100, Mark Brown wrote:
> The WM8996 only requires CPVDD when the charge pump is active so control
> it separately to the other supplies, only enabling it when the charge pump
> is active. This will result in a small power saving on systems which are
> able to provide independent software control of the supply.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |   38 ++++++++++++++++++++++++++++++--------
>  1 files changed, 30 insertions(+), 8 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
