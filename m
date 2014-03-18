From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Tue, 18 Mar 2014 14:35:48 +0200
Message-ID: <53283DA4.2080609@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
 <532588A3.4050301@metafoo.de> <5326F891.7090906@ti.com>
 <20140317165214.GT11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9999B26072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:35:54 +0100 (CET)
In-Reply-To: <20140317165214.GT11706@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/17/2014 06:52 PM, Mark Brown wrote:
> This is all sounding like the thing that needs to be looked at here is
> mplayer so we understand what's going wrong with regard to the buffer
> sizes.

The error which was printed by mplayer was the snd_pcm_hw_params() failure.
Prior to this call it calls number of snd_pcm_hw_params_set_* including:
snd_pcm_hw_params_set_buffer_time_near()
snd_pcm_hw_params_set_periods_near()

all without error.

So I recompiled alsa-lib with debug and compiled mplayer on the board as we=
ll.
I only kept the constraint for the period size from this patch (no constrai=
nt
on buffer size).

The compiled and original mplayer binary is working fine, no errors :o
Then I recompiled alsa-lib without debug (as it was before): same thing, mo=
th
mplayer binary works fine and it picks correct buffer configuration.

I'll resend the last two patch and place the constraint only to the period =
size.

> It's sounding like if we should be doing it this is a general
> thing which we should be constraining presumably it'd apply to all
> drivers, not just this one, and so shouldn't be being fixed in the
> driver but it's not obvious to me why the period constraint isn't
> sufficient.

It can only be done if we have fixed FIFO for the dai. Right now this is ki=
nd
of true for McASP. In HW we actually have 64 32bit word FIFO and currently =
you
can set the desired FIFO depth via DT/pdata. I'm not really happy about this
since it creates this constraint on the buffer allocation when the SoC is
using eDMA (when sDMA is in used with McASP we do not have such issue).
McBSP also have FIFO on OMAPs, but there I do not lock the FIFO depth, it is
adaptive based on the period/buffer size.

If we have more device with fixed FIFO depth then it make sense to handle t=
he
constraint in the core.

However in case of McASP it is still not that straight forward. The DMA bur=
st
size depends on the number of channels, number of used serializers and the
AFIFO's depth configuration. At the end the period size need to be constrai=
nt
to be steps of DMA burst size for eDMA.

Not sure if this is applicable for other SoCs.

-- =

P=E9ter
