From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch, version II
Date: Wed, 05 Mar 2003 08:38:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qZ2q-00013n-00@sc8-sf-list1.sourceforge.net>
References: <E18qYmT-0003l2-00@sc8-sf-list1.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 05 Mar 2003 08:21:15 EST."
             <E18qYmT-0003l2-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>in short, i am confused :) :(

but ... help is at hand. i checked my mail archives:

>The fifo status counts the number of words waiting in the FIFO. A value of
>128 means that the fifo is full. 0 means the fifo is empty.

OK, so this means that 

    hdsp_fifo_wait (hdsp, 0, some_count);

is waiting till the FIFO is empty. by contrast, 

    hdsp_fifo_wait (hdsp, 127, some_count);

waits till there is 1 word available in the FIFO, meaning that we can
write to it.

this doesn't help explain why we sometimes fail to see this condition
being met. any insights?

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
