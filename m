From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: SALSA library in ARM platform
Date: Thu, 21 Jun 2007 10:58:30 +0530
Message-ID: <8d6898730706202228q39f7019bja07d158b672665f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id A4D1D103802
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 07:28:31 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so196086wag
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 22:28:30 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
 I tried compiling SALSA for ARM. I got few errors.

CC=arm-none-linux-gnueabi-gcc ./configure --target=arm-linux
--host=i386 --prefix=/usr


make

Then I am getting following errors See the bottom part


/bin/bash ../libtool --tag=CC   --mode=compile
arm-none-linux-gnueabi-gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\"
-DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
-DPACKAGE=\"salsa-lib\" -DVERSION=\"0.0.1\" -DSTDC_HEADERS=1
-DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1
-DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1
-DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1
-DHAVE_DLFCN_H=1 -DSTDC_HEADERS=1 -I.    -Wall -g -g -O2 -MT mixer.lo
-MD -MP -MF .deps/mixer.Tpo -c -o mixer.lo mixer.c
 arm-none-linux-gnueabi-gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\"
-DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
-DPACKAGE=\"salsa-lib\" -DVERSION=\"0.0.1\" -DSTDC_HEADERS=1
-DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1
-DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1
-DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1
-DHAVE_DLFCN_H=1 -DSTDC_HEADERS=1 -I. -Wall -g -g -O2 -MT mixer.lo -MD
-MP -MF .deps/mixer.Tpo -c mixer.c -o mixer.o
In file included from hcontrol.h:36,
                 from mixer.h:25,
                 from mixer.c:30:
hctl_macros.h: In function 'snd_hctl_elem_tlv_read':
hctl_macros.h:136: warning: 'snd_ctl_elem_tlv_read' is deprecated
(declared at ctl_macros.h:1131)
hctl_macros.h: In function 'snd_hctl_elem_tlv_write':
hctl_macros.h:142: warning: 'snd_ctl_elem_tlv_write' is deprecated
(declared at ctl_macros.h:1138)
hctl_macros.h: In function 'snd_hctl_elem_tlv_command':
hctl_macros.h:148: warning: 'snd_ctl_elem_tlv_command' is deprecated
(declared at ctl_macros.h:1145)
mv -f .deps/mixer.Tpo .deps/mixer.Plo
/bin/bash ../libtool --tag=CC   --mode=link arm-none-linux-gnueabi-gcc
-Wall -g -g -O2 -version-number 0:0:1  -o libsalsa.la -rpath /usr/lib
control.lo cards.lo pcm.lo pcm_params.lo pcm_misc.lo hcontrol.lo
mixer.lo
mkdir .libs
libtool: link: CURRENT `' must be a nonnegative integer
libtool: link: `0:0:1' is not valid version information
make[1]: *** [libsalsa.la] Error 1
make[1]: Leaving directory `/home/nmathew/Desktop/salsa-lib-0.0.1/src'
make: *** [all-recursive] Error 1
