From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Mon, 17 Jan 2011 13:45:02 +0000
Message-ID: <1295271902.3283.7.camel@odin>
References: <1295013168-29748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 38B80103804
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 14:45:07 +0100 (CET)
Received: by wyi11 with SMTP id 11so5141098wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 05:45:06 -0800 (PST)
In-Reply-To: <1295013168-29748-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, selma.bensaid@intel.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-14 at 19:22 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> The machine driver can't register the card directly and need to do this thru
> soc-audio device creation
> 
> This patch allows the register and unregister card to be directly called by
> machine drivers
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Fwiw, adding this functionality to core has been on my TODO list for a
while. I can delete this task now :)

Thanks !

Liam  
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
