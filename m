From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: USB headset problem
Date: Fri, 14 Oct 2005 09:00:27 +0100
Message-ID: <20051014080026.GA27930@palantir8>
References: <20051014054335.GA29438@pulsussoft.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2005 at 07:43:35AM +0200, Szekeres Istv=E1n wrote:
> Hi,
>=20
> This is the latest git kernel snapshot.
>=20
> I've just bought a "Gembird EHS-USB" headset (this is with a microphone=
).
> Audio playback is OK, but recording is not. Applications do not find th=
e
> "capture channel". E.g. alsamixer shows only the PCM channel, but when =
I try
> to switch to "capture view", it quits with:

In the dmesg output I could not see snd-usb-audio being loaded. Could you
check with lsmod if that module gets loaded, and modprobe it if it is not
loaded. Also, check if there is acapture device in /proc/asound/devices
for this "card".

> alsamixer: function snd_mixer_find_selem() failed: Invalid argument

Could you post the output of "amixer"?

Martin


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
