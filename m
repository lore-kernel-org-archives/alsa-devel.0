From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: future ALSA development
Date: Mon, 23 Jun 2003 10:18:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306231411.QAA11327@alsa.alsa-project.org>
References: <s5hhe6g3nrx.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail08.voicenet.com (mail08.voicenet.com [207.103.0.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA11327
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 16:11:49 +0200
In-reply-to: Your message of "Mon, 23 Jun 2003 15:51:30 +0200."
             <s5hhe6g3nrx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>btw, what was the biggest reason to change to XML in ardour?
>it used guile once upon a time.

i didn't like the fact that the entire main() call had to be
encapsulated within a guile invocation (given what ardour does with
memory, threads, scheduling, etc, etc). i also didn't like having to
require guile be installed, and lastly, perhaps most importantly,
ardour was going to use XML for data files (session state information
etc) to further inter-operability, and so we decided to switch to XML
throughout.

>this can be implemented better once when we have an ordinary-mixer
>API.  the problem was that the action to do is different for each
>card, and it's not abstracted (nor unified) so far.
>the higher abstraction will absorb such a difference.

understood. i'd just to see this as a goal of whatever changes you
make. 


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
