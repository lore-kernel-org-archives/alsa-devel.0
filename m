From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: GUS Classic driver, PLUGHW problems
Date: Thu, 10 Jul 2003 00:17:33 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710001733.A13484@sci.fi>
References: <20030704091249.GA1692@catfish.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030704091249.GA1692@catfish.dhs.org>; from jlunder@catfish.dhs.org on Fri, Jul 04, 2003 at 02:12:49AM -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2003 at 02:12:49AM -0700, Joseph Lunderville wrote:
> I'm trying to get a 486 with a GUS Classic working through ALSA, and I'=
ve
> run into a couple of problems:
>=20
>=20
> 1. plughw doesn't know how to convert from interleaved data to
> noninterleaved data. in fact, as far as I can see, nothing at all excep=
t the
> GUS driver knows what to do with noninterleaved data.

I ran into this problem with my GUS PnP some time ago. You should be able
to find the discussion from alsa-devel archives.

Apparently the conversion works for some other non-interleaved cards
like RME Hammerfall. The GUS driver doesn't support mmap which may cause
problems but even using alsa-lib's mmap emulation didn't fix the problem
for me :(

> I imagine that the only
> reason this hasn't been fixed yet is that nobody wants to use a GUS wit=
h
> ALSA :)

I will resurrect my GUS PnP when (if?) MIDI emulation gets implemented...

> 2. the GUS driver seems to have a problem with outputting PCM data. I h=
ad to
> test it using my own code (since the example uses interleaved data), bu=
t I'm
> reasonably confident that the problem's in the driver.
>=20
> the problem I'm observing is that there are frequent clicks in the audi=
o
> output (coincidentally, they arrive at a frequency corresponding exactl=
y to
> the size of the ring buffer -- I've confirmed this by looking at the ou=
tput
> on an oscilloscope. the click looks like one or two samples are being
> skipped). this is when I use a buffer size that's a multiple of my peri=
od
> size -- when I use other combinations of buffer size and period size, t=
hings
> get worse. some combinations of buffer & period size cause I/O errors.
>=20
> 3. finally, the example doesn't start the audio output. it's difficult =
for
> me to tell whether you're supposed to call snd_pcm_start() in order to =
get
> output from the speakers (in which case the example is wrong), or wheth=
er
> the gus driver requires this when it's not supposed to, but either way
> something's not right.

I don't remember seeing this with my GUS PnP but then again I mostly used
the codec instead of the synth for PCM. Also GUS PnP doesn't have the
channel count vs. frequency limitation of the original GUS.

I have a GUS MAX buried somewhere but I don't think I've tried it with
ALSA.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
