From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Correct McASP FIFO
	initialization
Date: Wed, 23 Sep 2009 18:37:51 +0100
Message-ID: <20090923173750.GA484@opensource.wolfsonmicro.com>
References: <1253715128-31452-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F2D4103878
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 19:37:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253715128-31452-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2009 at 10:12:08AM -0400, Chaithrika U S wrote:
> McASP write FIFO registers should be modified for playback and read FIFO
> registers for capture. Check the PCM mode before manipulating the
> FIFO registers. Currently, irrespective of playback/capture both the
> FIFOs are enabled or disbaled. This resulted in errors in audio loopback
> mode.

> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

Applied, thanks.
