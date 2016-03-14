From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs35l32: avoid uninitialized variable access
Date: Mon, 14 Mar 2016 10:03:00 -0500
Message-ID: <alpine.DEB.2.10.1603141002230.26218@heelroid>
References: <1457967019-3901380-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457967019-3901380-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2016, Arnd Bergmann wrote:

> gcc warns about the possibilty of accessing a property read from
> devicetree in cs35l32_i2c_probe() when it has not been initialized
> because CONFIG_OF is disabled:
> 
> sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
> sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> The code is actually correct because it checks the dev->of_node
> variable first and we know this is NULL here when CONFIG_OF
> is disabled, but Russell King noticed that it's broken when
> we probe the device using DT, and the properties are absent.
> 
> The code already has some checking for incorrect values, and
> I keep that checking unchanged here, but add an additional
> check for an error returned by the property accessor functions
> that now gets handled the same way as incorrect data in the
> properties.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: Restore a line that was accidentally removed, as pointed
>     out by Brian Austin.
> v2: fix bug in case of CONFIG_OF and missing properties
> v1: only address warning for the !CONFIG_OF case
> 
>  sound/soc/codecs/cs35l32.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks
