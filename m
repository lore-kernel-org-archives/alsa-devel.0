From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: mainline tlv320aic26 driver
Date: Tue, 19 May 2009 19:19:06 +0100
Message-ID: <20090519181905.GA4476@sirena.org.uk>
References: <4A11AC9D.10004@drewtech.com>
	<fa686aa40905190909r71a2a76ft51a01c9e14458343@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72E8210380E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 20:19:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40905190909r71a2a76ft51a01c9e14458343@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Joey Oravec <joravec@drewtech.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 10:09:50AM -0600, Grant Likely wrote:

> I don't know the best way for your fabric driver to find the aic26 spi
> device.  It probably should use bus_find_device() and
> dev_get_drvdata() to resolve to the value that codec_data should be
> set to.

With non-PowerPC platforms that don't use the of-simple bodge the
machine driver finds the CODEC by referencing them from the data
structures referenced from the snd_soc_device.  You don't need to look
up the struct device for the CODEC.

For an AT91 example look at the sam9g20_wm8731.c driver - you want to
replace the references to the wm8731 DAI and CODEC with those for the
tlv320aic26.
