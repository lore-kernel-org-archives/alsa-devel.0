From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: core - refactored DAPM pin control
	API.
Date: Fri, 04 Jul 2008 18:38:44 +0100
Message-ID: <1215193124.6440.16.camel@odin>
References: <1215180449.4882.131.camel@localhost.localdomain>
	<s5h4p75lmjp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C02824ACD
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 19:38:47 +0200 (CEST)
In-Reply-To: <s5h4p75lmjp.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-07-04 at 17:02 +0200, Takashi Iwai wrote:
> At Fri, 04 Jul 2008 15:07:29 +0100,
> Liam Girdwood wrote:
> > 
> > Refactored snd_soc_dapm_set_endpoint() to snd_soc_dapm_enable_pin() and
> > snd_soc_dapm_disable_pin().
> > 
> > Renamed snd_soc_dapm_sync_endpoints() to snd_soc_dapm_sync().
> > Renamed snd_soc_dapm_get_endpoint_status() to
> > snd_soc_dapm_get_pin_status().
> > 
> > Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> 
> This doesn't apply correctly (e.g. soc/sh/exmmb-is2.c doesn't exist).
> Is it for ASoC v1?
> 

It's the start of the V1 -> V2 transition (non-invasive trivial stuff
only atm - to lessen the diffs later). I guess I sent a little extra.
Will redo on Monday.

Liam
