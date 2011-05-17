From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: Re: [PATCH v2 1/3] ASoC: Asahi Kasei AK4641 codec
	driver
Date: Tue, 17 May 2011 08:26:44 +0400
Message-ID: <20110517042644.GA19254@rainbow>
References: <1305579805-15617-1-git-send-email-mad_soft@inbox.ru>
	<1305579805-15617-2-git-send-email-mad_soft@inbox.ru>
	<20110516212533.GA2570@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A5432440D
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 06:26:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110516212533.GA2570@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 22:25 Mon 16 May     , Mark Brown wrote:
> On Tue, May 17, 2011 at 01:03:23AM +0400, Dmitry Artamonow wrote:
> > A driver for the AK4641 codec used in iPAQ hx4700 and Glofiish M800
> > among others.
> 
> This looks pretty good - a few small issues realting to the use of old
> APIs and coding standards below but nothing serious.
> 

Hi, Mark! Thanks for review - your comments are really valuable.
It seems that ASoC APIs change faster than I adapt this driver to them, but
I hope that preparing v3 will take less time than v1->v2 took :)

-- 
Best regards,
Dmitry "MAD" Artamonow
