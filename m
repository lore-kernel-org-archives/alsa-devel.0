From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB headset problem
Date: Fri, 14 Oct 2005 10:07:30 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510141004300.13918-100000@studcom.urz.uni-halle.de>
References: <20051014054335.GA29438@pulsussoft.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051014054335.GA29438@pulsussoft.hu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Szekeres Istv=E1n wrote:
> I've just bought a "Gembird EHS-USB" headset (this is with a microphone=
).
> Audio playback is OK, but recording is not. Applications do not find th=
e
> "capture channel".

Does something show up in the output of "arecord -l"?

> E.g. alsamixer shows only the PCM channel, but when I try to
> switch to "capture view", it quits with:
>
> alsamixer: function snd_mixer_find_selem() failed: Invalid argument

Your device does not have any capture mixer elements.

Old versions of alsamixer had a bug that would cause it to crash like
above in this case.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
