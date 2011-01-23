From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix codec device id format used by
	some dai_links
Date: Sun, 23 Jan 2011 01:16:33 +0100
Message-ID: <4D3B7361.3030800@metafoo.de>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
	<20110122233309.GA22799@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 05CEF1037FB
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 01:16:52 +0100 (CET)
In-Reply-To: <20110122233309.GA22799@opensource.wolfsonmicro.com>
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
Cc: "for 2.6.37" <stable@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/23/2011 01:01 AM, Mark Brown wrote:
> On Sun, Jan 23, 2011 at 12:58:02AM +0100, Lars-Peter Clausen wrote:
>
>> I just went through the whole list and the wm8994 codec is a platform driver as well.
>> And on the jive board the wm8750 is connected through SPI.
>
> Yeah, Liam made up a lot of this stuff through guesswork but as you can
> see a mechanical run through fixing them won't work as not everything is
> I2C based in the first place.

On the other hand a mechanical run wont break anything that is not already broken,
but potentially fixes it.

I could resend the patch with those three cases which were definitely wrong in the
current patch fixed to use the correct SPI or platform id. Or I could just send the
fix for the neo1973 and neo1973_gta02 boards. Which one do you prefer?

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk07c2EACgkQBX4mSR26RiNwkgCcCwFvSv2k4pH+2KwHeP7zHB+3
aMsAn1PYvQnTXM36+DTASMgFXfcj9hRV
=OQXL
-----END PGP SIGNATURE-----
