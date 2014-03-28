From: Mark Brown <broonie@kernel.org>
Subject: Re: tlv320aic32x4 Codec ADC and DAC must shutdown to
 alter clocks
Date: Fri, 28 Mar 2014 14:13:53 +0000
Message-ID: <20140328141353.GS30768@sirena.org.uk>
References: <53207878.2060107@topic.nl> <20140312233137.GB28112@sirena.org.uk>
 <532159A5.20200@topic.nl> <20140313140410.GV366@sirena.org.uk>
 <5322D046.9090400@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3421649901735338263=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1BB4265584
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 11:46:52 +0100 (CET)
In-Reply-To: <5322D046.9090400@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3421649901735338263==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1jMvVksOaqpmjJm"
Content-Disposition: inline


--L1jMvVksOaqpmjJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 10:47:50AM +0100, Mike Looijmans wrote:

Don't drop CCs on kernel lists if you want people to read replies - the
bit about always CCing maintainers applies too...

> >*Any* glitch in an active digital audio path will be noticable to users,

> The reconfiguration only occurs when switching from say 44100 to 48000
> sampling rates (but not when going from 24 to 16 bits, for example). I don't
> think users will actually expect a switch from one sampling rate to another
> to proceed without any glitch or delay.

This has a wider effect than just the digital playback path though
doesn't it - the capture path for example, and if this is a modern
device there's doubtless charge pumps in play.

> >If you're taking several minutes to do a bias level transition there's
> >something seriously wrong with either the hardware or with the way it's
> >being managed by the driver.

> Good enough for human ears, but this project uses codecs for measurement and
> is sensitive to microvolt changes in reference voltages and such. The
> audible effects are gone in less than a second, but the measurable effects
> last a lot longer.

Less than a second still sounds like an awfully long time here and if
you've got constraints like this it sounds like you need to force the
device to be always running anyway.  Glancing at the code we're only
managing clocks in the bias level operations...

> >The general solution here is essentially don't do that; if the hardware
> >is fragile on reconfiguration you will tend to end up hitting cases
> >where trying to do a reconfiguration will glitch or fail so the sound
> >server will generally fix the configuration and handle things in
> >software.  Otherwise pmdown_time is the general solution for modern
> >devices with quick startup/shutdown times, older devices probably need
> >some custom hacks.

> It's not about "fragile", it's about managing codec power states. For some
> transistions, like clock changes, a codec will likely need to go to a lower

It certainly sounds a lot like it's fragile - there seem to be fairly
tight constraints on reconfiguring, you're saying it's hard to implement
something that bounces the power around reconfiguration, the device
requires symmetric rates so it won't cope if there's capture activity
too and who knows what happens with the analogue bypass paths.

Equally well you've not been specific about anything so it's possible
that the restrictions and/or what needs doing are looser than you're
making them sound; looking at the code I'm not seeing anything except
clocks being managed as part of the bias level management and there's no
effort to selectively manage the clocks.

> state. The current core does not even attempt to mute the DAC for example.

Yes it does - you can only reconfigure the sample rate for the audio
stream when it's not running and we mute (if the device supports it)
whenever the audio stream is halted.

--L1jMvVksOaqpmjJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNYOeAAoJELSic+t+oim9OZcP/1oHh1RqeZCmDp4dnTZ1lm/K
b7l4zMth664Cm3jlxxElh0x0Llqm95CcbrjiWh5zFmtoN575+uHmhXuOe2wm2eQ1
BQowsCoH3k8Gvag/cDJJMgM3wLrWqhB98K3TAbi1e6GJP7UTDop4NGUXZQM1SpW4
/5iIOSQeo/SZN0ldocaf0/bWXjzXGjKB/srhjyJIgJWjIaKvlO6E1CTJv9dpJ9Qy
jgpxReV+tDImMv7gplkNYVLzM8LSg1le3knILfvtAVE9LZTZT6T9+N+K2As3Uk7J
6KmiPVQRECMBEILnlbSvBUV4LwBh9VQBv56dn7nwCwBETWHBVQXaoTOpc2TNG5g2
X0UufoamqCWFGsiV78LMzs7J+E2UrNRK+exD6s7kbLjUqRIr3/tcdE3YSi2iUcea
QHNmjbY/CayJ9GdNIP/dbecfs3/df+MyF1ei/mDiB0E3hsr1Kqpn25IwyGNjUMhJ
o9q0eEy60oPPTcKSrg/MMVxl8r6ujZR30m2etRUjlBjfBzTv/bO2dX0NkVfN3+Gn
7wDcJWREPmYEri+LiQ2WJRh93+N0lqwnSBteODhbtwBWIxtKcwI9Z8gTtUJRhSIJ
/NKLH48pqTqKzkDLZv9qpCU7yzBcKVBYvRkashtxeJ9hBWwWbXi3XKXJVU/hXmHX
Pk1e5Tqs/oQOqhHjnyhI
=foVC
-----END PGP SIGNATURE-----

--L1jMvVksOaqpmjJm--

--===============3421649901735338263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3421649901735338263==--
