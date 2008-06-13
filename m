From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 09:39:25 -0500
Message-ID: <4852869D.1040604@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>	
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>	
	<20080613134206.GA29575@rakim.wolfsonmicro.main>	
	<9e4733910806130710k38c45e18p29188e1426851339@mail.gmail.com>	
	<4852837C.6050401@freescale.com>	
	<9e4733910806130729u1bdf5159n5fd820e4e644573a@mail.gmail.com>	
	<485284F0.1070601@freescale.com>
	<9e4733910806130736r3660c622sb75666cb561986d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D75AE10382E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:39:29 +0200 (CEST)
In-Reply-To: <9e4733910806130736r3660c622sb75666cb561986d9@mail.gmail.com>
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

> Doesn't the fact that you needed to modify the fabric driver to create
> two PCMs indicate that there is something wrong with the design?
> There is one fabric and two ssi devices.

Well, you have a point there.  There is some redundancy between my fabric and
SSI drivers when it comes to figuring out what devices there are.

-- 
Timur Tabi
Linux kernel developer at Freescale
