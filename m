From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Building alsa with kernel 2.6 when O= option used.
Date: Thu, 22 Jul 2004 18:59:18 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040722185919.9021.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

should I be able to build alsa 1.0.5 if I have built the kernel as follows?
#cd /usr/src/linux
#make O=~/build/mykernel

ALSA make fails like this
>make -C /lib/modules/2.6.3-13mdk/build
>SUBDIRS=/home/eliot/src/alsa-1.0.5/alsa-driver-1.0.5a/kbuild modules
>make[1]: Entering directory `/usr/src/linux-2.6.3-13mdk'
>Makefile:395: .config: No such file or directory

How do I tell the alsa build process where my kernel config files are?

I tried --with-kernel=dir, but that is for the sources.
Its only the .config , version.h etc that is in a separate directory

- Eliot


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
