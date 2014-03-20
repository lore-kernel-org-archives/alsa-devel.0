From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Thu, 20 Mar 2014 15:47:06 +0200
Message-ID: <532AF15A.4090506@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com> <53285827.1070709@ti.com>
 <20140318180732.GJ11706@sirena.org.uk> <53297BEE.4050903@ti.com>
 <20140319131457.GK11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 87029265119
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 14:47:11 +0100 (CET)
In-Reply-To: <20140319131457.GK11706@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 03/19/2014 03:14 PM, Mark Brown wrote:
> On Wed, Mar 19, 2014 at 01:13:50PM +0200, Peter Ujfalusi wrote:
>> On 03/18/2014 08:07 PM, Mark Brown wrote:
> =

>>> OK, so is the patch an improvement or not?  If it fixes some cases it's
>>> probably worth applying even if further fixes are still needed.
> =

>> Some application might fail (like mplayer with 44.1KHz) with constraint =
on the
>> period size only. Without the constraint we will have constant pops at e=
very
>> period when non aligned size has been selected - if the FIFO depth is
>> configured to more than 1, which is not yet the case in upstream.
> =

> OK, given that the FIFO depth change isn't yet upstream it'd be a step
> backwards so I'll leave this for now.

I have looked at the issue and I found some clues on why mplayer fails:
it try to set the snd_pcm_hw_params_set_buffer_time_near() first followed by
the snd_pcm_hw_params_set_periods_near(). And this fails in some cases when=
 we
have constraint step on the period only.
Other applications set the period param first followed by the buffer (aplay
and various alsa test tools as well).
PA however have a fallback mechanism:
1. buffer first followed by period
2. period first followed by buffer
3. buffer only
4. period only
5. no period, no buffer params

When I have step constraint on period PA fails with the first, second (beca=
use
there's a bug in the PA code here) and third method but going to succeed wi=
th
four.

I have looked around in the kernel and other drivers do set both period and
buffer step constraint, for example:

sound/arm/pxa2xx-pcm-lib.c (_BYTES)
sound/drivers/vx/vx_pcm.c (_BYTES)
sound/pci/echoaudio/echoaudio.c (_SIZE)
sound/pci/ice1712/ice1724.c (_BYTES)
sound/pci/lola/lola_pcm.c (_SIZE)
sound/soc/kirkwood/kirkwood-dma.c (_BYTES)
sound/soc/s6000/s6000-pcm.c (_BYTES)
...

I still don't know why buffer size fails (in some cases) if we only have st=
ep
constraint on the period size, but it looks to me that others also encounte=
red
with similar issues and the fix they have is the same what I had in the fir=
st
version of the patch.

-- =

P=E9ter
