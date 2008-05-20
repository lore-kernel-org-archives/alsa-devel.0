From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Fix null-pointer dereference
	in	soc_create_pcm()
Date: Tue, 20 May 2008 12:31:30 +0100
Message-ID: <20080520113130.GA32249@rakim.wolfsonmicro.main>
References: <1211237159-26546-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D027724874
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 13:31:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1211237159-26546-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 19, 2008 at 05:45:59PM -0500, Timur Tabi wrote:
> When soc_create_pcm() finds all four components it needs, it displays a status
> message.  This message references the local variables 'codec_dai' and
> 'cpu_dai', but these variables are initialized only when the codec DAI and the
> cpu DAI are the last to be registered.  This patch changes the code to use the
> stored values instead of the local variables.

Thanks, applied.
