From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: AudioScience driver - need help
Date: Thu, 01 May 2003 22:45:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19BQTB-0004mA-00@sc8-sf-list1.sourceforge.net>
References: <20030501192510.17280.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 01 May 2003 19:25:09 PDT."
             <20030501192510.17280.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have got the job of making an ALSA driver, or at
>least causing it to be made.
>How do I go about getting help from "The ALSA
>development team" (TADT) to write this driver?
>
>Is TADT just the members of this list, or a more
>defined group of people working (more or less) full
>time on the project?  I.e. who do I talk to?

mostly this list. at this time, only jaroslav and takashi work "full
time" on ALSA (paid by SuSE), but there are several other people who
can help with specific issues and questions.

the common path is to find a driver for similar device, and use it as
a template. takashi has also written some basic information on the
"skeleton" of a driver.

>The proposed Licence is based on the Zlib one.
>http://www.gzip.org/zlib/zlib_license.html

i don't believe this will work. although linus allows non-GPL'ed
modules, he doesn't allow non-GPL'ed code into the kernel, and ALSA is
now part of the 2.5/2.6 kernel. in addition, non-GPL'ed modules cannot
access certain kernel symbols.

in general, stuff intended for the linux kernel tends to be either
binary modules or GPL'ed source.

jaroslav may have more or different things to say about it.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
