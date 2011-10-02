From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix setting update bits for
 WM8753_LADC and WM8753_RADC
Date: Sun, 2 Oct 2011 19:56:30 +0100
Message-ID: <20111002185630.GI2857@opensource.wolfsonmicro.com>
References: <1317559264.21926.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3D7410384C
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 20:56:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317559264.21926.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 08:41:04PM +0800, Axel Lin wrote:
> Current code set update bits for WM8753_LDAC and WM8753_RDAC twice,
> but missed setting update bits for WM8753_LADC and WM8753_RADC.
> 
> I think it is a copy-paste bug in commit 776065
> "ASoC: codecs: wm8753: Fix register cache incoherency".

Looks like it, yes.  Applied, thanks.
