From: "Bruce Teng" <support@sunrichrd.com.hk>
Subject: ALSA driver installation issue in Ubuntu 10.04 OS
Date: Wed, 10 Dec 2014 16:42:04 +0800
Message-ID: <003401d01455$2c812060$85836120$@sunrichrd.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mg2.smartecserver.com (mg2.smartecserver.com [103.20.60.244])
 by alsa0.perex.cz (Postfix) with ESMTP id DB10A260320
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 09:42:23 +0100 (CET)
Received: from relay5.ecinfohk.com ([172.16.100.21]) by mg2.smartecserver.com
 with ESMTP id D4HXoljMOlopxXlV for <alsa-devel@alsa-project.org>;
 Wed, 10 Dec 2014 16:42:06 +0800 (HKT)
Received: from mail3.hosting.net.hk ([10.100.2.59])
 by relay5.ecinfohk.com (IceWarp 10.4.5) with ESMTP id 201412101642041392
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 16:42:04 +0800
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sir,

   I've encountered the following error when run the
"alsa-utils-alsa-compile.sh" on Ubuntu 10.04 with 2.6.32 kernel OS:

 

  _____  

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
127: warning: initialization from incompatible pointer type

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
132: warning: initialization from incompatible pointer type

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
In function 'set_pages_array_wc':

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
700: error: implicit declaration of function 'set_pages_wc'

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
At top level:

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
703: error: conflicting types for 'set_pages_array_wb'

/usr/src/linux-headers-2.6.32-21-generic/arch/x86/include/asm/cacheflush.h:1
44: note: previous declaration of 'set_pages_array_wb' was here

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
In function 'param_set_xint':

/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.c:
2937: warning: passing argument 2 of 'param_set_int' discards qualifiers
from pointer target type

include/linux/moduleparam.h:177: note: expected 'struct kernel_param *' but
argument is of type 'const struct kernel_param *'

make[4]: ***
[/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda/hda_intel.o
] Error 1

make[3]: ***
[/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci/hda] Error 2

make[2]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/pci]
Error 2

make[1]: ***
[_module_/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d] Error 2

make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-21-generic'

make: *** [compile] Error 2

Working directory /tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d.

Compilation of alsa-driver failed.

Report this problem to the <alsa-devel@alsa-project.org> mailing list.

  _____  

 

Could you help to look into this issue?

 

Thanks!

Bruce

 
