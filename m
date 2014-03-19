From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Wed, 19 Mar 2014 13:13:50 +0200
Message-ID: <53297BEE.4050903@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com> <53285827.1070709@ti.com>
 <20140318180732.GJ11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 72186265044
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 12:13:55 +0100 (CET)
In-Reply-To: <20140318180732.GJ11706@sirena.org.uk>
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

On 03/18/2014 08:07 PM, Mark Brown wrote:
> On Tue, Mar 18, 2014 at 04:28:55PM +0200, Peter Ujfalusi wrote:
>> On 03/18/2014 03:23 PM, Peter Ujfalusi wrote:
> =

>>> Oh, I edited the commit message and removed the text related to buffer =
size
>>> but I failed to do that for the commit title :(
> =

>> Actually I still have issue with the constraint.
> =

> OK, so is the patch an improvement or not?  If it fixes some cases it's
> probably worth applying even if further fixes are still needed.

Some application might fail (like mplayer with 44.1KHz) with constraint on =
the
period size only. Without the constraint we will have constant pops at every
period when non aligned size has been selected - if the FIFO depth is
configured to more than 1, which is not yet the case in upstream.

> No need to resend for the subject, I can fix that up.
> =

>> It seams that I need to place the same constraint step to both period si=
ze and
>> buffer size.
>> For some reason snd_pcm_hw_params_set_buffer_time_near() fails in case of
>> 44.1KHz when asking for 0.5s buffer when I placed step 32 constraint to =
period
>> size. Placing the same 32 steps constraint to the buffer size as well wi=
ll
>> make things working (for mplayer at least)
> =

> That seems like the constraint code is failing, at a guess probably
> looking for too near a value of near if you see what I mean.  I don't
> really have the time/enthusiasm to investigate this right now, sorry.

Yep, this needs to be investigated. Me or Jyri will take a look at this for
sure since it is somehow odd.

-- =

P=E9ter
