From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: libaoss.so hole?
Date: Fri, 17 Mar 2006 18:49:58 +0100
Message-ID: <441AF6C6.4090706@cubic.org>
References: <7fe205990603170512j58c63e4es@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0D1E1A0
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 18:49:56 +0100 (MET)
In-Reply-To: <7fe205990603170512j58c63e4es@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>     I have an oss application which registers SIGCHLD signal handler
> in the beginning and then opens /dev/dsp, and then forks a child
> process. If the child process dies, the father process would receive a
> SIGCHLD process and then free the allocated resources and then exit.

I don't see any problem here if you did your code right.
1) fork() does return the pid of the child
2) in your SIGCHLD handler call wait(int*) which returns the pid of the 
terminated process.
3) If the pid from fork() and wait() match you can do your cleanup()
4) If they don't match, simply ignore the signal, as some other process 
(probably from the alsa lib) has died.

-- 
---> Dirk Jagdmann ^ doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
