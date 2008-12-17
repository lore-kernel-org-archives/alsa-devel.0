From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA: Add support for TV-out to the
	jack	reporting API
Date: Wed, 17 Dec 2008 15:06:36 +0000
Message-ID: <20081217150634.GD22204@sirena.org.uk>
References: <1229515473-24289-1-git-send-email-ext-jani.1.nikula@nokia.com>
	<s5hd4fr2bcx.wl%tiwai@suse.de>
	<20081217143358.GC22204@sirena.org.uk>
	<s5hhc5226yh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 39BF4243BF
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 16:06:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc5226yh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, Jani Nikula <ext-jani.1.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 17, 2008 at 03:48:38PM +0100, Takashi Iwai wrote:

> Can't we use a simple bit shift?  But, hum, it's not 1:1 mapping.

We could always use a bit shift and cope with the missing values.

> Simplifying the code like below might be still worth, though...

...

> +static int jack_types[] = {
> +	SW_HEADPHONE_INSERT, SW_MICROPHONE_INSERT, SW_LINEOUT_INSERT,
> +	SW_JACK_PHYSICAL_INSERT,
> +};

Yeah, I was trying to think of something that could end up in the
header more directly.
