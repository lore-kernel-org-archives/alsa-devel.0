From: "Yon Mercury" <swirlee@stickist.com>
Subject: Problem compiling 1.0.7 and 1.0.8rc1 on Linux 2.6.9mm1
Date: Sat, 25 Dec 2004 17:09:35 -0700
Message-ID: <20041226000935.M54684@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi there,

I'm looking for a bit of help compiling alsa from source on my laptop-
kernel is 2.6.9mm1 (w/ preempt patch)--
alsa is 1.0.7 and 1.0.8rc1- both report the same error

I tried with GCC versions 3.2 and 3.3-- to no avail! Here's the error message:

make -C /lib/modules/2.6.9/source SUBDIRS=/usr/src/alsa-driver-1.0.8rc1
O=/lib/modules/2.6.9/build modules
make[1]: Entering directory `/usr/src/linux-2.6.9'
  CC [M]  /usr/src/alsa-driver-1.0.8rc1/acore/memalloc.o
/usr/src/alsa-driver-1.0.8rc1/acore/memalloc.c:53: error: initializer element
is not constant
/usr/src/alsa-driver-1.0.8rc1/acore/memalloc.c:53: error: (near initialization
for `__param_arr_enable.num')
make[4]: *** [/usr/src/alsa-driver-1.0.8rc1/acore/memalloc.o] Error 1
make[3]: *** [/usr/src/alsa-driver-1.0.8rc1/acore] Error 2
make[2]: *** [_module_/usr/src/alsa-driver-1.0.8rc1] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.9'
make: *** [compile] Error 2

Do any of you have an idea where this is coming from?

Thanks,
JP Mercury


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
