From: gte654n@mail.gatech.edu
Subject: snd_intel8x0 fails after ACPI sleep
Date: Thu, 11 Mar 2004 02:13:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078989194.4050118a9a0df@webmail.mail.gatech.edu>
References: <XFMail.20040310104621.pochini@shiny.it>  <1078928193.18054.247.camel@renegade> <404F62B1.30206@superbug.demon.co.uk> <1078982128.1838.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078982128.1838.72.camel@localhost>
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

I have a Fujitsu E7110 laptop with a builtin audio card.  This is what ls=
pci=20
reports...=20
=20
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio =
(rev=20
02)=20
        Subsystem: Citicorp TTI: Unknown device 1177=20
        Flags: bus master, medium devsel, latency 0, IRQ 11=20
        I/O ports at 1000 [size=3D256]=20
        I/O ports at 1880 [size=3D64]=20
=20
I am running 2.6.4-rc2 kernel, and I have been trying to get ACPI S3 (sus=
pend=20
to ram) to wake up correctly.  One of the problems that I am encountering=
 is=20
that with the sound modules loaded (I have always had success with=20
snd_intel8x0 on the same hardware) coming back from sleep freezes my lapt=
op=20
hard.  If I rmmod *all* the sound-related modules before going to sleep, =
the=20
laptop resumes without a hitch.  However, if I attempt to modprobe=20
snd_intel8x0 after resume, I get a hard freeze again.  I cannot recover a=
ny=20
debug output, because the end of /var/log/messages is garbled on reboot.=20
=20
I have looked on ALSA and ACPI mailing lists and have not been able to fi=
nd a=20
satisfactory answer to this.  It appears some people can reinsert the int=
el=20
driver after resume, and they get their audio back.  I have no such luck.=
  =20
=20
Could you please provide some tips on how I can help address this problem=
? =20
For instance, what other information about my setup should I post.  Is th=
ere=20
some documentation on audio power management under ACPI that I am overloo=
king? =20
=20
Thank you very much, =20
=20
Ilya=20
=20



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
