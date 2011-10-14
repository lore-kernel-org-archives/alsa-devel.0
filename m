From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: wm8961: Convert codec->hw_read
	to snd_soc_read
Date: Fri, 14 Oct 2011 20:36:07 +0100
Message-ID: <20111014193606.GI2931@opensource.wolfsonmicro.com>
References: <1318556120.6379.1.camel@phoenix> <1318556272.6379.4.camel@phoenix>
	<1318556354.6379.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3EB60103AEB
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:36:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318556354.6379.5.camel@phoenix>
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

On Fri, Oct 14, 2011 at 09:39:14AM +0800, Axel Lin wrote:
> codec->hw_read is broken now, let's covert to snd_soc_read.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
