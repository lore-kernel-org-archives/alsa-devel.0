From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 0/3] ASoC: multi-comp: OMAP platform
 fixes
Date: Sat, 07 Aug 2010 13:02:50 +0100
Message-ID: <1281182570.3088.1.camel@odin>
References: <1281093038-24247-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E304424418
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 14:02:53 +0200 (CEST)
Received: by wyb42 with SMTP id 42so8578376wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 05:02:53 -0700 (PDT)
In-Reply-To: <1281093038-24247-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jkrzyszt@tis.icnet.pl
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-06 at 14:10 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1:
> - include plat/mcbsp.c in arch/arm/mach-omap1/devices.c
> - Runtime port number configuration based on OMAP type (both omap1 and omap2)
> 
> Commit message from the first series:
> 
> The following series introduces some cleanups for OMAP platforms in
> multi-component branch.
> 
> - Enable audio for OMAP1 class
> - Registers only the available amount of omap-mcbsp-dai devices for OMAP2,3,
>   and 4
> 
> Please do verify, if the chages are correct, especially the number of McBSP
> ports on different devices.
> 
> Liam: in case you take this, you can squash this to the corresponding commit.
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
