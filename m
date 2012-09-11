From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: use snd_soc_register_card
 to register the card
Date: Tue, 11 Sep 2012 08:31:01 +0800
Message-ID: <20120911003100.GJ30699@opensource.wolfsonmicro.com>
References: <1347314576-13832-1-git-send-email-timur@freescale.com>
 <1347314576-13832-2-git-send-email-timur@freescale.com>
 <20120911001330.GD30699@opensource.wolfsonmicro.com>
 <6AE080B68D46FC4BA2D2769E68D765B7080532B9@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27674264EAA
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:31:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7080532B9@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 12:27:04AM +0000, Tabi Timur-B04825 wrote:

> Ok, I'll split it, but I do agree that it should be fixed in ASoC itself. 
>   I just don't know how to do that.

I'd probably go with the simpler approach of just removing the log
message, possibly replacing it with one as each card is instantiated.
