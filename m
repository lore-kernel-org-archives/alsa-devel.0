From: "Marc Titinger" <titinger@digigram.com>
Subject: RE: dmix plugin
Date: Wed, 12 Feb 2003 19:04:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <08F1D234AF91E540BC1F43889E2A6AA70AEBFD@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from digiexch.digigram.com (mail.digigram.com [213.30.172.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA09898
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 19:03:54 +0100
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

This looks Great !

I haven't yet experimented a lot with .asoundrc files, so please excuse =
me if the following questions are irrelevant or OTO, but:

I was wondering if one could define a plug pcm, that offers two stereo =
pairs routed with policy "average" to a single-stereo "hw" slave.

My understanding is that until this dmix pcm, there was no "official" =
means supported by alsalib to achieve software mix of streams comming =
from differents apps.

Could I have one app open the first pair of my hypothetic plug pcm, and =
another app open the second pair ?
I guess this would be managed like a concurrent access to a pcm, and =
block or fail the second open() call.=20

Would'nt it be nice to create a dmix pcm "behind"  a such plug pcm, to =
provide mix in a transparent way ?

thanks for your light over this=20
Marc.



> -----Original Message-----
> From: Jaroslav Kysela [mailto:perex@suse.cz]
> Sent: mercredi 12 f=E9vrier 2003 10:46
> To: ALSA development
> Subject: [Alsa-devel] dmix plugin
>=20
>=20
> Hi all,
>=20
> 	a next step to get the lowlatency sharing of exclusive=20
> PCM devices=20
> is in ALSA CVS - the dmix (direct mixing) plugin..
> 	How it works? Basically, the playback in driver runs forewer
> without any xrun detection. The ring buffer (only just played=20
> areas) is
> also silenced in each interrupt. Then we have multiple clients and a
> process (server) which passes the file descriptor of playback=20
> devices to
> them. The server also takes care about freeing of used shm memory and
> semaphore.
> 	The big step forward is that we share one mmaped ring buffer
> accross many processes and each process can add samples into=20
> it without
> any process<->kernel swaps. Also, each processes are independant, thus
> failing of one doesn't break others. It's not multithreaded,=20
> we don't need
> this mechanism.
>=20
> Here is an .asoundrc example configuration (plugin defaults=20
> are 48kHz,=20
> stereo, signed 16-bit little endian):
>=20
> pcm.dmix {
> 	type dmix
> 	ipc_key 1234	# must be unique for all dmix plugins!!!!
> 	slave {
> 		pcm "hw:0,0"
> 	}
> }
>=20
> 	Then try: 'aplay -Dplug:dmix <filename>' on multiple consoles.
>=20
> 	Note that it's still alpha code and there are some not correctly
> implemented functions (like drain, rewind and more). Note=20
> that you'll need
> also the latest ALSA driver from CVS, because the silence settings was
> enhanced a bit and bug in the timer code will crash your machine.
>=20
> 					Enjoy it!
> 						Jaroslav
>=20
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
