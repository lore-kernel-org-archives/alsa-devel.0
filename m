From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Tue, 24 Jul 2007 14:30:29 -0500
Message-ID: <46A65355.4040101@freescale.com>
References: <46A4CF38.3050107@freescale.com>	<1185210867.7590.1201603759@webmail.messagingengine.com>	<46A4E503.50207@freescale.com>	<1185261264.6647.1201715813@webmail.messagingengine.com>	<46A612A0.6000807@freescale.com>
	<s5hd4yhyh5n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 6ED001038BB
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 21:30:38 +0200 (CEST)
In-Reply-To: <s5hd4yhyh5n.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> #define SNDRV_PCM_RATE_ALL (SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATES_5512)
> 
> I'd prefer 5512_19200.  The word "ALL" may vary in future.

That's the point.  It's supposed to indicate all sample rates no matter what they are or 
will be.  However, that may be a moot point ...

> Anyway, the bits SND_PCM_RATES_[0-9]* are ignored when _CONTINUOUS or
> _KNOT is passed.  Only the values in rate_min/rate_max fields are
> referred as actual min/max rates.

Ah!  I wish this stuff were documented in the source files.

So can I do this?

static const struct snd_pcm_hardware mpc86xx_pcm_hardware = {

	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min		= 1,
	.rate_max		= (unsigned int) -1,


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
