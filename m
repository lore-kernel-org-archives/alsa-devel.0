From: "Hadli, Manjunath" <manjunath.hadli@ti.com>
Subject: Re: [RESEND PATCH] davinci: CQ93VC: remove machine
	specific header	file inclusion from codec driver
Date: Wed, 8 Feb 2012 12:41:14 +0000
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F753174E3EC@DBDE01.ent.ti.com>
References: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
	<20120110184741.GG7164@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CEF824375
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 13:41:28 +0100 (CET)
In-Reply-To: <20120110184741.GG7164@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dlos <davinci-linux-open-source@linux.davincidsp.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Mark,

On Wed, Jan 11, 2012 at 00:17:41, Mark Brown wrote:
> On Tue, Jan 10, 2012 at 04:57:43PM +0530, Manjunath Hadli wrote:
> > remove unnecessary inclusion of machine specific header file 
> > mach/dm365.h from cq93vc.c voice codec driver which comes in the way 
> > of platform code consolidation.
> 
> Applied but please do try to use a subject line appropriate for the subsystem you're contributing to.
I still can't find this patch in the mainline, any issues?

Regards,
--Manju
> 
