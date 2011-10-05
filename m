From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused variable 'wm9090' in
	wm9090_probe
Date: Wed, 5 Oct 2011 17:23:05 +0100
Message-ID: <20111005162305.GE11528@opensource.wolfsonmicro.com>
References: <1317797235.21481.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A899D24466
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 18:23:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317797235.21481.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 02:47:15PM +0800, Axel Lin wrote:
> Eliminate below build warning:
>   CC      sound/soc/codecs/wm9090.o
> sound/soc/codecs/wm9090.c: In function 'wm9090_probe':
> sound/soc/codecs/wm9090.c:550: warning: unused variable 'wm9090'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
