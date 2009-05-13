From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 18:59:59 +0100
Message-ID: <20090513175959.GB27909@sirena.org.uk>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDF11038C6
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:00:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 01:55:43PM -0400, Jon Smirl wrote:
> I have three areas specifying audio formats. The WM9712 AC97 codec is
> S16_LE. My DMA hardware is S32_BE. All samples need to be in 32b words
> even if they are 8,16,24b.  The cpu's AC97 system sends the first 20
> big endian bits down the AC97 link in the proper order.

> How can I force the DMA engine setting to override what the codec is
> saying? Or should the codec be changed to specify all bit lengths and
> both endians?

In this specific case there's now a standard define for the AC97 codecs 
to use for the formats in current ASoC, add all the formats supported by
your CPU to that and all the AC97 codecs will pick it up automatically.
It's called SND_SOC_STD_AC97_FMTS, defined in the DAI header file.
