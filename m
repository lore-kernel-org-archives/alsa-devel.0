From: Mark Brown <broonie@kernel.org>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Tue, 23 Jul 2013 19:30:38 +0100
Message-ID: <20130723183038.GO9858@sirena.org.uk>
References: <51EE3F18.3030207@gmail.com> <20130723123017.GV9858@sirena.org.uk>
 <51EEA2A3.8030106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7542934178596974798=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AC978265177
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 20:30:44 +0200 (CEST)
In-Reply-To: <51EEA2A3.8030106@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7542934178596974798==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yEm4/lbnJMR0xRk"
Content-Disposition: inline


--6yEm4/lbnJMR0xRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 05:34:59PM +0200, Daniel Mack wrote:
> On 23.07.2013 14:30, Mark Brown wrote:

> > Could you go into more detail about the ambiguity you see here?

> I have a platform which has two codecs (cs4271, ak4101) connected to one
> McASP instance. For DPCM, the link structure looks like this:

>   mcasp <-> snd-soc-dummy, .dynamic = 1
>   mcasp <-> cs4271, .no_pcm = 1
>   mcasp <-> ak4101, .no_pcm = 1

> With printk() in snd_soc_dapm_new_control(), I see the following widgets
> being created during boot (one pair for each Codec, and two pairs for
> the platform dai):

OK, so the issue here is probably that you're overloading the single
McASP object rather than anything else - that's always been a bit of a
hack and I suspect it's going to be causing issues again now.  In which
case we probably do need to bite the bullet on making multi-drop DAIs
work.  But let's see...

> And the widgets referenced by the audio map will hence have to be named
> "Playback" or "Capture" as well, which has no chance to refer to the
> correct one, right?

Lookups are done first in the local DAPM context so so long as the thing
that's setting up the links is doing so in the same context everything
should be OK.  This is needed so you can have two of the same device in
a system.

> > This is obviously required, yes - just as with everything else you
> > shouldn't use the same name twice.

> Yeah, but snd_soc_dapm_new_dai_widgets() relies on
> dai->driver->playback.stream_name and takes that as widget name. So is
> this approach faulty, and the automatically generated name would need to
> be based on dev_name(dai->dev)? Or do we need to clean up all drivers in
> order to make their streams unique? Then again, the question is how to
> deal with multiple instances of the same dai driver, and how to tell
> them apart in the audio map.

The prefix mechanism is intended to address this; however it's only
currently supported for CODECs.  If we move the prefixes to components
then they should be usable for CPU DAIs.

> > The theory here is that the CPUs should be converted into components and
> > then have the DAIs instantiated at component probe time - the creation
> > at link time is there as a crutch for older drivers.

> Which older driver would rely on that, and can we safely remove it?

Probably none right now.

--6yEm4/lbnJMR0xRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7svLAAoJELSic+t+oim95dEP/0aWO+ioEc1byKl3i120e+Ku
lUIv+hqzrNcdgkx2P46CeaY53NIk0x33Yy7Gg9YBu3iTFUh2swDX8yThjBJMFbBu
NrNYjQOpLmoSfCoSwJBjrrpfLf7uUP0zwYsvblq6pKN9oM9loqKd70wJDdjAFoEm
H4YnURZ7G7r3xfS8T9Ni0F4AkxWy4on7bGTCCq+jkiklroWk7M0onw7Qlq2ln1ED
Vr9adpPbUCfzcSS4t49QKkSFkrZcBljKzm0APIQ3EGDQ/RLAJ1OEgsTDpM6hkPGL
smRKgYN3QaUiZH5h06n8dIvlMQjoSeRTqNNQoQjGZyURrvU9ykAMzdj9TCq4fGDC
6nGclELwo6sZuwqAkXMvnUBaAVNC7aojNVirWuWqF1ZZ5d/rCKMjKxNkCAUaApgM
2BdCqD6FUp3z3x+78G5D5BShdNw9CLhHoV62gsJNpVbU2SMEGCjN7ULacZi3F3Jr
yWdTSHGlrvWnK4WhRjXYhLhz6xdWgpEHHZ54enffGAoXiwjJVYAT9j7cU4hP6M19
C3TjoWOlw0OH59jQycCspDe9gC6LnvzsIDv/24gL/M4rEvi4PjpdLmHyyDwJnIDr
N4Q4m3jDK7+wa39HlFJM4MKc3382q7+LFbKbtPYSWM4PMu2AkRhbgkiYmVFGeaic
wfiqT2Q23SrenY4jfSHY
=/BDu
-----END PGP SIGNATURE-----

--6yEm4/lbnJMR0xRk--

--===============7542934178596974798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7542934178596974798==--
