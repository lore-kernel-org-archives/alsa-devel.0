From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 14 Dec 2017 15:51:51 +0000
Message-ID: <20171214155151.gfauoqjwomhadibh@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214115648.qidtgzihdoikxvhe@localhost.localdomain>
 <20171214153139.GG9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1296B26732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 16:51:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214153139.GG9788@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, "Chen.Liu" <chen.liu.opensource@gmail.com>, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 03:31:39PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 11:56:48AM +0000, Charles Keepax wrote:
> > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
> 
> > > +	if (unsupported)
> > > +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x6,
> > > +				WM8960_SYSCLK_DIV_2);
> > > +
> 
> > Looking at this a bit more I do have some reservations. Firstly
> > this divider can be set through wm8960_set_dai_clkdiv, and
> > secondly it is also set at the bottom of
> 
> Removing set_clkdiv() would be a better thing if there were conflicts
> here, in general we're trying to avoid uses of it.

Ok that can probably be done as a separate patch I will review
again with that in mind.

Thanks,
Charles
