From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mainline tlv320aic26 driver
Date: Tue, 19 May 2009 10:09:50 -0600
Message-ID: <fa686aa40905190909r71a2a76ft51a01c9e14458343@mail.gmail.com>
References: <4A11AC9D.10004@drewtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id C22D8243AF
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 18:10:11 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so3008685ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 19 May 2009 09:10:10 -0700 (PDT)
In-Reply-To: <4A11AC9D.10004@drewtech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joey Oravec <joravec@drewtech.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

BTW, Please cc: the the alsa-devel@alsa-project.org mailing list when
asking questions.  I don't know everything and others can chime in
that way.

On Mon, May 18, 2009 at 12:44 PM, Joey Oravec <joravec@drewtech.com> wrote:
> Grant -
>
> I'm trying to create an ASoC driver for my at91 platform with a tlv320aic26,
> and I have a question about your driver. I'm looking at mainline 2.6.29.
>
> Inside aic26_probe() it's looking for struct aic26 to from
> socdev->codec_data. I see how aic26_spi_probe() kzalloc's the structure,
> sets some values in aic26->codec, but I have no idea when you expected
> codec_data would get set. Could you briefly explain which function is
> responsible to set that pointer and when it should happen?

Since the aic26 is an SPI device, it is first probed (as you found) in
the aic26_spi_probe() function.  On my platform, the connection
between the codec and the bus driver is described in an OF Flattened
Device Tree and it uses the snd-of-simple driver to match the codec
and platform drivers.  So, the codec_data value is pass via the
of_snd_soc_register_codec() function.

I don't know the best way for your fabric driver to find the aic26 spi
device.  It probably should use bus_find_device() and
dev_get_drvdata() to resolve to the value that codec_data should be
set to.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
