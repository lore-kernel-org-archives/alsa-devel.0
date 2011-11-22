From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Recent Alsa, 100% CPU with mixer
Date: Tue, 22 Nov 2011 17:07:46 +0000
Message-ID: <201111221707.47084.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net
	[62.24.128.237])
	by alsa0.perex.cz (Postfix) with ESMTP id F3765103A5B
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 18:02:23 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

It's evidently been too long since I built and tested a recent Alsa on =

machines here.  Having got 1.0.24 to load I am seeing a number of issues, =

which I am trying to separate, with some difficulty.  Thus I have also buil=
t =

several previous versions for comparison.

Alsa-1.0.20 seems to be fine as far as I have been able to test.

Alsa-1.0.22 is OK, running ice1712 and au8820 modules, except that the =

alsamixer ice1712 ADC and DAC controls will go down to a negative number an=
d =

then cannot be raised again.  Using envy24control the ranges just show as =

0-127 (eg DACs) and can raise them back up.  So there's a bug but it can be =

worked around to get working sound.

With 1.0.23 and 1.0.24 the driver also loads and works.  But running any =

version of alsamixer causes 100% CPU, although the mixer is itself able to =

function and shows the same bug as 1.0.22.  There are no console messages.  =

And envy24control does not load properly, stalling before creating it's mix=
er =

window.  Thus it is not possible to raise the volumes and get any sound fro=
m =

the ice1712 card. The au8820 does function, in-spite of the 100%CPU, and th=
e =

volumes can be raised with alsamixer and sound played OK.  So it is possibl=
e =

that without the alsamixer levels bug the ice1712 would also play sound?

The 100% CPU behaviour is the most tricky to start with.  Can you give any =

suggestions to identify the cause?  This is the 2.4.21-99 kernel.

Running with strace, I was able to catch this output on the konsole, in cas=
e =

it indicates anything:-

select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
gettimeofday({1321980134, 190869}, NULL) =3D 0
rt_sigaction(SIGTSTP, {SIG_IGN}, {0x401768f0, [], SA_RESTORER|SA_RESTART, =

0x401e5aa8}, 8) =3D 0
select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
rt_sigaction(SIGTSTP,0x401768f0, [], SA_RESTORER|SA_RESTART, 0x401e5aa8}, =

NULL, 8) =3D 0
poll([{fd=3D0, events=3DPOLLIN}, {fd=3D3, events=3DPOLLIN|POLLERR|POLLNVAL, =

revents=3DPOLLIN}], 2, -1) =3D 1
read(3, 0xbffff130, 72) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -1 EAGAIN (Reso=
urce temporarily =

unavailable)
gettimeofday({1321980134, 192090}, NULL) =3D 0
select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
gettimeofday({1321980134, 192404}, NULL) =3D 0
rt_sigaction(SIGTSTP, {SIG_IGN}, {0x401768f0, [], SA_RESTORER|SA_RESTART, =

0x401e5aa8}, 8) =3D 0
select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
select(1, [0], NULL, NULL, {0, 0}) =A0 =A0 =A0=3D 0 (Timeout)
rt_sigaction(SIGTSTP, {0x401768f0, [], SA_RESTORER|SA_RESTART, 0x401e5aa8}, =

NULL, 8) =3D 0

Thanks,

Alan
