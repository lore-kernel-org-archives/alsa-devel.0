From: Uros Bizjak <ubizjak@gmail.com>
Subject: Re: Trouble compiling alsa-driver-1.0.23 on Fedora 13
Date: Wed, 2 Jun 2010 10:22:39 +0200
Message-ID: <AANLkTinfCJApFmaXHYFOIX179WVYBYo9fp3a_P97e0W9@mail.gmail.com>
References: <AANLkTikkHZto-FJv268ZnB_WI4kLoMXopSCgKFijfv8Q@mail.gmail.com>
	<4C055FEA.8000402@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2029D245A3
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 10:22:45 +0200 (CEST)
Received: by wyg36 with SMTP id 36so653996wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 01:22:44 -0700 (PDT)
In-Reply-To: <4C055FEA.8000402@kiilerich.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mads Kiilerich <mads@kiilerich.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 1, 2010 at 9:30 PM, Mads Kiilerich <mads@kiilerich.com> wrote:

>> Trying to compile alsa-driver-1.0.23 on Fedora 13, I got following
>> failure:
>>
>> gmake -C /lib/modules/2.6.33.5-112.fc13.x86_64/source
>> SUBDIRS=3D/home/uros/alsa-driver-1.0.23 =A0CPP=3D"gcc -E" CC=3D"gcc" mod=
ules
>> gmake[1]: Entering directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
>> Makefile:535: /usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile:
>> No such file or directory
>> gmake[1]: *** No rule to make target
>> `/usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile'. =A0Stop.
>> gmake[1]: Leaving directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
>> gmake: *** [compile] Error 2
>>
>> I have installed required kernel-devel package.
>>
>> Am I missing something else to successfully compile alsa-kernel drivers?
>>
>
> Uros, I don't think you are missing anything - it seems like there is a r=
eal
> problem with the Fedora kernels and the latest alsa drivers.
>
> alsa-compile.sh as described on
> http://www.alsa-project.org/main/index.php/Driver_Compilation used to work
> for me on Fedora 12 and check for all dependencies, but now I get the same
> error.
>
> The Makefile fails in line 535 because SRCARCH (and ARCH) is empty even
> though SUBARCH is correctly (on my machine) set to i386. I don't know why=
 or
> how it usually works.

Thanks!

I have to note, that adding ARCH=3Dx86 to make command also doesn't fly.
Also, I have found [1], where the same problem is reported.

So, I guess I'll just lean back and wait for things to get resolved...
 I can provide further information on request, though.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D588350#c4

Uros.
