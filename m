From: Linux Coder <linux@thehoytfamily.com>
Subject: Re: Calls from a custom dynamic shared library call
 the wrong version of alsa functions in libasound
Date: Wed, 10 Aug 2005 22:35:34 -0400
Message-ID: <42FAB976.6060505@thehoytfamily.com>
References: <42FAB657.2070307@thehoytfamily.com> <1123727292.30766.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123727292.30766.0.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


        linux-gate.so.1 =>  (0xffffe000)
        libasound.so.2 => /usr/lib/libasound.so.2 (0x4f9ca000)
        libalibtest.so.1 => ./libalibtest.so.1 (0xb7fed000)
        libstdc++.so.5 => /usr/lib/libstdc++.so.5 (0x001ae000)
        libm.so.6 => /lib/tls/libm.so.6 (0x00c4f000)
        libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x00de9000)
        libc.so.6 => /lib/tls/libc.so.6 (0x00b2c000)
        libdl.so.2 => /lib/libdl.so.2 (0x00c49000)
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x00d84000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x00b13000)

I thought that was the problem too and thus I made sure no where else on 
my hard drive was another version of alsa.  I also downloaded the latest 
and rebuilt it.

Looking at the ALSA stuff, ALSA library supports an older API and thus 
the library has the current API and the "old" API.  By setting some 
defines you can include the old API and use the old API calling 
structure.  I made sure I was not including the old API but putting 
#warning in the pcm_old.h.

Since I can switch between shared and static and the problem only shows 
up in shared, the dynamic linker, I believe, is resolving to the wrong call.





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
