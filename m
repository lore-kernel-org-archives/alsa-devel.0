From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 08:18:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19GHcA-000164-00@sc8-sf-list1.sourceforge.net>
References: <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 May 2003 10:23:41 +0200."
             <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Vollmer <remllov_@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am trying to use the mmap access method together with an async_handler 
>function (ice1712 in multitrack mode),

i just want to remind anyone using the async handlers that the list of
system calls you can make in an async handler is extremely
limited. make sure you limit yourself to that list.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
