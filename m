From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [Patches_v2] Reforming S3C I2S towards supporting
	I2Sv4
Date: Tue, 4 May 2010 01:53:19 +0100
Message-ID: <20100504005319.GJ2589@trinity.fluff.org>
References: <1272351294-3650-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id AAB90243B9
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 02:53:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272351294-3650-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 03:54:54PM +0900, Jassi Brar wrote:
> I am going to resubmit pending last 11 patches of the original series
>  http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/025920.html
> No changes have been made other than moving dma_data from snd_soc_dai to
> snd_soc_pcm_stream in the new I2Sv4 controller driver.

All these look fine.

Acked-by: Ben Dooks <ben-linux@fluff.org>

It should also be ok to merge the s3c2412 DMA updates via the same
tree as there's not any intention to be touching this part of the tree
before the next merge.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
