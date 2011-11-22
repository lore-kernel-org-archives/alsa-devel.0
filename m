From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 16:44:39 +0100
Message-ID: <4ECBC367.8080801@gmail.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E0E1103A94
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:44:43 +0100 (CET)
Received: by bkat8 with SMTP id t8so340668bka.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 07:44:43 -0800 (PST)
In-Reply-To: <20111122153539.GF6624@sirena.org.uk>
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

On 11/22/2011 04:35 PM, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 04:23:05PM +0100, Daniel Mack wrote:
> 
>> The bug is reproducible by setting the output volume to 50% before
>> sending the device to suspend. After wakeup, amixer still reports the
>> old volume level, but the codec is in fact set to 100%. Changing it to
>> 50% doesn't do anything, but to any other level has an effect. This is
>> clearly a cache sync bug, but the piece that's missing is the reason why
>> my patch does the right thing.
> 
> That's very odd, not ringing any bells at all.  It's not like the
> existing code is trying to do anything clever with skipping writes, it
> just blasts in all the register values and it's affecting two different
> registers.

The code is so simple that I'm starting to suspect
i2c_smbus_write_byte_data() is doing something very wrong, but I can't
trace it without a hardware I2C analyzer right now. The i2c-regmap
low-level implementation uses different access functions under the hood,
so maybe that's a regression.

We also think that the effect is actually rather new.

> In any case, the patch is moving to factor code out in favour of core
> facilities so it's a good idea anyway.

Hmm, we should really care for the root cause, but maybe we can still
commit this thing, with a more appropriate commit log?


Daniel
