From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: ALSA-lib reports zero channels for devices
Date: Mon, 05 Jan 2004 15:10:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1a20fgaq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

I have a recurring problem with ALSA-lib that _seems_ linked to the 1.0=20
release candidates. With one certain application (I've written a=20
dynamically loaded PortAudio plugin for a mediaplayer), ALSA-lib will=20
report maximum zero capture and playback channels for both my devices=20
(nVidia nForce2 and RME DIGI9636). When running minimal PortAudio program=
s=20
capabilities are reported correctly. I've managed to fix this in the past=
=20
by reinstalling 0.9.8, but 1.0rc2 has worked for a while without problems=
.=20
Today the same thing happened though, consistently zero available channel=
s=20
would be reported, with this one app (using a PortAudio output plugin). S=
o=20
I reinstalled 0.9.8, and rebooted. The problem was still there the first=20
time I ran the app after reboot (with 0.9.8 installed) though, the second=
=20
time it was gone. Weird, huh?

I'm using the ALSA-driver version compiled into the 2.6.1-rc1-mm1 kernel,=
=20
which version is this, 1.0rc*? Could there be a version incompatibility=20
between driver and lib? I don't think there's anything special to the way=
=20
I open and query the card, I simply do a snd_pcm_open followed by a=20
snd_pcm_nonblock (the open mode could be nonblocking), followed by=20
snd_pcm_hw_params_any and then snd_pcm_hw_params_get_channels_max. Has=20
anyone experienced similar behaviour?

Thanks in advance

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
