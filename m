From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
	hardware revision.
Date: Tue, 21 Jun 2011 01:23:39 +0100
Message-ID: <20110621002322.GE1905@opensource.wolfsonmicro.com>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CB2D244A2
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 02:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308596072-17158-1-git-send-email-thutt@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@chromium.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Olof Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 11:54:32AM -0700, Taylor Hutt wrote:
> The base hardware revision of the Maxim 98095 part is 0x40; the code
> which outputs the revision of the hardware has been updated to
> properly use uppercase alphabetic values for the revision numbers.

Are you sure that this is true for all devices that might be supported
by the driver (I'm guessing there may be other variants)?  There's often
a drift between silicon and package revisions which gets papered over by
datasheets and ignored by drivers.

> Also, the use of a constant for the length 'max98095_dai' has been
> replaced with ARRAY_SIZE().

Don't include a series of random unrelated changes in a single patch,
split them up into separate patches.  This makes review much easier if
nothing else.  There's no overlap at all between this change and the one
above.  The change is sensible.

>  	ret = snd_soc_read(codec, M98095_0FF_REV_ID);
>  	if (ret < 0) {
> -		dev_err(codec->dev, "Failed to read device revision: %d\n",
> +		dev_err(codec->dev, "Failure reading hardware revision: %d\n",
>  			ret);

You've also got this again unrelated change which isn't mentioned in the
changelog at all.
