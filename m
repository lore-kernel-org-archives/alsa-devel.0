From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make SND_SOC_LITTLEMILL select
	MFD_WM8994
Date: Sun, 4 Dec 2011 01:25:23 +0000
Message-ID: <20111204012522.GB31215@opensource.wolfsonmicro.com>
References: <1322957717.19303.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02D72244C2
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 02:25:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322957717.19303.2.camel@phoenix>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2011 at 08:15:17AM +0800, Axel Lin wrote:
> SND_SOC_LITTLEMILL selects SND_SOC_WM8994, but SND_SOC_WM8994 needs MFD_WM8994.
> Thus we need to select MFD_WM8994 to fix below build error:
> 

Applied, thanks.
