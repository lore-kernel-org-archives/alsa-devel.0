From: K <keres.nyx@gmail.com>
Subject: [Alsa-devel] Crosstool for PDA iPAQ hx4700
Date: Tue, 15 May 2007 16:33:53 +0200
Message-ID: <50fdad60705150733xf4b7624i3f9576b383104cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id A71442439B
	for <Alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 16:33:54 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so152135nzf
	for <Alsa-devel@alsa-project.org>; Tue, 15 May 2007 07:33:53 -0700 (PDT)
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
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I want to port a audio program on my hx4700, So I will use a prebuilt
toolchain. I have downloaded
ftp://ftp.handhelds.org/projects/toolchain/arm-linux-gcc-3.4.1.tar.bz2
and I extract this file to /usr/local/arm

I have downloaded alsa-lib from
ftp://ftp.alsa-project.org/pub/lib/stable/alsa-lib-0.0.9.tar.gz

I have compiled it :
#./configure --prefix=/usr/local/arm-linux --host=arm-linux
#make
#make install

after I compile my program :
#arm-linux-gcc -Wa,-mfpu=fpa11 -mcpu=xscale record.c -lasound -I
/usr/local/arm/3.4.1/include/
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/bin/ld:
cannot find -lasound
collect2: ld returned 1 exit status

Do you have an idea ? Can you help me ?
I want to port a Vumeter, Peakmeter and other audio tools on hx4700.

Thank you

-- 
K
