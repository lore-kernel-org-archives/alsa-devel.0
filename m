From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Development Question
Date: Tue, 20 Mar 2007 09:12:23 +0100
Message-ID: <1174378343.6231.1180356935@webmail.messagingengine.com>
References: <BAY120-F107E83F9DDD0189BB6554C9C750@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <BAY120-F107E83F9DDD0189BB6554C9C750@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "M. Gagnon" <fire_void@hotmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

M. Gagnon wrote:
> >What is the output of the program?
> 
> pending events size: 28
> pending events size: 56
> pending events size: 84
> ...
> BEFORE DRAIN: pending events size: 476
> AFTER DRAIN: pending events size: 0

Looks OK.  In theory, all events should be sent somewhere.

Please run aseqdump and send the events to its port.  What does it
output?

> >What are the contents of /proc/asound/seq/queues and .../timers while it's
> >trying to play?
> 
> i'm sorry, but despite some googling this still sounds esoteric to me.

These are just file names.  Run "cat /proc/asound/seq/queues" and
"cat /proc/asound/seq/timer".


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
