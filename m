From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Subject: design suggestions for minimal-latency full-duplex io?
Date: Mon, 3 Feb 2003 16:48:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302031648.48890.Marcus.Blomenkamp@epost.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there.

What is the best way to achieve minimal transport latency in an application=
=20
constanty capturing data from one interface and playing it through another.=
=20
The purpose of this app would be some kind of software loop-through=20
converter. My problem domain is that I have my PC connected to an amplifier=
=20
through SPDIF while the TV-card is connected to the soundcard only through=
=20
analog wires. However my sound chip CMI8738 does not suppport hardware=20
realtime monitoring from analog input to digital output. So my suggestion w=
as=20
to concurrenly read data from the ADC input and write it to SPDIF output.

I initially wrote this as an OSS app but i'm slightly dissappointed about t=
he=20
minimal IO latency I could reach with the common iterative read/write=20
mechanism. So I decided to try the ALSA way to reduce the throughput delay.

Is it possible to have both stream pointers working on the same physical=20
buffer? A slightly delayed start of playback should then give a nice IO=20
latency. Are there any other approaches viable? Ideally i'd like to get thi=
s=20
working while not depending on userspace scheduling heavily.

Any suggestions/constraints about the following ideas?
1. traditional blocking read/write in seperate threads
2. traditional non-blocking read/write in a single thread
3. asynchronous SIG_IO triggered read/write handling
4. mmap'ed buffer for read+write

Especially for the last candidate i'd appreciate any kind of pseudo-code si=
nce=20
i'm not yet quite familiar with ALSA and MMAP audio IO.

Regards, Marcus



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
