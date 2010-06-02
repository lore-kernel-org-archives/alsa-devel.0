From: Uros Bizjak <ubizjak@gmail.com>
Subject: Re: Trouble compiling alsa-driver-1.0.23 on Fedora 13
Date: Wed, 2 Jun 2010 19:35:56 +0200
Message-ID: <AANLkTimLhVpyHyhY6H-ZX3387h3zmNEJ1KdEbW1Mx91Z@mail.gmail.com>
References: <AANLkTikkHZto-FJv268ZnB_WI4kLoMXopSCgKFijfv8Q@mail.gmail.com>
	<4C055FEA.8000402@kiilerich.com>
	<AANLkTinfCJApFmaXHYFOIX179WVYBYo9fp3a_P97e0W9@mail.gmail.com>
	<s5hd3w9spvi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C9D81039C2
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 19:35:59 +0200 (CEST)
Received: by wyg36 with SMTP id 36so1073441wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 10:35:56 -0700 (PDT)
In-Reply-To: <s5hd3w9spvi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mads Kiilerich <mads@kiilerich.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 2, 2010 at 12:14 PM, Takashi Iwai <tiwai@suse.de> wrote:

>> >> Trying to compile alsa-driver-1.0.23 on Fedora 13, I got following
>> >> failure:
>> >>
>> >> gmake -C /lib/modules/2.6.33.5-112.fc13.x86_64/source
>> >> SUBDIRS=3D/home/uros/alsa-driver-1.0.23 =A0CPP=3D"gcc -E" CC=3D"gcc" =
modules
>> >> gmake[1]: Entering directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_=
64'
>> >> Makefile:535: /usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefil=
e:
>> >> No such file or directory
>> >> gmake[1]: *** No rule to make target
>> >> `/usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile'. =A0Stop.
>> >> gmake[1]: Leaving directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_6=
4'
>> >> gmake: *** [compile] Error 2
>> >>
>> >> I have installed required kernel-devel package.
>> >>
>> >> Am I missing something else to successfully compile alsa-kernel drive=
rs?
>> >>
>> >
>> > Uros, I don't think you are missing anything - it seems like there is =
a real
>> > problem with the Fedora kernels and the latest alsa drivers.
>> >
>> > alsa-compile.sh as described on
>> > http://www.alsa-project.org/main/index.php/Driver_Compilation used to =
work
>> > for me on Fedora 12 and check for all dependencies, but now I get the =
same
>> > error.
>> >
>> > The Makefile fails in line 535 because SRCARCH (and ARCH) is empty even
>> > though SUBARCH is correctly (on my machine) set to i386. I don't know =
why or
>> > how it usually works.
>>
>> Thanks!
>>
>> I have to note, that adding ARCH=3Dx86 to make command also doesn't fly.
>> Also, I have found [1], where the same problem is reported.
>>
>> So, I guess I'll just lean back and wait for things to get resolved...
>> =A0I can provide further information on request, though.
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D588350#c4
>
> Could you try the latest alsa-driver snapshot tarball below?
> =A0 =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-d=
river-snapshot.tar.gz

No, unfortunately, it fails in the same way:

gmake[1]: Leaving directory `/home/uros/src/alsa-driver'
gmake -C /lib/modules/2.6.33.5-112.fc13.x86_64/build
SUBDIRS=3D/home/uros/src/alsa-driver  CPP=3D"gcc -E" CC=3D"gcc" modules
gmake[1]: Entering directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
Makefile:535: /usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile:
No such file or directory
gmake[1]: *** No rule to make target
`/usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile'.  Stop.
gmake[1]: Leaving directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
gmake: *** [compile] Error 2

Thanks,
Uros.
