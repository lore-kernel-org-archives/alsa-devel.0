From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 16:57:30 +0100
Message-ID: <4ECBC66A.2060005@gmail.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
	<4ECBC367.8080801@gmail.com> <4ECBC41D.4000904@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1FD103AAB
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:57:37 +0100 (CET)
Received: by faaa20 with SMTP id a20so563341faa.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 07:57:37 -0800 (PST)
In-Reply-To: <4ECBC41D.4000904@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 11/22/2011 04:47 PM, Timur Tabi wrote:
> Daniel Mack wrote:
>> The code is so simple that I'm starting to suspect 
>> i2c_smbus_write_byte_data() is doing something very wrong, but I
>> can't trace it without a hardware I2C analyzer right now. The
>> i2c-regmap low-level implementation uses different access functions
>> under the hood, so maybe that's a regression.
> 
> What platform are you testing this on?

Some Raumfeld devices feature this codec, connected to an ARM PXA3xx.

> I never really understood the
> i2c vs. smbus thing (I can never tell which function an i2c device
> really needs), so I only know that the i2c code works on my PowerPC
> board.

Yes, that's a mess. SMBUS is a higher level protocol that is based in
I2C and adds an awareness of "registers" and "values". However, it
really just resembles to 2-byte instructions on the bus, which is what I
needed when I implemented the code some years ago.

> Also keep in mind that a patch that affects
> i2c_smbus_write_byte_data() on PowerPC was recently posted, but not
> approved yet.  Check the thread, "i2c/busses: (mpc) Add support for
> SMBUS_READ_BLOCK_DATA".

Well, we're on a different platform and we don't use BLOCK_DATA
transfers but single byte instructions. You still think it's related?


Daniel
