From: Andrei Boros <andrei@srr.ro>
Subject: Re: alsa-kernel oss part warnings
Date: Thu, 06 Mar 2003 15:44:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6750B8.865E772@srr.ro>
References: <Pine.LNX.4.44.0303052153400.17739-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dingo.srr.ro ([212.54.107.183])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA11164
	for <alsa-devel@alsa-project.org>; Thu, 6 Mar 2003 14:45:07 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 2.2.23 kernel I get a lot of warnings  like : 
They don't seem to be serious, thougth I'd mention it. 

------------------------------------------------------------------------------------
gcc -D__KERNEL__ -DMODULE=1
-I/serve/install/alsa-cvs/alsa-driver/include  -I/usr/src/linux/include
-O2 -march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=rate   -c -o rate.o rate.c
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:
In function `resample_expand':
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:73:
warning: `S1' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:73:
warning: `S2' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:74:
warning: `src' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:74:
warning: `dst' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:75:
warning: `channel' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:76:
warning: `src_step' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:76:
warning: `dst_step' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:77:
warning: `src_frames1' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:77:
warning: `dst_frames1' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:
In function `resample_shrink':
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:161:
warning: `S1' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:161:
warning: `S2' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:162:
warning: `src' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:162:
warning: `dst' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:164:
warning: `src_step' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:164:
warning: `dst_step' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:165:
warning: `src_frames1' might be used uninitialized in this function
/serve/install/alsa-cvs/alsa-driver/include/../alsa-kernel/core/oss/rate.c:165:
warning: `dst_frames1' might be used uninitialized in this function


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
