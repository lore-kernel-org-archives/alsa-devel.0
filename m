From: "=?iso-8859-1?q?R=E9mi?= Denis-Courmont" <remi@remlab.net>
Subject: Re: [PATCH 2/2] pcm_pulse: set prebuf parameter
	according to software parameters
Date: Fri, 16 Nov 2012 17:49:58 +0200
Message-ID: <201211161749.59094@leon.remlab.net>
References: <201211142007.19751@leon.remlab.net>
 <1352916477-17552-2-git-send-email-remi@remlab.net>
 <50A4A103.1090802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F35C265025
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 16:50:00 +0100 (CET)
In-Reply-To: <50A4A103.1090802@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le jeudi 15 novembre 2012 10:00:03, David Henningsson a =E9crit :
> On 11/14/2012 07:07 PM, R=E9mi Denis-Courmont wrote:
> > The current default value for prebuf is very high, almost the full
> > virtual ALSA buffer. This breaks some application especially where
> > low latency is involved.
> > =

> > This patch makes pcm_pulse implement the sw_params callback and get
> > the prebuf value from the ALSA software parameters. Thus the
> > trigger latency is much more like what an ALSA application should
> > expect from an ALSA PCM device.
> =

> This seems reasonable I believe; see review comments below.
> =

> > ---
> > =

> >   pulse/pcm_pulse.c |   25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> > =

> > diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
> > index 0165120..08b6cea 100644
> > --- a/pulse/pcm_pulse.c
> > +++ b/pulse/pcm_pulse.c
> > @@ -859,6 +859,30 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
> > =

> >   	return err;
> >   =

> >   }
> > =

> > +static int pulse_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t
> > *params) +{
> > +	snd_pcm_pulse_t *pcm =3D io->private_data;
> > +	snd_pcm_uframes_t start_threshold;
> > +
> > +	assert(pcm);
> > +
> > +	if (!pcm->p || !pcm->p->mainloop)
> > +		return -EBADFD;
> > +
> > +	pa_threaded_mainloop_lock(pcm->p->mainloop);
> > +
> > +	snd_pcm_sw_params_get_start_threshold(params, &start_threshold);
> > +
> > +	if (start_threshold < io->period_size)
> > +		start_threshold =3D io->period_size;
> =

> Why do we need the above constraint?

In my experience, PulseAudio really does not like having less than a period =

worth of buffered samples. I guess the code assumes there is always at leas=
t =

that much, and may underrun if not.

But sure enough, we could remove the constraint and blame the ALSA applicat=
ion =

for using inadequate parameters if a problem occurs. What do you prefer?
 =

-- =

R=E9mi Denis-Courmont
http://www.remlab.net/
