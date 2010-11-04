From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Thu, 04 Nov 2010 09:51:02 +0000
Message-ID: <1288864262.3277.10.camel@odin>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 2955A103844
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 10:51:07 +0100 (CET)
Received: by wwi18 with SMTP id 18so174470wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 02:51:05 -0700 (PDT)
In-Reply-To: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-04 at 10:16 +0200, Peter Ujfalusi wrote:
> dapm_power_widgets can be called from different context.
> When two calls are happening at the same time both will
> try to change states/lists. This can lead to kernel crash.
> 
> A simple way to reproduce the problem:
> 
> while [ "1" = "1" ] ; do
> amixer sset -Dhw:0 -q 'Mixer for loopback' on
> amixer sset -Dhw:0 -q 'Mixer for loopback' off
> done &
> 
> while [ "1" = "1" ] ; do
> aplay -Dplughw:0 -fdat -d 3 /dev/urandom
> echo "Playback finished"
> sleep 6
> done &
> 
> Add new card level mutex (dpw_mutex) to protect the
> dapm_power_widgets from race.
> The exisiting card->mutex can not be used for this purpose,
> since it has been taken in probe time in the
> snd_soc_instantiate_card function. Through probe calls from
> this function eventually dapm_power_widgets will be called,
> which will lead to dead lock.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
