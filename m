From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] Add i.MX sound support
Date: Fri, 27 Nov 2009 08:58:34 +0100
Message-ID: <20091127075834.GG27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D70031038E8
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 08:58:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Javier,

On Thu, Nov 26, 2009 at 04:53:21PM +0100, javier Martin wrote:
> Dear Sascha,
> what repository - branch are these patches tested against? They don't seem
> to apply in git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> branch.

Try this branch instead to get a full series also containing the mc13783
support and full board support for the Phytec boards:

git://git.pengutronix.de/git/imx/linux-2.6.git asoc

I posted only the patches relevant to the alsa list. By now mxc-master
should contain the missing bits.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
