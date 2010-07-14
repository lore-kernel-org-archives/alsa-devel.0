From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm8727: add a missing return in
	wm8727_platform_probe
Date: Wed, 14 Jul 2010 20:26:12 +0100
Message-ID: <20100714192612.GA7532@rakim.wolfsonmicro.main>
References: <1279105051.2290.5.camel@phoenix> <1279119597.3080.120.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5D5910381A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 21:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279119597.3080.120.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Neil Jones <neil.jones@imgtec.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Axel Lin <axel.lin@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 14, 2010 at 03:59:57PM +0100, Liam Girdwood wrote:
> On Wed, 2010-07-14 at 18:57 +0800, Axel Lin wrote:
> > otherwise the error path will always be executed.

> Both

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

...and applied, thanks.
