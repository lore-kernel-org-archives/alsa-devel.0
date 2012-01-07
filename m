From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v8 2/2] davinci: CQ93VC: remove machine
 specific header file inclusion from codec driver
Date: Sat, 7 Jan 2012 00:53:50 +0000
Message-ID: <20120107005350.GA26307@sirena.org.uk>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
	<1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D0A0103840
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 01:53:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: dlos <davinci-linux-open-source@linux.davincidsp.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Miguel Aguilar <miguel.aguilar@ridgerun.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2012 at 12:47:49PM +0530, Manjunath Hadli wrote:
> remove unnecessary inclusion of machine specific header
> file mach/dm365.h from cq93vc.c voice codec driver
> which comes in the way of platform code consolidation.

*Always* CC maintainers on patches.  If you send me a copy directly this
looks OK.
