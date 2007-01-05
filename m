From: Henry Margies <henry.margies@gmx.de>
Subject: best way to transfer PCM data with fragmented buffers
Date: Fri, 05 Jan 2007 11:45:28 +0100
Message-ID: <1167993928.4524.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear Alsa developers,


I would like to take the opportunity and ask you for your best practice
and experience.

I have an AC'97 codec connected via a TDM bus to my CPU. Talking with
the codec is working already, so the control (mixer) interface is
working.

For transferring data between TDM bus and CPU I use DMA of course. The
layout of the buffers is organised in a way, where every AC97 slot has
multiple fragments of continuous memory (up to 2048 bytes per fragment).

For example, I could have 32 pieces of 1024 bytes of memory for left
channel. This would be the same for every channel (16 channels).
So the buffer layout is static once created and the DMA is running all
the time in order to send or receive AC97 commands.

My current way is, to implement the copy and silence callbacks. In copy
I would then copy the data to the "next" fragment. With this solution I
can not support mmap. Also I'm a little bit unsure of the pointer
callback here. Should I implement it? What is it suppose to return?

But the biggest problem here is to synchronise the DMA and the copy
callback somehow. Or do you think it is ok to just write to the next
fragment and let the DMA run freely?

Another way I can imagine is, to have a memory area holding the PCM data
and then copy the data in my interrupt to the next fragment.
Synchronising with DMA would be no problem here and mmap would also be
supported. But to copy data in an interrupt is somehow.. not-DMA-like.
So I don't like that solution so much.


I'm looking forward to learning from your experience. Maybe you have
some hints or an Alsa driver in mind which faced the same problems?



Thanks in advance,

Henry


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
