From: "Marc Titinger" <titinger@digigram.com>
Subject: RE: dmix plugin
Date: Thu, 13 Feb 2003 11:28:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA70AEBFE@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from digiexch.digigram.com (mail.digigram.com [213.30.172.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA25940
	for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2003 11:27:40 +0100
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> well, route (or plug) has the capability for software mix (in a
> certain meaning), but not for separate pcm streams.  you can downmix
> the multi-channels in a stream via route plugin if the channels is
> given.
>=20
> but it's defenitely different from what dmix plugin does, and perhaps
> it's different from what Marc wants, too...

You got my point : route may looks like soft mix, but actually is =
downmix with the possibility of setting gains. I guess gains are what =
makes sense using the asoundrc configuration instead of leaving the =
downmix to the plughw (I assume plughw would downmix a stereo stream to =
a mono hw pcm, even if nothing is asoundrc-configured).
=20
=20
> > Some cards with multiple open hardware acceleration doesn't=20
> need this=20
> > default. Also, the dmix plugin has some limited things so I=20
> don't prefer=20
> > to select it as default.
>=20
> agreed here, although i feel it's also nice to set it as default for a
> consumer card which has no hardware mix function.
>=20
> please note that you can re-define the default in asoundrc.
> if you want to set up dmix as the system default, you can define it in
> /etc/asound.conf, too.
>
=20
This makes me enthousiastic about those configuration files : it's a =
pity that no GUI is yet available to help design complex files ; =
consider the fact that some hardware manufacturers spend time on =
developping pricy console enabled hardware, console interfaces and SDK.
A good GUI for asoundrc wouldn't be far from a console interface, =
especially if some settings can be automated via the sequencer : imagine =
a gain (or any parameter) could be dependent of a MIDI code !






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
