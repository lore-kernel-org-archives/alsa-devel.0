From: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Subject: 0.9 ooops... undefined reference to atexit in libm.so.6
Date: Wed, 10 Apr 2002 13:24:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020410132419.A284@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix2-2.free.fr (postfix2-2.free.fr [213.228.0.140])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA10372
	for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2002 13:22:52 +0200
Received: from pengouin (lille-1-a7-62-147-2-130.dial.proxad.net [62.147.2.130])
	by postfix2-2.free.fr (Postfix) with ESMTP id C6E205F7AD
	for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2002 13:22:34 +0200 (CEST)
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

Hello everybody...

Er... After my migration from 0.5 to 0.9, I've tried to recompile my 
application about rawmidi. So, my include is now #include 
<alsa/asoundlib.h>. Compilation is good, but linking says 
"/usr/lib/libm.so.6 : undefined reference to 'atexit' "???

What's goin' on ?

Thanx !

Charles

PS : If I've really understood, it's better to use 0.9 than 0.5, isn't 
it ?
