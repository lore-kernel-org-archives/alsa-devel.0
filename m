From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: remove 'dres' field from
 platform data structure
Date: Fri, 21 Sep 2012 08:35:18 -0400
Message-ID: <20120921123518.GA27305@opensource.wolfsonmicro.com>
References: <1348167447-18489-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99F7B265D25
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 14:35:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348167447-18489-1-git-send-email-timur@freescale.com>
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

On Thu, Sep 20, 2012 at 01:57:27PM -0500, Timur Tabi wrote:
> The 'dres' field (discharge resistance for headphone outputs) is no longer
> used in the driver, so remove it.
> 
> It was used in the original version of the driver when entering standby
> from off, but we stopped using it when we switched from having a single
> startup sequence to having separate cap and capless sequences.

Applied, thanks.
