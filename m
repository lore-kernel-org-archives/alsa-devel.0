From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Mon, 07 Jan 2008 18:44:47 +0000
Message-ID: <1199731487.19903.56.camel@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id 19CB524988
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:44:52 +0100 (CET)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T8461fa7947ac140805e30@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Mon, 7 Jan 2008 18:44:48 +0000
In-Reply-To: <47824AA3.5070808@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-01-07 at 09:52 -0600, Timur Tabi wrote:
> 
> So all I'm trying to do now is get my driver, with warts and all, into the tree 
> so that I can focus with Liam et al to get a real ASoC V2 up and running.
> 

I'll commit the MPC8610 into the ASoC (v1) dev tree soon (hopefully
tonight). This will allow folks to use it in the meantime whilst we sort
out any changes.

I'll then port (what I can) to V2, although I may need some assistance
with some of the PPC sections.

Fwiw we are looking at submitting V2 in March/April time. 


Liam

PS. Sorry for the silence lately. We've just moved to a new opensource
server over the holidays and have been without some services i.e. mail.



Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK
