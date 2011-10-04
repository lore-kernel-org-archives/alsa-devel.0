From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm8994: Slightly optimize
	configure_clock
Date: Tue, 4 Oct 2011 13:10:07 +0100
Message-ID: <20111004121006.GA6934@opensource.wolfsonmicro.com>
References: <1317730023.17783.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4488B2461C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 14:10:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317730023.17783.2.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 08:07:03PM +0800, Axel Lin wrote:
> snd_soc_update_bits() will only write new register value
> if the old value is different from the new value.
> In additional, snd_soc_update_bits() returns 0 for no change.
> No need to read WM8994_CLOCKING_1 register before calling snd_soc_update_bits().

Applied, thanks.
