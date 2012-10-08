From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ALSA: Add firmware caching to	CA0132
	codec.
Date: Mon, 8 Oct 2012 09:01:00 +0100
Message-ID: <20121008080059.GA10604@opensource.wolfsonmicro.com>
References: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
 <1348198161-9256-7-git-send-email-ian_minett@creativelabs.com>
 <20120925112634.GB32685@sirena.org.uk> <s5hpq4tl7x6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08A0D26167A
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 10:01:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpq4tl7x6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 08, 2012 at 09:49:57AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > More generally, why is this driver different to other Linux drivers
> > which don't normally cache the firmware?

> They usually do, if it's needed in the normal resume path.

It's not universally agreed that this is a wonderful idea, though...
