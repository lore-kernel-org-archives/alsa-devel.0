From: Paul Davis <pbd@op.net>
Subject: Re: another newbie question regarding alsa-api
Date: Sat, 29 Jun 2002 22:47:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17OUj1-0002o6-00@usw-sf-list1.sourceforge.net>
References: <20020630203709.GC20819@pingfm.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 30 Jun 2002 22:37:09 +0200."
             <20020630203709.GC20819@pingfm.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: joy <joy@pingfm.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>just another simple question regarding alsa-api or more. are there any
>advanteges of using alloca functions versus malloc functions without
>of simplyier handling? has it any effect on memory handling?

its not clear that you know what alloca does. it allocates memory from
the stack, not the heap; as a result, it does not need to be
explicitly freed - when the execution frame is popped (i.e. the
function that called alloca returns), the space is reclaimed
"automatically". 

this has nothing to do with ALSA, btw. alloca has been around for many
years.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
