From: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Subject: Re: How to send data trough rawmidi ?
Date: Sun, 7 Apr 2002 16:42:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020407164211.E1822@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Received: from postfix1-2.free.fr (postfix1-2.free.fr [213.228.0.130])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA12921
	for <alsa-devel@alsa-project.org>; Sun, 7 Apr 2002 16:40:19 +0200
Received: from pengouin (lille-1-a7-62-147-0-213.dial.proxad.net [62.147.0.213])
	by postfix1-2.free.fr (Postfix) with ESMTP id 08BB5AB765
	for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2002 16:40:13 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> The first argument is input handle, the second is output handle. And
> the
> third
> is the device. 0 is eq to NULL, and I don't think you have a device
> with
> that name.

OK ! So, where could I find the device number ? It is the char-major / 
char-minor of unix dev ?

> And you migth want to have a output handle since you send data.
> And someone  told you. Add error handling checks and then you get to
> know
> on what
> calls fails.

How can I do that ? Sorry, I'm a newbie !!


> foo!

Er... What do you want to say by "foo" ?

Thanx a lot for your help ! I'm working on this project for my 
university, and if this soft don't work, I'm going to do another 
year... HHAARRRGGGHHHH !

Charles
