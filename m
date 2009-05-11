From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
 SACR1_DREC separately
Date: Tue, 12 May 2009 00:00:33 +0200
Message-ID: <4A08A001.4050003@gmail.com>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 3845D244A6
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 00:00:36 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3337617fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 15:00:36 -0700 (PDT)
In-Reply-To: <20090511210729.GA4404@sirena.org.uk>
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
> On Mon, May 11, 2009 at 09:43:11PM +0200, Karl Beldan wrote:
> 
>> To be sure:
>> With current tree you do not have this problem.
>> You applied 1/4 and 2/4 and you have this problem.
>> Right ?
> 
> Actually just patch 2; patches 1 needs reworking.

Then it is perfectly normal since reset enables both REC and RPL, 2/4 needs 1/4.
The current tree disables the clocks anytime one function is disabled.

I resent 1/4 and will make it 1/5 with the whole serie once everything is Clear.


-- 
Karl
