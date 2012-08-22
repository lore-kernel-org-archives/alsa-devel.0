From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp
 header into platform and audio specific
Date: Wed, 22 Aug 2012 13:11:23 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA67D44@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
 <20120817223358.GI18871@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E52266113
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 15:11:30 +0200 (CEST)
In-Reply-To: <20120817223358.GI18871@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 18, 2012 at 04:03:58, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:01PM +0530, Hebbar, Gururaja wrote:
> > Davinci McASP header & driver are shared by few OMAP platforms (like
> > TI81xx, AM335x). Splitting asp header into Davinci platform specific
> > header and Audio specific header helps to share them across platforms.
> 
> This doesn't apply against v3.6-rc2, I suspect there's overlapping
> changes in arch/arm.  I was just going to apply it on a separate branch
> to allow cross-tree merge if there's overlap with architecture work.
> Can you please check and resend?

I will re-apply and send it as v2

> 


Regards, 
Gururaja
