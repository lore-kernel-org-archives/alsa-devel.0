From: Marcos Guglielmetti <marcospcmusica-/E1597aS9LQMlKAeRRkD2Q@public.gmane.org>
Subject: Re: Newer kernels: SB Live! line's capture alsa
	driver bug?
Date: Sat, 4 Mar 2006 02:10:56 +0100
Message-ID: <200603040210.56989.marcospcmusica@yahoo.com.ar>
References: <200603032227.35375.marcospcmusica@yahoo.com.ar>
	<1141445231.3042.169.camel@mindpipe>
Reply-To: marcospcmusica-/E1597aS9LQMlKAeRRkD2Q@public.gmane.org,
	A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <1141445231.3042.169.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: users-Fs2WGB8Lkt/J3YwKTeWLYQ@public.gmane.org, A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

El S=E1bado, 4 de Marzo de 2006 05:07, Lee Revell escribi=F3:
> On Fri, 2006-03-03 at 22:27 +0100, Marcos Guglielmetti wrote:
> > Alsa version:
> >
> > apt-cache policy alsa-base
>
> It's libasound2 not alsa-base that must match the version in the
> kernel.
>
> apt-cache policy libasound2
>

Thanks... so, I'm reporting again... with some extra info from a google=20
search too:



=2D----------

With these kernel and alsa versions: The SB live! line's capture works=20
fine
(it captures from both left and right channels)

Linux 2.6.11-1-386 #1 Mon Apr 25 01:18:07 UTC 2005 i686 GNU/Linux

Alsa version:

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.9b-4

apt-cache policy libasound2
libasound2:
  Installed: 1.0.9-3



=2D-----------------------------------------------------

Using these kernel and alsa versions: The SB live! line's capture works=20
bad:
(it captures only from the line's left channel)

Linux 2.6.14-1-multimedia-386 #1 PREEMPT Sat Dec 10 16:52:12 CET 2005=20
i686 GNU/Linux

Also with 2.6.13-1-multimedia-386 from aGNUla /DeMuDi

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.10-1

apt-cache policy libasound2
libasound2:
  Instalados: 1.0.10-1

=2D------------------------------------------------------
Here it fails too:

uname -a
Linux 030users 2.6.15.4-rt #1 PREEMPT Fri Feb 17 18:55:02 EET 2006 i686=20
GNU/Linux

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.9b-4

apt-cache policy libasound2
libasound2:
  Installed: 1.0.10-2



=2D-------------------------------

	Someone knows what is happening with this odd problem?

=2D----


New Info from:

https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/24951

"
Problem: Selection an audio input source and selecting the input monitor=20
option gives random results. After clicking some input and output=20
settings in the mixer, I sometimes can record from a source, but often=20
some other sound is mixed
with it. So recording cannot be used.
With the alsamixergui the settings can be set a little more specific,=20
but the same problems occur.
The output does work for sounds created by programs, but selecting=20
line-in or mic causes problems again.

My soundcard is a "Creative SoundBlaster Live 1024" (SBLive), which is a=20
CT4830 (identical to CT4832). The EMU10K1 driver is used, and either=20
selecting ALSA or OSS has the same problems.

This problem exists for some time, with all kernels and with previous=20
Ubuntu versions.
Ubuntu: 5.10
Kernel: K7



Re: Soundcard CT4832 (SB Live) has wrong input/output selections Posted=20
by jdo at 2005-12-21 14:38:49 UTC

Added info:
This problem seems to be with all Debian-based distribution.
The best way to test this, is to adjust the input gain and the selection=20
of input channel, this has influence on the output (e.g. playing a=20
MP3). The FreeSBIE and dynebolic LiveCDs do work with the CT4830/CT4832=20
soundcard.


Re: Soundcard CT4832 (SB Live) has wrong input/output selections Posted=20
by Ben Collins at 2005-12-21 16:14:57 UTC

If possible, please upgrade to Dapper's 2.6.15-9 kernel. If you do not=20
want to upgrade to Dapper, then you can also try the Dapper Flight 2=20
CD's: http://cdimage.ubuntulinux.org/releases/dapper/flight-2/

Let me know if this bug still exists with this kernel.

 Re: Soundcard CT4832 (SB Live) has wrong input/output selections =20
Posted by jdo  at 2005-12-21 18:18:04 UTC

I have tested the dapper flight-2 LiveCD, and the problem still exist
"



=2D-=20
Marcos Guglielmetti =20
Coordinador del desarrollo de Musix GNU+Linux=20
(www.musix.org.ar)=20
Mirrors: (www.musix.distrux.net) (www.pc-musica.com.ar/musix)=20
(www.k-maleon.com/musix)

	
	
		
___________________________________________________________ 
1GB gratis, Antivirus y Antispam 
Correo Yahoo!, el mejor correo web del mundo 
http://correo.yahoo.com.ar 
