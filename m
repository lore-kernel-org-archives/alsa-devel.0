From: Paul Davis <pbd@op.net>
Subject: Re: Multiple PCM files
Date: Tue, 30 Jul 2002 09:18:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17ZWsC-00059P-00@usw-sf-list1.sourceforge.net>
References: <103b01c237c4$08e15ce0$360110ac@dillon>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 30 Jul 2002 13:24:21 BST."
             <103b01c237c4$08e15ce0$360110ac@dillon>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Nick French <nick@greensignal.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>So does JACKs allow two separate applications to stream PCM audio at the
>same time to the same device and if so will it then overlay them? If it will
>why would two threads each registering with JACKs not work.

it might, but it would be very inefficient. every JACK connection
requires a new thread in the client, and implies an IPC per client per
process() callback cycle.

the code to mix down your own threads' output buffers is a few
lines. why bother with anything else?

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
