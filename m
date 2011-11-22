From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 17:04:46 +0100
Message-ID: <4ECBC81E.6030300@gmail.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk> <4ECBC367.8080801@gmail.com>
	<20111122155340.GB30583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7726F103AA6
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 17:04:54 +0100 (CET)
Received: by bkat8 with SMTP id t8so366215bka.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 08:04:54 -0800 (PST)
In-Reply-To: <20111122155340.GB30583@opensource.wolfsonmicro.com>
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

On 11/22/2011 04:53 PM, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 04:44:39PM +0100, Daniel Mack wrote:
> 
>> The code is so simple that I'm starting to suspect
>> i2c_smbus_write_byte_data() is doing something very wrong, but I can't
>> trace it without a hardware I2C analyzer right now. The i2c-regmap
>> low-level implementation uses different access functions under the hood,
>> so maybe that's a regression.
> 
> Could be, though I can't see any changes in the code here.  It might be
> that a change between SMBus and regmap at runtime is upsetting the
> device somehow but given that it's supposed to be coming back from a
> power on reset...

That should affect more codecs then, right?

$ git grep -l i2c_smbus_write sound/
sound/aoa/codecs/onyx.c
sound/aoa/codecs/tas.c
sound/ppc/daca.c
sound/ppc/tumbler.c
sound/soc/codecs/tpa6130a2.c

>> We also think that the effect is actually rather new.
> 
> Does reverting to the non-regmap soc-io.c help?

Is there a single commit we can revert on top of 3.2-git to test this?

>>> In any case, the patch is moving to factor code out in favour of core
>>> facilities so it's a good idea anyway.
> 
>> Hmm, we should really care for the root cause, but maybe we can still
>> commit this thing, with a more appropriate commit log?
> 
> I think so.

Ok, I'll repost with a better log then.
