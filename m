From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND PATCH] davinci: CQ93VC: remove machine specific header
	file inclusion from codec driver
Date: Tue, 10 Jan 2012 18:47:41 +0000
Message-ID: <20120110184741.GG7164@opensource.wolfsonmicro.com>
References: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: dlos <davinci-linux-open-source@linux.davincidsp.com>, LAK <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2012 at 04:57:43PM +0530, Manjunath Hadli wrote:
> remove unnecessary inclusion of machine specific header
> file mach/dm365.h from cq93vc.c voice codec driver
> which comes in the way of platform code consolidation.

Applied but please do try to use a subject line appropriate for the
subsystem you're contributing to.
