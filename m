From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap3beagle: Add dai link for McBSP2
 master configuration (CLKS source)
Date: Tue, 28 Feb 2012 10:36:26 +0200
Message-ID: <4F4C920A.4090606@bitmer.com>
References: <1330415714-5136-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id B841324573
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:36:04 +0100 (CET)
In-Reply-To: <1330415714-5136-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 09:55 AM, Peter Ujfalusi wrote:
> Create new dai link so we can choose between two different modes of operation:
> PCM0: twl4030 master, McBSP2 slave (current configuration)
> PCM1: twl4030 slave, McBSP2 slave (SRG source is from CLKS pin)
> 
> This will help us tracking down, and test different setups on Beagle board.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hello,
> 
> While tracking down an issue regported by Grazvydas Ignotas regarding to the
> McBSP move series (Pandora setup was not working) I have noticed that we can
> use the Beagle board in a similar way as Pandora uses it (McBSP master, twl4030
> slave, CLKS pin is connected to twl4030 256*FS clock output).
> With this patch we can switch between the two modes by playing on hw:0,0 or on
> hw:0,1.
> 
> I will add the third option later where McBSP is the master, but the clock for
> SRG is coming from internal source.
> 
> This patch depends on the McBSP rewrite series (OMAP/ASoC: Move and merge McBSP
> driver under ASoC)
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049628.html
> 
Is this something that is better to stay in list archives not under
version control? This looks to me as a developer debug feature.

-- 
Jarkko
