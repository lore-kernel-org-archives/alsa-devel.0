From: "R. Dresens" <chromisx@nedlinux.nl>
Subject: Detecting new alsa sequencer clients (with some event
 loop) so that i can subscribe them
Date: Tue, 1 Apr 2008 03:48:01 +0200
Message-ID: <20080401034801.7ad2696d.chromisx@nedlinux.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 51CF724822
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 21:52:44 +0200 (CEST)
Received: from [213.51.146.188] (port=51656 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq2.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <chromisx@nedlinux.nl>) id 1JgQ3f-0004JQ-GE
	for alsa-devel@alsa-project.org; Mon, 31 Mar 2008 21:52:43 +0200
Received: from cp20649-a.schoo1.lb.home.nl ([84.30.149.137]:62660 helo=julido)
	by smtp3.tilbu1.nb.home.nl with smtp (Exim 4.60)
	(envelope-from <chromisx@nedlinux.nl>) id 1JgQ3b-0005aE-Oz
	for alsa-devel@alsa-project.org; Mon, 31 Mar 2008 21:52:43 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello,

I'm currently writing an application that will be able to 'auto
subscribe' itself to a certain sequencer client when that client
becomes available to the system. I want (for example) to be able to 
plug in a USB MIDI interface, and when I do that then my application
detects this and does a subscription on it, just like aconnect would
do.

A possible solution is polling; every second or so, i could generate a
list of clients with snd_seq_query_next_client and look for a certain
client name (libpcre comes to mind here;), but I was wondering if there
is a better solution? ..in other words, is it possible to get such
events from the system in a similar way like one would receive regular
MIDI events?

http://www.alsa-project.org/alsa-doc/alsa-lib/structsnd__seq__event.html
list all the events; an interesting one could be snd_seq_connect_t
for monitoring connections on my own ports, but that's not what I'm
looking for. I can't seem to find an event related to this
functionality. Is there something what I'm currently overlooking?

Such functionality may be usefull for GUI versions of aconnect. I
looked in the source of qjackctl (it has an alsa patchbay), but I
haven't found nothing usefull yet since it seems to me that this
software also does polling/refresh on a certain interval.

Has anyone a usefull tip for me?

Thanks in advance,

Greetings,

Raymond Dresens.
