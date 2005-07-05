From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: A suggestion to solve the ALSA resampling problem.
Date: Tue, 5 Jul 2005 15:46:13 +0100
Message-ID: <ad2655cb050705074656384a1e@mail.gmail.com>
References: <42C6874E.9060301@superbug.co.uk> <s5hoe9ifs1a.wl%tiwai@suse.de>
Reply-To: James Courtier-Dutton <james.dutton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe9ifs1a.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 7/4/05, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 02 Jul 2005 13:23:42 +0100,
> James Courtier-Dutton wrote:
> >
> > Hi,
> >
> > There are essentually 2 problems to solve. I will take the alsa code in
> > the game doom3 as a way to demonstrate the problems.
> >
> > doom3 uses a sample rate of 44100. Most sound cards now work at 48000 i=
n
> > hardware, so one needs to sample rate convert between 44100 to 48000 in
> > software in order to get games like doom3 to play well.
> > doom3 also opens the buffers at 1024 frames per period, and 4096 frames
> > per buffer. It then writes 1024 frames at a time to the buffer. If the
> > complete write fails, it complains and the sound sounds really bad.
> > This approach is fine in the sound card can do periods of 1024 frames,
> > but not all sound card hardware can, so we need to find an abstraction
> > layer in order to deliver these period and buffer sizes to the
> > application, while also serving the different period and buffer sizes o=
f
> > the hardware.
> >
> > So, how about this.
> > The application can select any buffer size and period size they like.
> > For simplicity, we might impose that number_of_periods is an integer.
> >
> > So, the 44100 application buffer is 4096(buffer size),1024(period size)
> > The hardware 48000 buffer is 2048(buffer size), 512(period size)
> >
> > We add an intermediate buffer at 48000. This buffer size must be >=3D
> > 4096*48000/44100. period size must be >=3D 1024*48000/44100.
> > If we round up, we get:
> > intermediate buffer: 4458.23 -> 4459
> > intermediate period: 1114.56 -> 1115
> >
> > For ease of transfer between the intermediate buffer and the hardware,
> > we should really make the intermediate buffer_size =3D n*hardware perio=
d_size.
> > So, we have the following equations to satify:
> > intermediate_buffer_size =3D n * hardware_period_size.
> > intermediate_buffer_size >=3D
> > application_buffer*hardware_rate/application_rate.
> > intermediate_period_size =3D hardware_period_size.
> >
> > This results in the:
> > intermediate_buffer_size =3D 4608 (9 * 512)
> > intermediate_period_size =3D 512
>=20
> The sub-period is a good idea.  However, this seems possible only when
> you can change the period size of the slave PCM arbitrarily.  A
> typical bad example is dmix, which has the fixed period/buffer
> configuration.
Which is the slave, and which is the master?=20
master =3D=3D hardware buffer, slave =3D=3D application buffer
or
master =3D=3D application buffer, slave =3D=3D hardware buffer.

The current method used in alsa-lib is to try to map the applications
period directly onto the hardware period while changing sample rate at
the same time. I am suggesting adding a new buffer in between the two,
so that the application period writes into the intermediate buffer one
application period at a time, and the intermediate buffer writes into
the hardware buffer one hardware period at a time. So, there are 3
buffers here.
1) hardware buffer at 48000Hz.
2) intermediate buffer at 48000Hz.
3) Application buffer at 44100Hz.
The application buffer free runs and uses timer interrupts to trigger perio=
ds.
The application buffer has it's own pointer so can tell the
application the status of the buffer.
Each time the application writes to the application buffer, it fills
the application buffer and updates the application hw pointers. It
also runs the snd_pcm_write() through a sample rate converter, that
results in a varying amount of frames written to the intermediate
buffer.
The hardware buffer free runs and transfers data from the intermediate
buffer each time the hardware period ellapses.

So, the application sees a constant period size, the hardware also
sees a constant period size (but different from the application one).
The intermediate buffer is used to buffer between the two.

>=20
> Also, rounding up/down the fraction always introduces the round
> error.  This may cause a drift in a long run.
The size of the intermediate buffer does not matter. It just has to be
bigger than the application wants. The resampler in the
snd_pcm_write() function will be using fractions, so the rounding of
the buffer size is not a problem as there is no requirement to map one
application period directly into one intermediate period.

>=20
> > Each time the sound card hardware interrupts (every 512 frames), alsa
> > copies the next period from the intermediate buffer to the hardware
> > buffer. This essentually allows for any sound card hardware to have as
> > many periods as they wish, and thus as larger buffer size as they like.
> > With the expense of one extra memcpy.
> >
> > Each time the application writes to the application buffer, alsa-lib
> > sample rate converts the number of frames in the snd_pcm_write()
> > operation, and also writes those to the intermediate buffer.
> >
> > Add to that some careful handling of position and avail pointers in eac=
h
> > of the buffers. This should result in reliable sample rate/buffer size
> > converted audio.
> >
> > The next thing to consider is whether some applications can get sound t=
o
> > the pcm buffer without using snd_pcm_write(). For example memcpy for
> > mmap applications. We would need some way to track these memcpy writes,
> > so that the sample rate converter could take the new samples, and sampl=
e
> > rate convert them into the intermediate buffer.
>=20
> Well, even snd_pcm_read/write() are done in the mmap mode in rate
> plugin...
Good.

>=20
>=20
> The root of the problems of rate plugin is that we have no proper
> interrupts for the given period configuration for the master PCM.
> Using the irqs of the slave PCM may have restrictions that can't be
> solved easily as mentioned above.  Hence, I feel there are only two
> solutions for this:
>=20
> 1. Allow variable period size
> 2. Introduce another interrupt source
>=20
> 1 will be a drastic change to the outside, so it's not an option right
> now although it can be a good extension in future.
I also think that this probably causes more problems than it helps
with, even though I actually suggested it some time ago.

>=20
> 2 means to extend the kernel side PCM handler to allow artibrary
> interrupt source(s).  For example, suppose to create a new timer
> instance driven by the system timer.  Then you can set any "tick"
> value for the certain timing.
Some sound cards, like the Audigy and ca0106 have "wall clocks" that
we can generate interrupts from, if we wish. This would be a good way
to get interrupts arriving in sync with the sound card hardware. So,
we would have 2 interrupts.
1) For period_elapsed() from the hardware buffer period interrupt.
(The current interrupt)
2) For period_elapsed() from the timer for the intermediate period
trigger. (From wall-clock, but I am not sure how many sound cards have
that feature.

>=20
> The timer can be sync'ed with PCM DMA, too.  That is, we adjust the
> internal tick resolution at each time PCM DMA irq is issued (a la
> PLL).
Good method if the sound card hardware does not support "wall clock"

>=20
> Also, for a better PCM emulation, we may introduce a new timer mode
> for tick scheduling.  The timer instance has a queue of each wake-up
> duration.  The user-space writes to the queue and reads in return.
> The size of queue corresponds to the number of periods of PCM buffer,
> and each queue value corresponds to the period size.  You can set
> different values to adjust the rounding error.
>=20
>=20
> It's just my $0.02.
>=20
> Takashi
>=20
James


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
