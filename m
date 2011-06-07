From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin: bf5xx-ad1836: Fix codec
	device name
Date: Tue, 7 Jun 2011 09:50:19 +0100
Message-ID: <20110607085018.GC18544@opensource.wolfsonmicro.com>
References: <1307435086-29877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 666E82439E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:50:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307435086-29877-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 10:24:46AM +0200, Lars-Peter Clausen wrote:
> Fix the codec_name field of the dai_link to match the actual device name
> of the codec. Otherwise the card won't be instantiated.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.
