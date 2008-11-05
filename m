From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add new parameter to
	s3c24xx_pcm_enqueue
Date: Wed, 5 Nov 2008 16:05:09 +0000
Message-ID: <20081105160508.GA18380@rakim.wolfsonmicro.main>
References: <744601.10057.qm@web54402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AC722446F
	for <Alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 17:05:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <744601.10057.qm@web54402.mail.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Anders <dave123_aml@yahoo.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 05, 2008 at 07:39:47AM -0800, David Anders wrote:
> The S3C24xx dma does not allow more than one buffer to be enqueue prior to
> the dma transfers starting. This patch adds an additional parameter to
> s3c24xx_pcm_enqueue() to allow for passing an initial dma maximum load
> value.
> 
> Signed-off-by: David Anders <danders at amltd.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Takashi, I'll push this later on today along with a few other things
that queued up.
