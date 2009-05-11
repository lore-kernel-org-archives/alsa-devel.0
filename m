From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
 SACR1_DREC separately
Date: Mon, 11 May 2009 21:43:11 +0200
Message-ID: <4A087FCF.2080304@gmail.com>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 74876243FE
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 21:43:14 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3262618fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 12:43:14 -0700 (PDT)
In-Reply-To: <20090511190504.GF20283@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, May 08, 2009 at 11:42:29AM +0100, Mark Brown wrote:
> 
>> ...this really ought to be a separate patch.  I'll wait until Monday
>> when I'm back in the office before applying so I can test.
> 
> This patch is causing problems in my testing.  With the patch the clocks
> are not stopped when closing the stream, causing the next playback to
> fail.  However, the error handling from that causes the appropriate
> cleanup and allows playback to proceed.
> 

To be sure:
With current tree you do not have this problem.
You applied 1/4 and 2/4 and you have this problem.
Right ?

> I've not had time to review properly what's going on here - I suspect
> that the splits in the patch series need to be looked at but for now
> I'll not apply this.

-- 
Karl
