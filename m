From: Paul Davis <pbd@Op.Net>
Subject: Re: mmap oss support.
Date: Mon, 04 Mar 2002 10:21:51 -0500
Message-ID: <200203042021.PAA18956@renoir.op.net>
In-reply-to: Your message of "Mon, 04 Mar 2002 19:41:09 GMT."
             <NGBBLNODKDFPBFMBBFAFCENCCCAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hello
>Is there any test program which I can use to see if the alsa drivers support
>mmap(memory map) audio out.
>Someone is reporting problems with quake3 and alsa.

quake3 had an alsa output module written for precisely this
reason. AFAIK, there is no reason to use OSS.

BTW, because of quake's use mmap i/o, it has always been broken -
there were plenty of OSS-supported audio interfaces that don't support
mmap access, and quake wouldn't run on them either.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
