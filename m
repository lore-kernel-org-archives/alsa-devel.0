From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 16:23:05 +0100
Message-ID: <4ECBBE59.2040703@gmail.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7EF482433F
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:23:13 +0100 (CET)
Received: by bkat8 with SMTP id t8so315368bka.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 07:23:11 -0800 (PST)
In-Reply-To: <20111122140210.GD6624@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, timur@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 11/22/2011 03:02 PM, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 02:45:16PM +0100, Daniel Mack wrote:
>> Replace the manual register restore mechanism in cs4270.c and call
>> snd_soc_cache_sync() instead. The current is also wrong, as it doesn't
>> update the internal cache, leading to cache inconsitency after suspend.
> 
> I don't understand why this is a bug fix - the code is writing the
> values from the internal cache to the hardware and what's there doesn't
> look obviously wrong...

Hmm, you're right, that isn't obvious. I was too fast in blaming the
code wrong as it stands. But as a matter of fact, the patch *does* fix
the problem, Sven successfully tested it on various devices.

The bug is reproducible by setting the output volume to 50% before
sending the device to suspend. After wakeup, amixer still reports the
old volume level, but the codec is in fact set to 100%. Changing it to
50% doesn't do anything, but to any other level has an effect. This is
clearly a cache sync bug, but the piece that's missing is the reason why
my patch does the right thing.

I'll look into this again - thanks for the heads-up.
