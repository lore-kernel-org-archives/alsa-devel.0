From: =?ISO-8859-1?Q?H=E5vard_Kv=E5len?= <havardk@xmms.org>
Subject: Problem with snd_mixer_selem_set_playback_volume_range()
Date: Tue, 9 Dec 2003 01:16:04 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0312090049431.6730-100000@foo.kvaalen.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi, I'm having a problem with snd_mixer_selem_set_playback_volume_range()=
. =20
It works ok, except that the values I read back (with
snd_mixer_selem_get_playback_volume()) does not seem to be scaled with th=
e
new range until the volume is changed somehow.  Both changing the volume
by calling snd_mixer_selem_get_playback_volume() and using some external
program helps.

Am i supposed to do something more after calling=20
snd_mixer_selem_set_playback_volume_range() or is this a bug?

 - H=E5vard



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
