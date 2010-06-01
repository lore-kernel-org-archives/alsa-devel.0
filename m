From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: Trouble compiling alsa-driver-1.0.23 on Fedora 13
Date: Tue, 01 Jun 2010 21:30:50 +0200
Message-ID: <4C055FEA.8000402@kiilerich.com>
References: <AANLkTikkHZto-FJv268ZnB_WI4kLoMXopSCgKFijfv8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com
	[209.85.219.218])
	by alsa0.perex.cz (Postfix) with ESMTP id C2ACB243FE
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 21:30:55 +0200 (CEST)
Received: by ewy10 with SMTP id 10so1492270ewy.22
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 12:30:53 -0700 (PDT)
In-Reply-To: <AANLkTikkHZto-FJv268ZnB_WI4kLoMXopSCgKFijfv8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uros Bizjak <ubizjak@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Uros Bizjak wrote, On 06/01/2010 06:47 PM:
> Hello!
>
> Trying to compile alsa-driver-1.0.23 on Fedora 13, I got following failure:
>
> gmake -C /lib/modules/2.6.33.5-112.fc13.x86_64/source
> SUBDIRS=/home/uros/alsa-driver-1.0.23  CPP="gcc -E" CC="gcc" modules
> gmake[1]: Entering directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
> Makefile:535: /usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile:
> No such file or directory
> gmake[1]: *** No rule to make target
> `/usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile'.  Stop.
> gmake[1]: Leaving directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
> gmake: *** [compile] Error 2
>
> I have installed required kernel-devel package.
>
> Am I missing something else to successfully compile alsa-kernel drivers?
>    

Uros, I don't think you are missing anything - it seems like there is a 
real problem with the Fedora kernels and the latest alsa drivers.

alsa-compile.sh as described on 
http://www.alsa-project.org/main/index.php/Driver_Compilation used to 
work for me on Fedora 12 and check for all dependencies, but now I get 
the same error.

The Makefile fails in line 535 because SRCARCH (and ARCH) is empty even 
though SUBARCH is correctly (on my machine) set to i386. I don't know 
why or how it usually works.

/Masd
