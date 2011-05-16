From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Skip noop reconfiguration of
	WM8958 DSP2 algorithms
Date: Mon, 16 May 2011 14:00:56 +0100
Message-ID: <4DD12008.5030702@ti.com>
References: <1305519496-23078-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BC451038DB
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 15:00:59 +0200 (CEST)
In-Reply-To: <1305519496-23078-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 16/05/11 05:18, Mark Brown wrote:
> If we're setting the currently applied value for one of the DSP algorithm
> configurations we can just skip all the handling as the control set is a
> noop. This ensures we do not disrupt a running DSP.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@ti.com>
