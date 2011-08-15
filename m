From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: shortcut the for loop to get
	ir and mcs
Date: Mon, 15 Aug 2011 22:54:51 +0900
Message-ID: <20110815135438.GA4234@opensource.wolfsonmicro.com>
References: <1313292664.6074.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 915C124642
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:54:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313292664.6074.1.camel@phoenix>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 14, 2011 at 11:31:04AM +0800, Axel Lin wrote:
> There is exactly one match or no match at all during the for loop iteration,
> thus we can break from the for loop once a match is found.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
