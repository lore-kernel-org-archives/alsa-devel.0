From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: oops with current ALSA CVS + gcc3
Date: Wed, 05 Mar 2003 14:34:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E65FCF0.6090504@gmx.li>
References: <E18qYp7-0004tg-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18qYp7-0004tg-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>did you compile the kernel itself with the same gcc?
>>the combination of gcc-2.x and gcc-3.x on the kernel space will likely
>>cause oops.
> 
> 
> no, i knew about that issue, and thats why i had to recompile
> everything. i am tempted to go back to my older ALSA CVS tree (i
> tar'ed it before fetching current CVS) and see what happens.
> 

Just FYI. On my gentoo-1.4 everything compiles and runs fine (via82xx, 
usb-audio, dummy, virmidi)

maybe this helps:
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/specs
Configured with: /var/tmp/portage/gcc-3.2.2-r3/work/gcc-3.2.2/configure 
--prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.2 
--includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include 
--datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2 
--mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/man 
--infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/info --enable-shared 
--host=i686-pc-linux-gnu --target=i686-pc-linux-gnu --with-system-zlib 
--enable-languages=c,c++,ada,f77,objc,java --enable-threads=posix 
--enable-long-long --disable-checking --enable-cstdio=stdio 
--enable-clocale=generic --enable-__cxa_atexit 
--enable-version-specific-runtime-libs 
--with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include/g++-v3 
--with-local-prefix=/usr/local --enable-shared --enable-nls 
--without-included-gettext
Thread model: posix
gcc version 3.2.2

have fun*

Niklas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
