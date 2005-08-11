From: Linux Coder <linux@thehoytfamily.com>
Subject: Re: Calls from a custom dynamic shared library call
 the wrong version of alsa functions in libasound
Date: Thu, 11 Aug 2005 08:53:48 -0400
Message-ID: <42FB4A5C.8040107@thehoytfamily.com>
References: <42FAB657.2070307@thehoytfamily.com> <Pine.LNX.4.61.0508111003190.8803@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0508111003190.8803@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thank you. It works.

Jaroslav Kysela wrote:

>On Wed, 10 Aug 2005, Linux Coder wrote:
>
>  
>
>>g++ -fPIC -gstabs+ -O0 -Wall alibtest.cpp
>>g++ -shared -Wl,-soname,libalibtest.so.1 -o libalibtest.so.1.0.1 alibtest.o
>>-lc
>>    
>>
>
>Try add -lasound here, otherwise the linker won't add the necessary 
>versions to external symbols.
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SUSE Labs
>
>
>
>  
>



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
