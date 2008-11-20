From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fix audio stall when doing
 full duplex
Date: Thu, 20 Nov 2008 12:28:38 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017061F2DE680@dbde02.ent.ti.com>
References: <1226986263-7815-1-git-send-email-naresh@ti.com>,
	<20081118113654.GD23217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 88B6C2434D
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 08:01:38 +0100 (CET)
In-Reply-To: <20081118113654.GD23217@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Mark,

Thanks!

I see that you had already taken care of Signed-of-by lines for this patch.

I will take care of this in my further patches.

Regards
Naresh



________________________________________
From: Mark Brown [broonie@sirena.org.uk]
Sent: Tuesday, November 18, 2008 5:06 PM
To: Medisetty, Naresh
Cc: alsa-devel@alsa-project.org; davinci-linux-open-source@linux.davincidsp.com; Steve Chen
Subject: Re: [alsa-devel] [PATCH] ASoC: DaVinci: Fix audio stall when doing full duplex

On Tue, Nov 18, 2008 at 11:01:03AM +0530, naresh@ti.com wrote:

> Fix concurrent capture/playback issue.
> The issue is caused by re-initialization of control registers used specifically
> for capture or playback in both capture and playback operations.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Signed-off-by: Steve Chen <schen@mvista.com>
>              Naresh Medisetty <naresh@ti.com>

This should be two separate Signed-off-by: lines.
