From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: fsl: move machine drivers to
	late_initcall()
Date: Tue, 18 Sep 2012 22:35:15 -0400
Message-ID: <20120919023514.GD8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5076F265129
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:35:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347657278-25295-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 04:14:35PM -0500, Timur Tabi wrote:
> Transition the module initialization to late_initcall(), so that
> the machine driver loads last.  Although this is technically not
> necessary, it does avoid this error message at boot time:
> 
> 	ALSA device list:
> 	  No soundcards found.

As I said previously I think this needs a change that applies to all
drivers, like I say removing the above print seems the most sensible one
to me.
