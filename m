From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sat, 17 Mar 2012 15:49:06 -0400
Message-ID: <CA+7tXiheVO6FAypZU-yRuT=Cg3iPAgHeQOmVpZ_zJF_T5JdORw@mail.gmail.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
	<20120316192231.GI3158@opensource.wolfsonmicro.com>
	<CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
	<20120317114856.GN3158@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BF4BA243A0
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 20:49:09 +0100 (CET)
Received: by werg1 with SMTP id g1so5188641wer.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 12:49:06 -0700 (PDT)
In-Reply-To: <20120317114856.GN3158@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 17, 2012 at 7:48 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On Fri, Mar 16, 2012 at 06:01:44PM -0400, Trent Piepho wrote:
> > On Fri, Mar 16, 2012 at 3:22 PM, Mark Brown
>
> > > There's a way to do this, and it's the way that the WM8988 driver is
> > > doing it - obviously you'll have different criteria for choosing
> > > constraints but the actual application of the constraints is going to=
 be
> > > done in the same way.
>
> > Since the constraint is based on the current configuration of another
> > DAI, the two DAIs need some way to query each other's parameters. =A0The
>
> Since they're both provided by the same driver this is trivial.

It's not that trivial with the sub-streams in question aren't in the
same instance of the driver, e.g. playback and record.=A0 Say you had
two WM8988 codecs, how does one codec get a handle to the other?
There's no global list of codecs in the driver, so you have to add
something like that.=A0Or change the device tree binding to give the
slave codec a phandle to the master codec.

> > And as I said before, ALSA doesn't handle this 100%. =A0There is a race
> > if both streams are initialized at the same time. =A0If you open one
>
> Yes, I did reply to your previous mail about that pointing out that this
> is impossible...

...which didn't arrive until after I started writing my email.

> > I think what's necessary is for ALSA to let hw_params return an error
> > code that means lets the driver say, "Sorry, the constraints have
> > changed and the hw_params you have chosen are no longer valid. =A0Here
> > are new constraints, please try again."
>
> Thinking about this slightly further than in my reply to Lars-Peter a
> few minutes ago...
>
> I think just returning -EINVAL on bad parameters (which is pretty much
> what we do) is sufficient for this if the driver is good about keeping
> the constraints up to date. =A0Applications should already be able to take
> the hint, though I imagine most of them wouldn't trust the drivers to
> provide accurate constraints and aren't as widely deployed as PulseAudio
> (which forced fixing the DMA stuff by virtue of everyone using it).
> Though just spinning a small number of times will probably deal with
> lying drivers well enough.

Does PulseAudio handle it if hw_params fails?  From what I've seen,
most applications just fail if hw_params fails.

I think there is still a race in the design of ALSA, in that the
driver checking the parameters in its hw_params() method is not atomic
with the substream being assigned those parameters, w.r.t. another
substream.

The problem is in the code for snd_pcm_hw_params(),

 405        err =3D snd_pcm_hw_params_choose(substream, params);
 406        if (err < 0)
 407                goto _error;
 408
 409        if (substream->ops->hw_params !=3D NULL) {
 410                err =3D substream->ops->hw_params(substream, params);
 411                if (err < 0)
 412                        goto _error;
 413        }
 414
 415        runtime->access =3D params_access(params);
 ...
 455        runtime->status->state =3D SNDRV_PCM_STATE_SETUP;

At line 410 the driver is given a chance to approve the selected
hw_params.  It can look at any of the joint substreams, and if they
are in state >=3D SETUP, verify that the hw_params are still valid and
if not, update the constraints and return an error.  But it is not
until line 455 that the substream has actually finished getting the
parameters and entered the SETUP state. There is no lock to prevent
another substream from entering this code at the same time.  To fix
the race, there would need to be a critical section from line 408-455
that only one substream of the group with joint constraints can enter
at one time.
