From: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Subject: Re: USB headset problem
Date: Fri, 14 Oct 2005 11:17:16 +0200
Message-ID: <20051014091716.GA30524@pulsussoft.hu>
References: <20051014054335.GA29438@pulsussoft.hu> <Pine.HPX.4.33n.0510141004300.13918-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0510141004300.13918-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Oct 14, 2005 at 10:07:30AM +0200, Clemens Ladisch wrote:
> Szekeres Istv=E1n wrote:
> > I've just bought a "Gembird EHS-USB" headset (this is with a micropho=
ne).
> > Audio playback is OK, but recording is not. Applications do not find =
the
> > "capture channel".
>=20
> Does something show up in the output of "arecord -l"?

card 1: default [USB Audio CODEC ], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

>=20
> > E.g. alsamixer shows only the PCM channel, but when I try to
> > switch to "capture view", it quits with:
> >
> > alsamixer: function snd_mixer_find_selem() failed: Invalid argument
>=20
> Your device does not have any capture mixer elements.
>=20
> Old versions of alsamixer had a bug that would cause it to crash like
> above in this case.

This is AlsaMixer v1.0.9a.

Now I'm a bit confused. Do I have a problem at all? :)
If arecord seems to find it, but there is no mixer
for it, does this mean that the microphone is visible for alsa but no
recording level can be set for it?=20
Afternoon at home I have to experiment with it a little more..

Thanks,
Szekeres Istvan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
