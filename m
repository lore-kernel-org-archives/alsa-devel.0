From: Raymond <rayau@netvigator.com>
Subject: Re: CVS compile issue
Date: Thu, 11 Aug 2005 19:17:12 +0800
Message-ID: <42FB33B8.8070708@netvigator.com>
References: <1121482166.12420.80.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121482166.12420.80.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
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

There is a "division by zero" warning for drivers which include
"driver.h" on Kernel 2.4


gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa/cvs/alsa-driver/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h
-DKBUILD_BASENAME=intel8x0   -c -o intel8x0.o intel8x0.c
In file included from /alsa/cvs/alsa-driver/include/sound/driver.h:42,
                  from intel8x0.c:29:
/alsa/cvs/alsa-driver/include/adriver.h: In function `jiffies_to_msecs':
/alsa/cvs/alsa-driver/include/adriver.h:639: warning: division by zero

gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa/cvs/alsa-driver/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h
-DKBUILD_BASENAME=au8830   -c -o au8830.o au8830.c
In file included from /alsa/cvs/alsa-driver/include/sound/driver.h:42,
                  from pci-ids.h:1,
                  from au8830.c:1:
/alsa/cvs/alsa-driver/include/adriver.h: In function `jiffies_to_msecs':
/alsa/cvs/alsa-driver/include/adriver.h:639: warning: division by zero



Lee Revell wrote:
> Kernel is 2.6.12-RT-V0.7.51-28.
> 
>   CC [M]  /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o
> In file included from /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c:1:
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c: In function 'snd_ac97_resume':
> /smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2252: sorry, unimplemented: called from here
> /smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
> /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2264: sorry, unimplemented: called from here
> make[4]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o] Error 1
> make[3]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97] Error 2
> make[2]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci] Error 2
> make[1]: *** [_module_/smb/rlrevell/cvs/alsa/alsa-driver] Error 2
> make[1]: Leaving directory `/smb/rlrevell/kernel-source/linux-2.6.12-c3'
> make: *** [compile] Error 2
> 
> Lee
> 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
