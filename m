From: Paul Davis <pbd@op.net>
Subject: Re: Why do I get broken pipe on write to a pcm in state PREPARED?
Date: Wed, 11 Sep 2002 16:14:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17pDpC-0005FU-00@usw-sf-list1.sourceforge.net>
References: <200209111926.g8BJQr013561@d1o87.telia.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 11 Sep 2002 21:26:53 +0200."
             <200209111926.g8BJQr013561@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Is it possible to adjust a stop threshold or something to get my 
>desired behaviour?

i think you should have set the start mode to START_DATA and the start
threshold appropriately. then the device would have started as soon as
the buffer was full.

--p



-------------------------------------------------------
In remembrance
www.osdn.com/911/
