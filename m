From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC V2: disable automatic volume
 control in the CS4270 sound driver
Date: Fri, 08 Aug 2008 10:03:30 -0500
Message-ID: <489C6042.80203@freescale.com>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
	<1218126153-26095-2-git-send-email-timur@freescale.com>
	<20080808105436.GA10867@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A3DF24AD0
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 17:03:43 +0200 (CEST)
In-Reply-To: <20080808105436.GA10867@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Aug 07, 2008 at 11:22:32AM -0500, Timur Tabi wrote:
>> Disable the automatic volume control feature of the CS4270 audio codec.  This
>> feature, which is enabled by default, causes volume change commands to be
>> delayed.  Sometimes the volume change happens after playback is started.
> 
> All applied, thanks.
> 
> Should this also be done for current mainline?

No.  I'm only doing critical fixes for mainline now.  Unless someone
specifically asks for this particular fix, I'm not going to put it in.  I have
no more planned fixes for mainline.

-- 
Timur Tabi
Linux kernel developer at Freescale
