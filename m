From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001738]: how to install alsa-lib on linux 2.6.14 (ARM architecture )
Date: Wed, 11 Jan 2006 14:35:41 +0100
Message-ID: <8db55af7e2e70ef8f94ca841d8658ec0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D15E412B
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 14:35:41 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1738> 
======================================================================
Reported By:                boryx
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1738
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-11-2006 14:35 CET
Last Modified:              01-11-2006 14:35 CET
======================================================================
Summary:                    how to install alsa-lib on linux 2.6.14 (ARM
architecture )
Description: 
I have arm-unknown-linux-gnu compilator. 

./configure --prefix=linux_dir --host=arm-unknown-linux-gnu
make install

..
..
..

Making install in aserver
make[1]: Entering directory
`/root/linux_kernel/alsa-lib-1.0.9rc4/aserver'
/bin/sh ../libtool --mode=link arm-unknown-linux-gnu-gcc  -g -O2   -o
aserver  a                                                server.o
../src/libasound.la
arm-unknown-linux-gnu-gcc -g -O2 -o aserver aserver.o 
../src/.libs/libasound.a                                                
-lm -ldl -lpthread
/usr/local/arm-unknown-linux-gnu-3.4.4/arm-unknown-linux-gnu/bin/../lib/gcc/arm-
                                              
unknown-linux-gnu/3.4.4/../../../../arm-unknown-linux-gnu/bin/ld:
../src/.libs/l                                               
ibasound.a(conf.o): Relocations in generic ELF (EM: 3)
../src/.libs/libasound.a: could not read symbols: File in wrong format
collect2: ld returned 1 exit status
make[1]: *** [aserver] Error 1
make[1]: Leaving directory `/root/linux_kernel/alsa-lib-1.0.9rc4/aserver'
make: *** [install-recursive] Error 1


there are file libasound.a in directory linux_dir/lib  
but when i try to link it to my program 

"skipping incomatible" error occurs





======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 14:35 boryx          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
