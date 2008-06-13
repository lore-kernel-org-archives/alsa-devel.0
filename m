From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
 MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 09:32:16 -0500
Message-ID: <485284F0.1070601@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>	<20080613134206.GA29575@rakim.wolfsonmicro.main>	<9e4733910806130710k38c45e18p29188e1426851339@mail.gmail.com>	<4852837C.6050401@freescale.com>
	<9e4733910806130729u1bdf5159n5fd820e4e644573a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 99F9F2447D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:32:20 +0200 (CEST)
In-Reply-To: <9e4733910806130729u1bdf5159n5fd820e4e644573a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> That forces every board to copy/paste the fabric driver and then makes
> tweaks to it even if it doesn't need board specific code.

Not at all.   There's no reason we can't create a generic fabric driver that
does no board-level programming.  I haven't done it because the MPC8610 does
need that kind of programming, and it's based on the information I get from the
SSI driver.  But you could just as easily take my fabric driver and make it
generic.  I don't know who would use it, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
