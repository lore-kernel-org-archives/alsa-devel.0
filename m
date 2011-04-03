From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Name jack GPIOs based on jack
	not codec
Date: Sun, 3 Apr 2011 22:18:06 +0900
Message-ID: <20110403131804.GA17566@opensource.wolfsonmicro.com>
References: <1301691044-24080-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D20024371
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 15:17:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301691044-24080-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 01, 2011 at 02:50:43PM -0600, Stephen Warren wrote:
> snd_soc_jack_gpio has a name field. Use that name when registering the IRQ,
> since this is far more informative than the codec driver name. This shows
> up in /proc/interrupts.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied both, thanks.
