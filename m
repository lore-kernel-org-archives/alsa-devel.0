From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 1/4 v3] pxa2xx-i2s: Proper hw initialization
Date: Thu, 14 May 2009 10:37:41 +0200
Message-ID: <4A0BD855.1060000@gmail.com>
References: <4A0BD586.8010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id DC73C24367
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 10:37:42 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1413519ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 01:37:42 -0700 (PDT)
In-Reply-To: <4A0BD586.8010406@gmail.com>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Karl Beldan wrote:
> Make sure we are in a know good state at end of probe :
> Reset FIFO logic and registers, and make sure REC and RPL functions
> along with FIFO service are disabled (SACR0_RST enables REC and RPL).
> 
> Resetting loses current settings so remove reset from stream startup.
> Now reset occurs only at probe.
> 

This differs from what you applied in that it includes 'removal of hw reset from
pxa2xx_i2s_startup'.
I understood including it in either one (1/4 or 2/4) is ok, since you had not
pushed it yet. Otherwise I'll have to post a [PATCH 2/4 v3] including the reset,
which would be identical to [PATCH 2/4] (initial version).
If I understand correctly from your replies, I should have posted [PATCH 1/4
v2]'s content with [PATCH 1/4 v3]'s Subject.

Thanks,

-- 
Karl
