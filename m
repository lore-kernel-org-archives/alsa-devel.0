From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2.6.30] ASoC: remove stand-alone
	mode	support from CS4270 codec driver
Date: Fri, 23 Jan 2009 11:19:54 +0000
Message-ID: <20090123111953.GA17118@rakim.wolfsonmicro.main>
References: <1232670219-16780-1-git-send-email-timur@freescale.com>
	<s5hy6x2ikid.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46E26243BF
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 12:19:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy6x2ikid.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2009 at 07:50:18AM +0100, Takashi Iwai wrote:

> This "depends" doesn't work because CONFIG_SND_SOC_CS4270 is selected
> usually by others.  The reverse-selection ignores the depends of the
> target item.

Applied with that dependency removed.
