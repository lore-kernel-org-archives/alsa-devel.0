From: Harish Kumar <harishkumarb7@gmail.com>
Subject: Re: alsa-utils cross compilation error
Date: Tue, 6 Oct 2009 20:39:42 +0530
Message-ID: <7df11cd50910060809w7b015cf8p1089e3000f8384a8@mail.gmail.com>
References: <7df11cd50910060719t66c353b0jc865f04e09f49c12@mail.gmail.com>
	<alpine.LNX.2.00.0910061620410.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199])
	by alsa0.perex.cz (Postfix) with ESMTP id EC694243D1
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:09:43 +0200 (CEST)
Received: by ywh37 with SMTP id 37so3930368ywh.17
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 08:09:42 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910061620410.31529@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I compiled the alsa libs using the following

CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-linux
--prefix=/root/arm-alsa/
make
make install

changed the directory to alsa-utils and executed the following
1.
CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-linux
--with-alsa-prefix=/root/arm-alsa
--with-alsa-inc-prefix=/root/arm-alsa
the configured failed with the same error
checking for ALSA CFLAGS...  -I/root/arm-alsa
checking for ALSA LDFLAGS...  -L/root/arm-alsa -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.9... not present.
configure: error: Sufficiently new version of libasound not found.


2.CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-linux
--with-alsa-prefix=/root/arm-alsa
--with-alsa-inc-prefix=/root/arm-alsa/include
he configured failed with the same error

checking for ALSA CFLAGS...  -I/root/arm-alsa/include
checking for ALSA LDFLAGS...  -L/root/arm-alsa -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.9... found.
checking for snd_ctl_open in -lasound... no
configure: error: No linkable libasound was found.

3.CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-linux
--with-alsa-prefix=/root/arm-alsa/lib
--with-alsa-inc-prefix=/root/arm-alsa/include

it worked partially as it is not able to find libcurses and ncurses. I
copied the required libraries and include file to the respective
directories and it started configuring and compiling without any
issue.

Thank you very much for help. I tried the above option but somehow
didn't work at that time and also my brain might have stalled during
the process.

Any way i still need to compile for PPC which should work with the
same proceure.

Thanks and Regards
Harish Kumar.B





On 10/6/09, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 6 Oct 2009, Harish Kumar wrote:
>
>> Hi,
>>
>> I am trying to cross compile the alsa utils for PPC and as well as arm
>> architecture. the compilation of alsa-libs was successful with their
>> respective toolchains. But configuring the alsa-util is failing. I am
>> using alsa-utils-1.0.11rc2,alsa-lib-1.0.11rc2.  I am getting the error
>> checking for libasound headers version >= 1.0.9... not present.
>> configure: error: Sufficiently new version of libasound not found. I
>> feel i have to provide the path of the include files but not sure
>> which path to be passed and how it needs to be passed to configure.
>
> # ./configure --help | grep alsa | grep prefix
>    --with-alsa-prefix=PFX  Prefix where Alsa library is installed(optional)
>    --with-alsa-inc-prefix=PFX  Prefix where include libraries are (optional)
>
>  					Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>
